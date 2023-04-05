/*
  Warnings:

  - You are about to drop the `UserDaoFollow` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "UserDaoFollow" DROP CONSTRAINT "UserDaoFollow_daoId_fkey";

-- DropForeignKey
ALTER TABLE "UserDaoFollow" DROP CONSTRAINT "UserDaoFollow_userId_fkey";

-- DropTable
DROP TABLE "UserDaoFollow";

-- CreateTable
CREATE TABLE "WalletDaoFollow" (
    "daoId" INTEGER NOT NULL,
    "walletId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "WalletDaoFollow_pkey" PRIMARY KEY ("daoId","walletId")
);

-- AddForeignKey
ALTER TABLE "WalletDaoFollow" ADD CONSTRAINT "WalletDaoFollow_walletId_fkey" FOREIGN KEY ("walletId") REFERENCES "Wallet"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WalletDaoFollow" ADD CONSTRAINT "WalletDaoFollow_daoId_fkey" FOREIGN KEY ("daoId") REFERENCES "Dao"("id") ON DELETE CASCADE ON UPDATE CASCADE;
