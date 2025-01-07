import { APIGatewayProxyEvent } from "aws-lambda";
import { STATUS_CODE } from "../../../constants";
import { response } from "../../../utils/responseHandler";

export const updateFolder = async (event: APIGatewayProxyEvent) => {
  return response({ status: STATUS_CODE.NOT_IMPLEMENTED });
};
