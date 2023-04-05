/*
  Warnings:

  - Added the required column `unicode` to the `Emoji` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Emoji" ADD COLUMN     "unicode" TEXT NOT NULL;
