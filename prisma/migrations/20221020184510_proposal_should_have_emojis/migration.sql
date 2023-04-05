/*
  Warnings:

  - You are about to drop the `UserDaoEmoji` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "UserDaoEmoji" DROP CONSTRAINT "UserDaoEmoji_daoId_fkey";

-- DropForeignKey
ALTER TABLE "UserDaoEmoji" DROP CONSTRAINT "UserDaoEmoji_emojiId_fkey";

-- DropForeignKey
ALTER TABLE "UserDaoEmoji" DROP CONSTRAINT "UserDaoEmoji_userId_fkey";

-- DropTable
DROP TABLE "UserDaoEmoji";

-- CreateTable
CREATE TABLE "UserProposalEmoji" (
    "proposalId" INTEGER NOT NULL,
    "userId" TEXT NOT NULL,
    "emojiId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "UserProposalEmoji_pkey" PRIMARY KEY ("proposalId","userId")
);

-- AddForeignKey
ALTER TABLE "UserProposalEmoji" ADD CONSTRAINT "UserProposalEmoji_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserProposalEmoji" ADD CONSTRAINT "UserProposalEmoji_proposalId_fkey" FOREIGN KEY ("proposalId") REFERENCES "Proposal"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserProposalEmoji" ADD CONSTRAINT "UserProposalEmoji_emojiId_fkey" FOREIGN KEY ("emojiId") REFERENCES "Emoji"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
