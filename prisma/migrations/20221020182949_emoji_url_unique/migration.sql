-- CreateTable
CREATE TABLE "Emoji" (
    "id" SERIAL NOT NULL,
    "url" TEXT NOT NULL,

    CONSTRAINT "Emoji_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserDaoEmoji" (
    "daoId" INTEGER NOT NULL,
    "userId" TEXT NOT NULL,
    "emojiId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "UserDaoEmoji_pkey" PRIMARY KEY ("daoId","userId")
);

-- CreateIndex
CREATE UNIQUE INDEX "Emoji_url_key" ON "Emoji"("url");

-- AddForeignKey
ALTER TABLE "UserDaoEmoji" ADD CONSTRAINT "UserDaoEmoji_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserDaoEmoji" ADD CONSTRAINT "UserDaoEmoji_daoId_fkey" FOREIGN KEY ("daoId") REFERENCES "Dao"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserDaoEmoji" ADD CONSTRAINT "UserDaoEmoji_emojiId_fkey" FOREIGN KEY ("emojiId") REFERENCES "Emoji"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
