-- CreateEnum
CREATE TYPE "UserRoleEnumType" AS ENUM ('COMMON', 'ADMIN');

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "phone_number" TEXT NOT NULL,
    "avatar" TEXT,
    "role" "UserRoleEnumType" NOT NULL DEFAULT 'COMMON',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "address" (
    "full_address" TEXT NOT NULL,
    "street_name" TEXT NOT NULL,
    "street_number" TEXT NOT NULL,
    "google_placeId" TEXT NOT NULL,
    "lng" DOUBLE PRECISION NOT NULL,
    "lat" DOUBLE PRECISION NOT NULL,
    "state" TEXT NOT NULL,
    "country" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "suburb" TEXT NOT NULL,
    "postcode" VARCHAR(10) NOT NULL,
    "user_id" TEXT NOT NULL,
    "store_id" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "store" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "phone_number" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "user_id" TEXT NOT NULL,
    "address_id" TEXT NOT NULL,

    CONSTRAINT "store_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "product" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "product_image" TEXT NOT NULL,
    "price" INTEGER NOT NULL,
    "whole_sale_price" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "product_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "StoreProduct" (
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "store_id" TEXT NOT NULL,
    "product_id" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "review" (
    "id" TEXT NOT NULL,

    CONSTRAINT "review_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "favourite" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "productId" TEXT NOT NULL,

    CONSTRAINT "favourite_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_ProductToReview" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_ReviewToStore" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "User_phone_number_key" ON "User"("phone_number");

-- CreateIndex
CREATE UNIQUE INDEX "address_user_id_key" ON "address"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "address_store_id_key" ON "address"("store_id");

-- CreateIndex
CREATE UNIQUE INDEX "store_user_id_key" ON "store"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "store_address_id_key" ON "store"("address_id");

-- CreateIndex
CREATE UNIQUE INDEX "StoreProduct_store_id_key" ON "StoreProduct"("store_id");

-- CreateIndex
CREATE UNIQUE INDEX "StoreProduct_product_id_key" ON "StoreProduct"("product_id");

-- CreateIndex
CREATE UNIQUE INDEX "favourite_userId_key" ON "favourite"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "favourite_productId_key" ON "favourite"("productId");

-- CreateIndex
CREATE UNIQUE INDEX "_ProductToReview_AB_unique" ON "_ProductToReview"("A", "B");

-- CreateIndex
CREATE INDEX "_ProductToReview_B_index" ON "_ProductToReview"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_ReviewToStore_AB_unique" ON "_ReviewToStore"("A", "B");

-- CreateIndex
CREATE INDEX "_ReviewToStore_B_index" ON "_ReviewToStore"("B");

-- AddForeignKey
ALTER TABLE "address" ADD CONSTRAINT "address_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "address" ADD CONSTRAINT "address_store_id_fkey" FOREIGN KEY ("store_id") REFERENCES "store"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "store" ADD CONSTRAINT "store_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StoreProduct" ADD CONSTRAINT "StoreProduct_store_id_fkey" FOREIGN KEY ("store_id") REFERENCES "store"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StoreProduct" ADD CONSTRAINT "StoreProduct_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "favourite" ADD CONSTRAINT "favourite_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "favourite" ADD CONSTRAINT "favourite_productId_fkey" FOREIGN KEY ("productId") REFERENCES "product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ProductToReview" ADD CONSTRAINT "_ProductToReview_A_fkey" FOREIGN KEY ("A") REFERENCES "product"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ProductToReview" ADD CONSTRAINT "_ProductToReview_B_fkey" FOREIGN KEY ("B") REFERENCES "review"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ReviewToStore" ADD CONSTRAINT "_ReviewToStore_A_fkey" FOREIGN KEY ("A") REFERENCES "review"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ReviewToStore" ADD CONSTRAINT "_ReviewToStore_B_fkey" FOREIGN KEY ("B") REFERENCES "store"("id") ON DELETE CASCADE ON UPDATE CASCADE;
