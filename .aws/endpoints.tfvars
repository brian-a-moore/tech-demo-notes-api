api_endpoints = {
  folder-create = {
    method          = "POST"
    path            = "/folder"
    integration_uri = "arn:aws:lambda:region:account-id:function:folder_service/invocations"
  }
  folder-update = {
    method          = "PUT"
    path            = "/folder/{folderId}"
    integration_uri = "arn:aws:lambda:region:account-id:function:folder_service/invocations"
  }
  folder-list = {
    method          = "GET"
    path            = "/folder/"
    integration_uri = "arn:aws:lambda:region:account-id:function:folder_service/invocations"
  }
  folder-get = {
    method          = "GET"
    path            = "/folder/{folderId}"
    integration_uri = "arn:aws:lambda:region:account-id:function:folder_service/invocations"
  }
  folder-delete = {
    method          = "DELETE"
    path            = "/folder/{folderId}"
    integration_uri = "arn:aws:lambda:region:account-id:function:folder_service/invocations"
  }
  note-create = {
    method          = "POST"
    path            = "/note"
    integration_uri = "arn:aws:lambda:region:account-id:function:note_service/invocations"
  }
  note-update = {
    method          = "PUT"
    path            = "/note/{noteId}"
    integration_uri = "arn:aws:lambda:region:account-id:function:note_service/invocations"
  }
  note-get = {
    method          = "GET"
    path            = "/note/{noteId}"
    integration_uri = "arn:aws:lambda:region:account-id:function:note_service/invocations"
  }
  note-delete = {
    method          = "DELETE"
    path            = "/note/{noteId}"
    integration_uri = "arn:aws:lambda:region:account-id:function:note_service/invocations"
  }
}