import { FolderItem, FolderRecord, NoteItem, NoteRecord } from '../lambdas/api/db/type';

export const transformFolderToFolderItem = (r: FolderRecord): FolderItem => {
  const [, folderId] = r.PK.split('#');
  return {
    folderId,
    title: r.title,
  };
};

export const transformNoteToNoteItem = (r: NoteRecord): NoteItem => {
  const [, noteId] = r.PK.split('#');
  const [, folderId] = r.SK.split('#');
  return {
    noteId,
    folderId,
    title: r.title,
    body: r.body,
  };
};
