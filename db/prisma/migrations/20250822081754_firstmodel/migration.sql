-- CreateTable
CREATE TABLE "public"."Station" (
    "station_id" INTEGER NOT NULL,
    "city" TEXT,
    "country" TEXT,
    "latitude" DOUBLE PRECISION NOT NULL,
    "longitude" DOUBLE PRECISION NOT NULL,
    "lastUpdated" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Station_pkey" PRIMARY KEY ("station_id")
);

-- CreateTable
CREATE TABLE "public"."Measurement" (
    "id" SERIAL NOT NULL,
    "stationId" INTEGER NOT NULL,
    "parameter" TEXT NOT NULL,
    "value" DOUBLE PRECISION NOT NULL,
    "unit" TEXT NOT NULL,
    "timestamp" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Measurement_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "Station_city_idx" ON "public"."Station"("city");

-- CreateIndex
CREATE INDEX "Station_country_idx" ON "public"."Station"("country");

-- CreateIndex
CREATE INDEX "Measurement_stationId_parameter_timestamp_idx" ON "public"."Measurement"("stationId", "parameter", "timestamp");

-- CreateIndex
CREATE UNIQUE INDEX "Measurement_stationId_parameter_timestamp_key" ON "public"."Measurement"("stationId", "parameter", "timestamp");

-- AddForeignKey
ALTER TABLE "public"."Measurement" ADD CONSTRAINT "Measurement_stationId_fkey" FOREIGN KEY ("stationId") REFERENCES "public"."Station"("station_id") ON DELETE RESTRICT ON UPDATE CASCADE;
