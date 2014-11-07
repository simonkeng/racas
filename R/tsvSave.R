#' Save data frames using tsv loader
#' 
#' Saves data frames all in one transaction
#' 
#' @param analysisGroupData A data frame of analysis group values
#' @param treatmentGroupData A data frame of treatment group values
#' @param subjectData A data frame of subject values
#' @param appendCodeName A list with entries "analysisGroupData",
#'   "treatmentGroupData", "subjectData", each has a vector of valuekinds that
#'   should have the code name appended to the front
#
#' @details each of the data frames must have these columns: unitKind, 
#'   valueType, valueKind, numericValue, publicData, 
#'   stateType, stateKind, tempStateId, tempId, lsType, lsKind. Other optional
#'   columns can be found in \link{formatEntityAsTsvAndUpload}
#' 
#' @export
saveAllViaTsv <- function(analysisGroupData, treatmentGroupData, subjectData, appendCodeName = list()) {
  
  sendFiles <- list()
  
  if (!(is.null(appendCodeName$analysisGroup))) {
    analysisGroupData <- appendCodeNames(analysisGroupData, appendCodeName$analysisGroup, "analysis group")
  }
  if (!(is.null(appendCodeName$treatmentGroup))) {
    treatmentGroupData <- appendCodeNames(treatmentGroupData, appendCodeName$treatmentGroup, "treatment group")
  }
  if (!(is.null(appendCodeName$subject))) {
    subjectData <- appendCodeNames(subjectData, appendCodeName$subject, "subject")
  }
  
  # format and save as csv
  
  if (!is.null(analysisGroupData)) {
    analysisGroupDataCsv <- formatEntityAsTsvAndUpload(analysisGroupData)
    sendFiles$analysisGroupCsvFilePath <- analysisGroupDataCsv
  }
  if (!is.null(treatmentGroupData)) {
    treatmentGroupDataCsv <- formatEntityAsTsvAndUpload(treatmentGroupData)
    sendFiles$treatmentGroupCsvFilePath <- treatmentGroupDataCsv
  }
  if (!is.null(subjectData)) {
    subjectDataCsv <- formatEntityAsTsvAndUpload(subjectData)
    sendFiles$subjectCsvFilePath <- subjectDataCsv
  }
  
  response <- postURLcheckStatus(
    paste0(racas::applicationSettings$client.service.persistence.fullpath, 
           "api/v1/experiments/analysisgroup/savefromtsv"),
    postfields=toJSON(sendFiles),
    httpheader=c('Content-Type'='application/json')
  )
}

#' Appends code names to supplied valueKinds
#' 
#' @param entityData data.frame that will be changed
#' @param valueKinds vector of valueKinds to have stringValues changed
#' @param entitySpaced the name of the entity: "analysis group" or "treatment
#'   group" or "subject"
#'   
#' @details not for export, used only by saveAllViaTsv
appendCodeNames <- function(entityData, valueKinds, entitySpaced) {
  thingTypeAndKind <- paste0("document_", entitySpaced)
  entityCodeNameList <- unlist(getAutoLabels(thingTypeAndKind = thingTypeAndKind, 
                                             labelTypeAndKind = "id_codeName", 
                                             numberOfLabels = max(entityData$tempId)),
                               use.names = FALSE)
  
  entityData$codeName <- entityCodeNameList[entityData$tempId]
  
  # Adding codeNames to analysisGroupStrings listed in appendCodeNames (e.g. curve id)
  newStrings <- paste0(entityData$stringValue[entityData$valueKind %in% valueKinds], 
                       "_", entityData[entityData$valueKind == valueKinds, "codeName"])
  entityData$stringValue[entityData$valueKind %in% valueKinds] <- newStrings
  
  return(entityData)
}

#' Save data using tsv
#' 
#' Saves data frames to a tsv and uploads to persistence server
#' 
#' @param entityData data.frame with set of columns- see code for list
#
#' @details Assumes all data is new, not saving to existing entities
#' 
#' @return path to file on persistence server
#' 
#' @export
formatEntityAsTsvAndUpload <- function(entityData) {
  entityDataFormatted <- data.frame(
    tempValueId = NA,
    valueType = entityData$valueType,
    valueKind = entityData$valueKind,
    numericValue = entityData$numericValue,
    sigFigs = naIfNull(entityData$sigFigs),
    uncertainty = naIfNull(entityData$uncertainty),
    numberOfReplicates = naIfNull(entityData$numberOfReplicates),
    uncertaintyType = naIfNull(entityData$uncertaintyType),
    stringValue = naIfNull(entityData$stringValue),
    dateValue = naIfNull(entityData$dateValue),
    clobValue = naIfNull(entityData$clobValue),
    urlValue = naIfNull(entityData$urlValue),
    fileValue = naIfNull(entityData$fileValue),
    codeType = NA,
    codeKind = NA,
    codeValue = naIfNull(entityData$codeValue),
    unitType = NA,
    unitKind = naIfNull(entityData$unitKind),
    operatorType = NA,
    operatorKind = naIfNull(entityData$operatorKind),
    publicData = entityData$publicData,
    comments = naIfNull(entityData$comments),
    stateType = entityData$stateType,
    stateKind = entityData$stateKind,
    tempStateId = entityData$tempStateId,
    stateId = NA,
    id = NA,
    tempId = entityData$tempId,
    parentId = naIfNull(entityData$parentId),
    tempParentId = naIfNull(entityData$tempParentId),
    lsTransaction = naIfNull(entityData$lsTransaction),
    recordedBy = naIfNull(entityData$recordedBy),
    codeName = naIfNull(entityData$codeName),
    lsType = entityData$lsType,
    lsKind = entityData$lsKind
  )
  
  # Create temporary file to send to persistence server
  csvFile <- tempfile(pattern = "csvUpload", tmpdir = "", fileext = ".csv")
  csvLocalLocation <- paste0(tempdir(), csvFile)
  
  write.table(entityDataFormatted, file = csvLocalLocation, sep="\t", na = "", row.names = FALSE)
  
  tryCatch({
    response <- fromJSON(postForm(paste0(racas::applicationSettings$server.service.persistence.fileUrl), 
                      fileData = (fileUpload(csvLocalLocation, contentType = "text/plain"))))
  }, error = function (e) {
    stopUser("Internal: Could not send tsv file to server, make sure upload server is running.")
  })
  
  
  tsvServerLocation <- file.path(racas::applicationSettings$server.service.persistence.filePath, response[[1]]$name)
  return(tsvServerLocation)
}

#' Turn NULL into NA
#' 
#' Useful for changing objects to data frames
#' 
#' @param x input
#' 
#' @details will return the input for any value other than NULL
#' 
#' @export
naIfNull <- function(x) {
  if (is.null(x)) {
    return(NA)
  } else {
    return(x)
  }
}