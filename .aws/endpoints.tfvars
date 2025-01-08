api_endpoints = {
  folder-create = {
    method          = "POST"
    path            = "/folder"
    integration_uri = "arn:aws:lambda:${var.aws_region}:${var.aws_account_id}:function:folder_service"
  }
  folder-update = {
    method          = "PUT"
    path            = "/folder/{folderId}"
    integration_uri = "arn:aws:lambda:${var.aws_region}:${var.aws_account_id}:function:folder_service"
  }
  folder-list = {
    method          = "GET"
    path            = "/folder/"
    integration_uri = "arn:aws:lambda:${var.aws_region}:${var.aws_account_id}:function:folder_service"
  }
  folder-get = {
    method          = "GET"
    path            = "/folder/{folderId}"
    integration_uri = "arn:aws:lambda:${var.aws_region}:${var.aws_account_id}:function:folder_service"
  }
  folder-delete = {
    method          = "DELETE"
    path            = "/folder/{folderId}"
    integration_uri = "arn:aws:lambda:${var.aws_region}:${var.aws_account_id}:function:folder_service"
  }
  note-create = {
    method          = "POST"
    path            = "/note"
    integration_uri = "arn:aws:lambda:${var.aws_region}:${var.aws_account_id}:function:note_service"
  }
  note-update = {
    method          = "PUT"
    path            = "/note/{noteId}"
    integration_uri = "arn:aws:lambda:${var.aws_region}:${var.aws_account_id}:function:note_service"
  }
  note-get = {
    method          = "GET"
    path            = "/note/{noteId}"
    integration_uri = "arn:aws:lambda:${var.aws_region}:${var.aws_account_id}:function:note_service"
  }
  note-delete = {
    method          = "DELETE"
    path            = "/note/{noteId}"
    integration_uri = "arn:aws:lambda:${var.aws_region}:${var.aws_account_id}:function:note_service"
  }
}