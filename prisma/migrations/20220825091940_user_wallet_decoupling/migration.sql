-- CreateTable
CREATE TABLE "Wallet" (
    "id" SERIAL NOT NULL,
    "userId" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "ens" VARCHAR(255),

    CONSTRAINT "Wallet_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Wallet" ADD CONSTRAINT "Wallet_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- Popoulate Wallet table
INSERT INTO "Wallet" ("userId", "address", "ens")
  SELECT "id" as "userId", "walletAddress" as "address", "ens" FROM "User";

-- AlterTable
ALTER TABLE "User" DROP COLUMN "ens",
  DROP COLUMN "walletAddress";
