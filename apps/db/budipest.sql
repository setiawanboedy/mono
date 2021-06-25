CREATE EXTENSION pgcrypto;
CREATE TYPE "user_role" AS ENUM ('admin', 'user', 'guest');
CREATE TYPE "entry_method" AS ENUM ('price', 'free', 'consumers', 'code');
CREATE TYPE "category" AS ENUM (
    'general',
    'restaurant',
    'gas_station',
    'shop',
    'portable'
);
CREATE TYPE "vote" AS ENUM ('like', 'dislike');
CREATE TABLE "toilets" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "user_id" uuid NOT NULL,
    "name" varchar NOT NULL,
    "category" category NOT NULL,
    "entry_method" entry_method NOT NULL,
    "code" varchar,
    "wheelchair_accessible" boolean DEFAULT false,
    "baby_room" boolean DEFAULT false,
    "price_huf" numeric,
    "price_eur" numeric,
    "latitude" numeric,
    "longitude" numeric,
    "open_hours" int [],
    "created_at" timestamptz NOT NULL DEFAULT (now() at time zone 'utc'),
    "updated_at" timestamptz,
    "deleted_at" timestamptz
);
CREATE TABLE "votes" (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "toilet_id" uuid NOT NULL,
    "user_id" uuid NOT NULL,
    "value" vote NOT NULL,
    "created_at" timestamptz NOT NULL DEFAULT (now() at time zone 'utc'),
    "updated_at" timestamptz,
    "deleted_at" timestamptz
);
CREATE TABLE "notes" (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "toilet_id" uuid NOT NULL,
    "user_id" uuid NOT NULL,
    "note" text NOT NULL,
    "created_at" timestamptz NOT NULL DEFAULT (now() at time zone 'utc'),
    "updated_at" timestamptz,
    "deleted_at" timestamptz
);
CREATE TABLE "users" (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "username" varchar UNIQUE NOT NULL,
    "password" varchar,
    "role" user_role NOT NULL,
    "created_at" timestamptz NOT NULL DEFAULT (now() at time zone 'utc'),
    "updated_at" timestamptz,
    "deleted_at" timestamptz
);
ALTER TABLE "votes"
ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE;
ALTER TABLE "votes"
ADD FOREIGN KEY ("toilet_id") REFERENCES "toilets" ("id") ON DELETE CASCADE;
ALTER TABLE "toilets"
ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE;
ALTER TABLE "notes"
ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE;
ALTER TABLE "notes"
ADD FOREIGN KEY ("toilet_id") REFERENCES "toilets" ("id") ON DELETE CASCADE;