export enum HTTP_METHOD {
  DELETE = "DELETE",
  GET = "GET",
  POST = "POST",
  PUT = "PUT",
}

export enum STATUS_CODE {
  OKAY = 200,
  NOT_FOUND = 404,
  METHOD_NOT_ALLOWED = 405,
  SERVER_ERROR = 500,
  NOT_IMPLEMENTED = 501,
}

export type DynamoRecord = {
  PK: string;
  SK: string;
  createdAt: number;
  updatedAt: number;
};
