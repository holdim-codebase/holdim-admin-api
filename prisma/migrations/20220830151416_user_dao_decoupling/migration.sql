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

-- Populate
INSERT INTO "WalletDaoFollow" ("daoId", "walletId")
  SELECT "daoId", "walletId" FROM (
    SELECT "UserDaoFollow"."daoId" as "daoId", "Wallet"."id" as "walletId"
    FROM "UserDaoFollow"
    JOIN "Wallet" ON "Wallet"."userId" = "UserDaoFollow"."userId"
  ) as "tmp";

-- DropTable
DROP TABLE "UserDaoFollow";
