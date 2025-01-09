import dynamoose from 'dynamoose';

const FolderSchema = new dynamoose.Schema(
  {
    PK: {
      type: String,
      hashKey: true,
    },
    SK: {
      type: String,
      rangeKey: true,
    },
    title: String,
  },
  {
    saveUnknown: false,
    timestamps: true,
  },
);

export const FolderModel = dynamoose.model(process.env.DB_NAME as string, FolderSchema, {
  create: false,
});

const NoteSchema = new dynamoose.Schema(
  {
    PK: {
      type: String,
      hashKey: true,
    },
    SK: {
      type: String,
      rangeKey: true,
    },
    title: String,
    body: String,
  },
  {
    saveUnknown: false,
    timestamps: true,
  },
);

export const NoteModel = dynamoose.model(process.env.DB_NAME as string, NoteSchema, {
  create: false,
});
