# NOTES API

This is a technical demonstration app designed to show profeciency with AWS Services, Terraform, GitHub Actions, Typescript and more.

## Technical Requirements

Build an API with the following tools:

- [ ] Create a serverless API application with the following features:
  - [ ] Ability to create, edit, update and delete folders
  - [ ] Ability to create, edit update and delete notes
  - [ ] Ability to add notes to folders
  - [ ] Ability to move notes between folders
- [ ] The application should be deployed with Terraform
- [ ] The application code should be written in Node.JS with Typescript
- [ ] The API should be managed by AWS API Gateway
- [ ] The API should be authorized with AWS Cognito and user pools
- [ ] The application code should be deployed via AWS Lambdas
- [ ] The lambdas should be broken into two services:
  - [ ] Folder Service
  - [ ] Note Service
- [ ] Each service lambda should use Middy for routing and middleware
- [ ] Each service endpoint should be validated with Zod
- [ ] Each service should use common middleware from a root level middleware folder
- [ ] Each service should use common utilities from a root level utils folder
- [ ] Each service should be packaged with Serverless Framework
- [ ] The folders and notes should be stored in DynamoDB
  - [ ] The table should be architected to use a composite key design to show relations between folders and notes
- [ ] The API hould be documented with Swagger
- [ ] Deployment should be handled via GitHub Actions
