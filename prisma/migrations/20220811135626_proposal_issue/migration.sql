/*
  Warnings:

  - A unique constraint covering the columns `[issueNumber]` on the table `Proposal` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "Proposal" ADD COLUMN     "issueNumber" INTEGER;

-- CreateIndex
CREATE UNIQUE INDEX "Proposal_issueNumber_key" ON "Proposal"("issueNumber");

UPDATE "Proposal" SET "issueNumber" = "id";

CREATE SEQUENCE "proposal_issue_counter";
SELECT setval('proposal_issue_counter', (SELECT MAX(id) + 1 FROM "Proposal"))
