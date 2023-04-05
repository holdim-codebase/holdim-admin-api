/*
  Warnings:

  - You are about to drop the `WalletDaoFollow` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "WalletDaoFollow" DROP CONSTRAINT "WalletDaoFollow_daoId_fkey";

-- DropForeignKey
ALTER TABLE "WalletDaoFollow" DROP CONSTRAINT "WalletDaoFollow_walletId_fkey";

-- DropTable
DROP TABLE "WalletDaoFollow";

-- CreateTable
CREATE TABLE "UserDaoFollow" (
    "daoId" INTEGER NOT NULL,
    "userId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "UserDaoFollow_pkey" PRIMARY KEY ("daoId","userId")
);

-- AddForeignKey
ALTER TABLE "UserDaoFollow" ADD CONSTRAINT "UserDaoFollow_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserDaoFollow" ADD CONSTRAINT "UserDaoFollow_daoId_fkey" FOREIGN KEY ("daoId") REFERENCES "Dao"("id") ON DELETE CASCADE ON UPDATE CASCADE;
