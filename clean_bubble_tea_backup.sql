--
-- PostgreSQL database dump
--

\restrict jvK3tiuGk6vPDbgsMDCA8GxecqDeazFv637A9XGfIazlidSoetGY5IqG9xZcKMR

-- Dumped from database version 15.16 (Debian 15.16-1.pgdg13+1)
-- Dumped by pg_dump version 15.16 (Debian 15.16-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public.product DROP CONSTRAINT product_tenant_id_fkey;
ALTER TABLE ONLY public.product_composition DROP CONSTRAINT product_composition_product_id_fkey;
ALTER TABLE ONLY public.product_composition DROP CONSTRAINT product_composition_ingredient_id_fkey;
ALTER TABLE ONLY public.price_history DROP CONSTRAINT price_history_ingredient_id_fkey;
ALTER TABLE ONLY public.marketing_content DROP CONSTRAINT marketing_content_store_id_fkey;
ALTER TABLE ONLY public.ingredient DROP CONSTRAINT ingredient_tenant_id_fkey;
ALTER TABLE ONLY public.weather_cache DROP CONSTRAINT weather_cache_pkey;
ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
ALTER TABLE ONLY public.tenant DROP CONSTRAINT tenant_pkey;
ALTER TABLE ONLY public.store DROP CONSTRAINT store_pkey;
ALTER TABLE ONLY public.product DROP CONSTRAINT product_pkey;
ALTER TABLE ONLY public.product_composition DROP CONSTRAINT product_composition_pkey;
ALTER TABLE ONLY public.price_history DROP CONSTRAINT price_history_pkey;
ALTER TABLE ONLY public.marketing_content DROP CONSTRAINT marketing_content_pkey;
ALTER TABLE ONLY public.ingredient DROP CONSTRAINT ingredient_pkey;
ALTER TABLE ONLY public.holiday_calendar DROP CONSTRAINT holiday_calendar_pkey;
ALTER TABLE ONLY public.external_trends DROP CONSTRAINT external_trends_pkey;
ALTER TABLE ONLY public.content_image DROP CONSTRAINT content_image_pkey;
ALTER TABLE public.weather_cache ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.tenant ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.product_composition ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.product ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.price_history ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.marketing_content ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.ingredient ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.holiday_calendar ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.external_trends ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.content_image ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE public.weather_cache_id_seq;
DROP TABLE public.weather_cache;
DROP SEQUENCE public.users_id_seq;
DROP TABLE public.users;
DROP SEQUENCE public.tenant_id_seq;
DROP TABLE public.tenant;
DROP TABLE public.store;
DROP SEQUENCE public.product_id_seq;
DROP SEQUENCE public.product_composition_id_seq;
DROP TABLE public.product_composition;
DROP TABLE public.product;
DROP SEQUENCE public.price_history_id_seq;
DROP TABLE public.price_history;
DROP SEQUENCE public.marketing_content_id_seq;
DROP TABLE public.marketing_content;
DROP SEQUENCE public.ingredient_id_seq;
DROP TABLE public.ingredient;
DROP SEQUENCE public.holiday_calendar_id_seq;
DROP TABLE public.holiday_calendar;
DROP SEQUENCE public.external_trends_id_seq;
DROP TABLE public.external_trends;
DROP SEQUENCE public.content_image_id_seq;
DROP TABLE public.content_image;
-- *not* dropping schema, since initdb creates it
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: content_image; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.content_image (
    id integer NOT NULL,
    content_id integer,
    minio_url character varying(255)
);


ALTER TABLE public.content_image OWNER TO postgres;

--
-- Name: content_image_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.content_image_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.content_image_id_seq OWNER TO postgres;

--
-- Name: content_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.content_image_id_seq OWNED BY public.content_image.id;


--
-- Name: external_trends; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.external_trends (
    id integer NOT NULL,
    source_type character varying(50),
    content_summary text,
    recorded_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.external_trends OWNER TO postgres;

--
-- Name: external_trends_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.external_trends_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.external_trends_id_seq OWNER TO postgres;

--
-- Name: external_trends_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.external_trends_id_seq OWNED BY public.external_trends.id;


--
-- Name: holiday_calendar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.holiday_calendar (
    id integer NOT NULL,
    holiday_name character varying(100),
    target_date date,
    countdown_days integer
);


ALTER TABLE public.holiday_calendar OWNER TO postgres;

--
-- Name: holiday_calendar_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.holiday_calendar_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.holiday_calendar_id_seq OWNER TO postgres;

--
-- Name: holiday_calendar_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.holiday_calendar_id_seq OWNED BY public.holiday_calendar.id;


--
-- Name: ingredient; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ingredient (
    id integer NOT NULL,
    tenant_id integer,
    name character varying(255)
);


ALTER TABLE public.ingredient OWNER TO postgres;

--
-- Name: ingredient_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ingredient_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ingredient_id_seq OWNER TO postgres;

--
-- Name: ingredient_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ingredient_id_seq OWNED BY public.ingredient.id;


--
-- Name: marketing_content; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.marketing_content (
    id integer NOT NULL,
    store_id integer,
    platform character varying(50),
    product_name character varying(255),
    final_text text,
    created_at timestamp without time zone,
    "Like" integer
);


ALTER TABLE public.marketing_content OWNER TO postgres;

--
-- Name: marketing_content_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.marketing_content_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.marketing_content_id_seq OWNER TO postgres;

--
-- Name: marketing_content_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.marketing_content_id_seq OWNED BY public.marketing_content.id;


--
-- Name: price_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.price_history (
    id integer NOT NULL,
    ingredient_id integer,
    market_price numeric(10,2),
    change_rate numeric(5,2),
    recorded_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.price_history OWNER TO postgres;

--
-- Name: price_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.price_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.price_history_id_seq OWNER TO postgres;

--
-- Name: price_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.price_history_id_seq OWNED BY public.price_history.id;


--
-- Name: product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product (
    id integer NOT NULL,
    tenant_id integer,
    name character varying(255),
    price numeric(10,2),
    scraped_at timestamp without time zone,
    category character varying(100)
);


ALTER TABLE public.product OWNER TO postgres;

--
-- Name: product_composition; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_composition (
    id integer NOT NULL,
    product_id integer,
    ingredient_id integer
);


ALTER TABLE public.product_composition OWNER TO postgres;

--
-- Name: product_composition_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_composition_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_composition_id_seq OWNER TO postgres;

--
-- Name: product_composition_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_composition_id_seq OWNED BY public.product_composition.id;


--
-- Name: product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_id_seq OWNER TO postgres;

--
-- Name: product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_id_seq OWNED BY public.product.id;


--
-- Name: store; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store (
    id integer NOT NULL,
    tenant_id integer,
    name character varying(100),
    location_city character varying(50)
);


ALTER TABLE public.store OWNER TO postgres;

--
-- Name: tenant; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tenant (
    id integer NOT NULL,
    name character varying(255),
    is_registered boolean DEFAULT false
);


ALTER TABLE public.tenant OWNER TO postgres;

--
-- Name: tenant_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tenant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tenant_id_seq OWNER TO postgres;

--
-- Name: tenant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tenant_id_seq OWNED BY public.tenant.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    store_id integer,
    email character varying(255),
    password_hash character varying(255),
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: weather_cache; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.weather_cache (
    id integer NOT NULL,
    city_name character varying(100),
    condition character varying(50),
    temperature integer,
    recorded_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.weather_cache OWNER TO postgres;

--
-- Name: weather_cache_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.weather_cache_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.weather_cache_id_seq OWNER TO postgres;

--
-- Name: weather_cache_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.weather_cache_id_seq OWNED BY public.weather_cache.id;


--
-- Name: content_image id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_image ALTER COLUMN id SET DEFAULT nextval('public.content_image_id_seq'::regclass);


--
-- Name: external_trends id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.external_trends ALTER COLUMN id SET DEFAULT nextval('public.external_trends_id_seq'::regclass);


--
-- Name: holiday_calendar id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.holiday_calendar ALTER COLUMN id SET DEFAULT nextval('public.holiday_calendar_id_seq'::regclass);


--
-- Name: ingredient id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingredient ALTER COLUMN id SET DEFAULT nextval('public.ingredient_id_seq'::regclass);


--
-- Name: marketing_content id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.marketing_content ALTER COLUMN id SET DEFAULT nextval('public.marketing_content_id_seq'::regclass);


--
-- Name: price_history id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.price_history ALTER COLUMN id SET DEFAULT nextval('public.price_history_id_seq'::regclass);


--
-- Name: product id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product ALTER COLUMN id SET DEFAULT nextval('public.product_id_seq'::regclass);


--
-- Name: product_composition id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_composition ALTER COLUMN id SET DEFAULT nextval('public.product_composition_id_seq'::regclass);


--
-- Name: tenant id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tenant ALTER COLUMN id SET DEFAULT nextval('public.tenant_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: weather_cache id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.weather_cache ALTER COLUMN id SET DEFAULT nextval('public.weather_cache_id_seq'::regclass);


--
-- Data for Name: content_image; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.content_image VALUES (1, 1, 'http://localhost:9000/marketing/image_1.jpeg');
INSERT INTO public.content_image VALUES (2, 2, 'http://localhost:9000/marketing/image_10.png');
INSERT INTO public.content_image VALUES (3, 3, 'http://localhost:9000/marketing/image_100.png');
INSERT INTO public.content_image VALUES (4, 4, 'http://localhost:9000/marketing/image_101.png');
INSERT INTO public.content_image VALUES (5, 5, 'http://localhost:9000/marketing/image_102.jpeg');
INSERT INTO public.content_image VALUES (6, 6, 'http://localhost:9000/marketing/image_103.png');
INSERT INTO public.content_image VALUES (7, 7, 'http://localhost:9000/marketing/image_104.png');
INSERT INTO public.content_image VALUES (8, 8, 'http://localhost:9000/marketing/image_105.png');
INSERT INTO public.content_image VALUES (9, 9, 'http://localhost:9000/marketing/image_106.jpeg');
INSERT INTO public.content_image VALUES (10, 10, 'http://localhost:9000/marketing/image_107.png');
INSERT INTO public.content_image VALUES (11, 11, 'http://localhost:9000/marketing/image_108.jpeg');
INSERT INTO public.content_image VALUES (12, 12, 'http://localhost:9000/marketing/image_109.png');
INSERT INTO public.content_image VALUES (13, 13, 'http://localhost:9000/marketing/image_11.png');
INSERT INTO public.content_image VALUES (14, 14, 'http://localhost:9000/marketing/image_110.png');
INSERT INTO public.content_image VALUES (15, 15, 'http://localhost:9000/marketing/image_111.png');
INSERT INTO public.content_image VALUES (16, 16, 'http://localhost:9000/marketing/image_112.png');
INSERT INTO public.content_image VALUES (17, 17, 'http://localhost:9000/marketing/image_113.png');
INSERT INTO public.content_image VALUES (18, 18, 'http://localhost:9000/marketing/image_114.png');
INSERT INTO public.content_image VALUES (19, 19, 'http://localhost:9000/marketing/image_115.png');
INSERT INTO public.content_image VALUES (20, 20, 'http://localhost:9000/marketing/image_116.jpeg');
INSERT INTO public.content_image VALUES (21, 21, 'http://localhost:9000/marketing/image_117.png');
INSERT INTO public.content_image VALUES (22, 22, 'http://localhost:9000/marketing/image_118.png');
INSERT INTO public.content_image VALUES (23, 23, 'http://localhost:9000/marketing/image_119.png');
INSERT INTO public.content_image VALUES (24, 24, 'http://localhost:9000/marketing/image_12.png');
INSERT INTO public.content_image VALUES (25, 25, 'http://localhost:9000/marketing/image_120.png');
INSERT INTO public.content_image VALUES (26, 26, 'http://localhost:9000/marketing/image_121.png');
INSERT INTO public.content_image VALUES (27, 27, 'http://localhost:9000/marketing/image_122.png');
INSERT INTO public.content_image VALUES (28, 28, 'http://localhost:9000/marketing/image_123.png');
INSERT INTO public.content_image VALUES (29, 29, 'http://localhost:9000/marketing/image_124.png');
INSERT INTO public.content_image VALUES (30, 30, 'http://localhost:9000/marketing/image_125.png');
INSERT INTO public.content_image VALUES (31, 31, 'http://localhost:9000/marketing/image_126.png');
INSERT INTO public.content_image VALUES (32, 32, 'http://localhost:9000/marketing/image_127.jpeg');
INSERT INTO public.content_image VALUES (33, 33, 'http://localhost:9000/marketing/image_128.png');
INSERT INTO public.content_image VALUES (34, 34, 'http://localhost:9000/marketing/image_129.jpeg');
INSERT INTO public.content_image VALUES (35, 35, 'http://localhost:9000/marketing/image_13.jpeg');
INSERT INTO public.content_image VALUES (36, 36, 'http://localhost:9000/marketing/image_130.jpeg');
INSERT INTO public.content_image VALUES (37, 37, 'http://localhost:9000/marketing/image_131.png');
INSERT INTO public.content_image VALUES (38, 38, 'http://localhost:9000/marketing/image_132.png');
INSERT INTO public.content_image VALUES (39, 39, 'http://localhost:9000/marketing/image_133.png');
INSERT INTO public.content_image VALUES (40, 40, 'http://localhost:9000/marketing/image_134.jpeg');
INSERT INTO public.content_image VALUES (41, 41, 'http://localhost:9000/marketing/image_135.png');
INSERT INTO public.content_image VALUES (42, 42, 'http://localhost:9000/marketing/image_136.png');
INSERT INTO public.content_image VALUES (43, 43, 'http://localhost:9000/marketing/image_137.jpeg');
INSERT INTO public.content_image VALUES (44, 44, 'http://localhost:9000/marketing/image_138.png');
INSERT INTO public.content_image VALUES (45, 45, 'http://localhost:9000/marketing/image_139.png');
INSERT INTO public.content_image VALUES (46, 46, 'http://localhost:9000/marketing/image_14.png');
INSERT INTO public.content_image VALUES (47, 47, 'http://localhost:9000/marketing/image_140.jpeg');
INSERT INTO public.content_image VALUES (48, 48, 'http://localhost:9000/marketing/image_141.png');
INSERT INTO public.content_image VALUES (49, 49, 'http://localhost:9000/marketing/image_142.png');
INSERT INTO public.content_image VALUES (50, 50, 'http://localhost:9000/marketing/image_143.png');
INSERT INTO public.content_image VALUES (51, 51, 'http://localhost:9000/marketing/image_144.png');
INSERT INTO public.content_image VALUES (52, 52, 'http://localhost:9000/marketing/image_145.png');
INSERT INTO public.content_image VALUES (53, 53, 'http://localhost:9000/marketing/image_146.png');
INSERT INTO public.content_image VALUES (54, 54, 'http://localhost:9000/marketing/image_147.png');
INSERT INTO public.content_image VALUES (55, 55, 'http://localhost:9000/marketing/image_148.png');
INSERT INTO public.content_image VALUES (56, 56, 'http://localhost:9000/marketing/image_149.png');
INSERT INTO public.content_image VALUES (57, 57, 'http://localhost:9000/marketing/image_15.jpeg');
INSERT INTO public.content_image VALUES (58, 58, 'http://localhost:9000/marketing/image_150.png');
INSERT INTO public.content_image VALUES (59, 59, 'http://localhost:9000/marketing/image_151.jpeg');
INSERT INTO public.content_image VALUES (60, 60, 'http://localhost:9000/marketing/image_152.jpeg');
INSERT INTO public.content_image VALUES (61, 61, 'http://localhost:9000/marketing/image_153.png');
INSERT INTO public.content_image VALUES (62, 62, 'http://localhost:9000/marketing/image_154.png');
INSERT INTO public.content_image VALUES (63, 63, 'http://localhost:9000/marketing/image_155.jpeg');
INSERT INTO public.content_image VALUES (64, 64, 'http://localhost:9000/marketing/image_156.png');
INSERT INTO public.content_image VALUES (65, 65, 'http://localhost:9000/marketing/image_157.png');
INSERT INTO public.content_image VALUES (66, 66, 'http://localhost:9000/marketing/image_158.png');
INSERT INTO public.content_image VALUES (67, 67, 'http://localhost:9000/marketing/image_159.png');
INSERT INTO public.content_image VALUES (68, 68, 'http://localhost:9000/marketing/image_16.png');
INSERT INTO public.content_image VALUES (69, 69, 'http://localhost:9000/marketing/image_160.png');
INSERT INTO public.content_image VALUES (70, 70, 'http://localhost:9000/marketing/image_161.jpeg');
INSERT INTO public.content_image VALUES (71, 71, 'http://localhost:9000/marketing/image_162.jpeg');
INSERT INTO public.content_image VALUES (72, 72, 'http://localhost:9000/marketing/image_163.png');
INSERT INTO public.content_image VALUES (73, 73, 'http://localhost:9000/marketing/image_164.jpeg');
INSERT INTO public.content_image VALUES (74, 74, 'http://localhost:9000/marketing/image_165.png');
INSERT INTO public.content_image VALUES (75, 75, 'http://localhost:9000/marketing/image_166.png');
INSERT INTO public.content_image VALUES (76, 76, 'http://localhost:9000/marketing/image_167.jpeg');
INSERT INTO public.content_image VALUES (77, 77, 'http://localhost:9000/marketing/image_168.png');
INSERT INTO public.content_image VALUES (78, 78, 'http://localhost:9000/marketing/image_169.png');
INSERT INTO public.content_image VALUES (79, 79, 'http://localhost:9000/marketing/image_17.png');
INSERT INTO public.content_image VALUES (80, 80, 'http://localhost:9000/marketing/image_170.png');
INSERT INTO public.content_image VALUES (81, 81, 'http://localhost:9000/marketing/image_171.png');
INSERT INTO public.content_image VALUES (82, 82, 'http://localhost:9000/marketing/image_172.jpeg');
INSERT INTO public.content_image VALUES (83, 83, 'http://localhost:9000/marketing/image_173.jpeg');
INSERT INTO public.content_image VALUES (84, 84, 'http://localhost:9000/marketing/image_174.png');
INSERT INTO public.content_image VALUES (85, 85, 'http://localhost:9000/marketing/image_175.png');
INSERT INTO public.content_image VALUES (86, 86, 'http://localhost:9000/marketing/image_176.jpeg');
INSERT INTO public.content_image VALUES (87, 87, 'http://localhost:9000/marketing/image_177.png');
INSERT INTO public.content_image VALUES (88, 88, 'http://localhost:9000/marketing/image_178.jpeg');
INSERT INTO public.content_image VALUES (89, 89, 'http://localhost:9000/marketing/image_179.png');
INSERT INTO public.content_image VALUES (90, 90, 'http://localhost:9000/marketing/image_18.jpeg');
INSERT INTO public.content_image VALUES (91, 91, 'http://localhost:9000/marketing/image_180.png');
INSERT INTO public.content_image VALUES (92, 92, 'http://localhost:9000/marketing/image_181.png');
INSERT INTO public.content_image VALUES (93, 93, 'http://localhost:9000/marketing/image_182.png');
INSERT INTO public.content_image VALUES (94, 94, 'http://localhost:9000/marketing/image_183.png');
INSERT INTO public.content_image VALUES (95, 95, 'http://localhost:9000/marketing/image_184.png');
INSERT INTO public.content_image VALUES (96, 96, 'http://localhost:9000/marketing/image_185.jpeg');
INSERT INTO public.content_image VALUES (97, 97, 'http://localhost:9000/marketing/image_186.png');
INSERT INTO public.content_image VALUES (98, 98, 'http://localhost:9000/marketing/image_187.png');
INSERT INTO public.content_image VALUES (99, 99, 'http://localhost:9000/marketing/image_188.png');
INSERT INTO public.content_image VALUES (100, 100, 'http://localhost:9000/marketing/image_189.jpeg');
INSERT INTO public.content_image VALUES (101, 101, 'http://localhost:9000/marketing/image_19.jpeg');
INSERT INTO public.content_image VALUES (102, 102, 'http://localhost:9000/marketing/image_190.png');
INSERT INTO public.content_image VALUES (103, 103, 'http://localhost:9000/marketing/image_191.jpeg');
INSERT INTO public.content_image VALUES (104, 1, 'http://localhost:9000/marketing/image_192.jpeg');
INSERT INTO public.content_image VALUES (105, 2, 'http://localhost:9000/marketing/image_193.png');
INSERT INTO public.content_image VALUES (106, 3, 'http://localhost:9000/marketing/image_194.png');
INSERT INTO public.content_image VALUES (107, 4, 'http://localhost:9000/marketing/image_195.png');
INSERT INTO public.content_image VALUES (108, 5, 'http://localhost:9000/marketing/image_196.png');
INSERT INTO public.content_image VALUES (109, 6, 'http://localhost:9000/marketing/image_197.png');
INSERT INTO public.content_image VALUES (110, 7, 'http://localhost:9000/marketing/image_198.jpeg');
INSERT INTO public.content_image VALUES (111, 8, 'http://localhost:9000/marketing/image_199.jpeg');
INSERT INTO public.content_image VALUES (112, 9, 'http://localhost:9000/marketing/image_2.png');
INSERT INTO public.content_image VALUES (113, 10, 'http://localhost:9000/marketing/image_20.jpeg');
INSERT INTO public.content_image VALUES (114, 11, 'http://localhost:9000/marketing/image_200.png');
INSERT INTO public.content_image VALUES (115, 12, 'http://localhost:9000/marketing/image_201.png');
INSERT INTO public.content_image VALUES (116, 13, 'http://localhost:9000/marketing/image_202.png');
INSERT INTO public.content_image VALUES (117, 14, 'http://localhost:9000/marketing/image_203.png');
INSERT INTO public.content_image VALUES (118, 15, 'http://localhost:9000/marketing/image_204.png');
INSERT INTO public.content_image VALUES (119, 16, 'http://localhost:9000/marketing/image_205.png');
INSERT INTO public.content_image VALUES (120, 17, 'http://localhost:9000/marketing/image_206.png');
INSERT INTO public.content_image VALUES (121, 18, 'http://localhost:9000/marketing/image_207.png');
INSERT INTO public.content_image VALUES (122, 19, 'http://localhost:9000/marketing/image_208.png');
INSERT INTO public.content_image VALUES (123, 20, 'http://localhost:9000/marketing/image_209.jpeg');
INSERT INTO public.content_image VALUES (124, 21, 'http://localhost:9000/marketing/image_21.jpeg');
INSERT INTO public.content_image VALUES (125, 22, 'http://localhost:9000/marketing/image_210.jpeg');
INSERT INTO public.content_image VALUES (126, 23, 'http://localhost:9000/marketing/image_211.png');
INSERT INTO public.content_image VALUES (127, 24, 'http://localhost:9000/marketing/image_212.png');
INSERT INTO public.content_image VALUES (128, 25, 'http://localhost:9000/marketing/image_213.jpeg');
INSERT INTO public.content_image VALUES (129, 26, 'http://localhost:9000/marketing/image_214.jpeg');
INSERT INTO public.content_image VALUES (130, 27, 'http://localhost:9000/marketing/image_215.png');
INSERT INTO public.content_image VALUES (131, 28, 'http://localhost:9000/marketing/image_216.png');
INSERT INTO public.content_image VALUES (132, 29, 'http://localhost:9000/marketing/image_217.png');
INSERT INTO public.content_image VALUES (133, 30, 'http://localhost:9000/marketing/image_218.png');
INSERT INTO public.content_image VALUES (134, 31, 'http://localhost:9000/marketing/image_219.png');
INSERT INTO public.content_image VALUES (135, 32, 'http://localhost:9000/marketing/image_22.png');
INSERT INTO public.content_image VALUES (136, 33, 'http://localhost:9000/marketing/image_220.png');
INSERT INTO public.content_image VALUES (137, 34, 'http://localhost:9000/marketing/image_221.png');
INSERT INTO public.content_image VALUES (138, 35, 'http://localhost:9000/marketing/image_222.jpeg');
INSERT INTO public.content_image VALUES (139, 36, 'http://localhost:9000/marketing/image_223.png');
INSERT INTO public.content_image VALUES (140, 37, 'http://localhost:9000/marketing/image_224.jpeg');
INSERT INTO public.content_image VALUES (141, 38, 'http://localhost:9000/marketing/image_225.jpeg');
INSERT INTO public.content_image VALUES (142, 39, 'http://localhost:9000/marketing/image_226.png');
INSERT INTO public.content_image VALUES (143, 40, 'http://localhost:9000/marketing/image_227.png');
INSERT INTO public.content_image VALUES (144, 41, 'http://localhost:9000/marketing/image_228.png');
INSERT INTO public.content_image VALUES (145, 42, 'http://localhost:9000/marketing/image_229.png');
INSERT INTO public.content_image VALUES (146, 43, 'http://localhost:9000/marketing/image_23.jpeg');
INSERT INTO public.content_image VALUES (147, 44, 'http://localhost:9000/marketing/image_230.png');
INSERT INTO public.content_image VALUES (148, 45, 'http://localhost:9000/marketing/image_231.jpeg');
INSERT INTO public.content_image VALUES (149, 46, 'http://localhost:9000/marketing/image_232.png');
INSERT INTO public.content_image VALUES (150, 47, 'http://localhost:9000/marketing/image_233.png');
INSERT INTO public.content_image VALUES (151, 48, 'http://localhost:9000/marketing/image_234.png');
INSERT INTO public.content_image VALUES (152, 49, 'http://localhost:9000/marketing/image_235.png');
INSERT INTO public.content_image VALUES (153, 50, 'http://localhost:9000/marketing/image_236.png');
INSERT INTO public.content_image VALUES (154, 51, 'http://localhost:9000/marketing/image_237.jpeg');
INSERT INTO public.content_image VALUES (155, 52, 'http://localhost:9000/marketing/image_238.jpeg');
INSERT INTO public.content_image VALUES (156, 53, 'http://localhost:9000/marketing/image_239.png');
INSERT INTO public.content_image VALUES (157, 54, 'http://localhost:9000/marketing/image_24.png');
INSERT INTO public.content_image VALUES (158, 55, 'http://localhost:9000/marketing/image_240.png');
INSERT INTO public.content_image VALUES (159, 56, 'http://localhost:9000/marketing/image_241.jpeg');
INSERT INTO public.content_image VALUES (160, 57, 'http://localhost:9000/marketing/image_242.jpeg');
INSERT INTO public.content_image VALUES (161, 58, 'http://localhost:9000/marketing/image_243.png');
INSERT INTO public.content_image VALUES (162, 59, 'http://localhost:9000/marketing/image_244.png');
INSERT INTO public.content_image VALUES (163, 60, 'http://localhost:9000/marketing/image_245.png');
INSERT INTO public.content_image VALUES (164, 61, 'http://localhost:9000/marketing/image_246.png');
INSERT INTO public.content_image VALUES (165, 62, 'http://localhost:9000/marketing/image_247.jpeg');
INSERT INTO public.content_image VALUES (166, 63, 'http://localhost:9000/marketing/image_248.png');
INSERT INTO public.content_image VALUES (167, 64, 'http://localhost:9000/marketing/image_249.png');
INSERT INTO public.content_image VALUES (168, 65, 'http://localhost:9000/marketing/image_25.png');
INSERT INTO public.content_image VALUES (169, 66, 'http://localhost:9000/marketing/image_250.png');
INSERT INTO public.content_image VALUES (170, 67, 'http://localhost:9000/marketing/image_251.png');
INSERT INTO public.content_image VALUES (171, 68, 'http://localhost:9000/marketing/image_252.png');
INSERT INTO public.content_image VALUES (172, 69, 'http://localhost:9000/marketing/image_253.jpeg');
INSERT INTO public.content_image VALUES (173, 70, 'http://localhost:9000/marketing/image_254.png');
INSERT INTO public.content_image VALUES (174, 71, 'http://localhost:9000/marketing/image_255.jpeg');
INSERT INTO public.content_image VALUES (175, 72, 'http://localhost:9000/marketing/image_26.png');
INSERT INTO public.content_image VALUES (176, 73, 'http://localhost:9000/marketing/image_27.png');
INSERT INTO public.content_image VALUES (177, 74, 'http://localhost:9000/marketing/image_28.png');
INSERT INTO public.content_image VALUES (178, 75, 'http://localhost:9000/marketing/image_29.png');
INSERT INTO public.content_image VALUES (179, 76, 'http://localhost:9000/marketing/image_3.png');
INSERT INTO public.content_image VALUES (180, 77, 'http://localhost:9000/marketing/image_30.jpeg');
INSERT INTO public.content_image VALUES (181, 78, 'http://localhost:9000/marketing/image_31.png');
INSERT INTO public.content_image VALUES (182, 79, 'http://localhost:9000/marketing/image_32.png');
INSERT INTO public.content_image VALUES (183, 80, 'http://localhost:9000/marketing/image_33.jpeg');
INSERT INTO public.content_image VALUES (184, 81, 'http://localhost:9000/marketing/image_34.png');
INSERT INTO public.content_image VALUES (185, 82, 'http://localhost:9000/marketing/image_35.jpeg');
INSERT INTO public.content_image VALUES (186, 83, 'http://localhost:9000/marketing/image_36.jpeg');
INSERT INTO public.content_image VALUES (187, 84, 'http://localhost:9000/marketing/image_37.jpeg');
INSERT INTO public.content_image VALUES (188, 85, 'http://localhost:9000/marketing/image_38.png');
INSERT INTO public.content_image VALUES (189, 86, 'http://localhost:9000/marketing/image_39.png');
INSERT INTO public.content_image VALUES (190, 87, 'http://localhost:9000/marketing/image_4.jpeg');
INSERT INTO public.content_image VALUES (191, 88, 'http://localhost:9000/marketing/image_40.jpeg');
INSERT INTO public.content_image VALUES (192, 89, 'http://localhost:9000/marketing/image_41.jpeg');
INSERT INTO public.content_image VALUES (193, 90, 'http://localhost:9000/marketing/image_42.jpeg');
INSERT INTO public.content_image VALUES (194, 91, 'http://localhost:9000/marketing/image_43.png');
INSERT INTO public.content_image VALUES (195, 92, 'http://localhost:9000/marketing/image_44.png');
INSERT INTO public.content_image VALUES (196, 93, 'http://localhost:9000/marketing/image_45.png');
INSERT INTO public.content_image VALUES (197, 94, 'http://localhost:9000/marketing/image_46.png');
INSERT INTO public.content_image VALUES (198, 95, 'http://localhost:9000/marketing/image_47.jpeg');
INSERT INTO public.content_image VALUES (199, 96, 'http://localhost:9000/marketing/image_48.png');
INSERT INTO public.content_image VALUES (200, 97, 'http://localhost:9000/marketing/image_49.jpeg');
INSERT INTO public.content_image VALUES (201, 98, 'http://localhost:9000/marketing/image_5.png');
INSERT INTO public.content_image VALUES (202, 99, 'http://localhost:9000/marketing/image_50.png');
INSERT INTO public.content_image VALUES (203, 100, 'http://localhost:9000/marketing/image_51.png');
INSERT INTO public.content_image VALUES (204, 101, 'http://localhost:9000/marketing/image_52.png');
INSERT INTO public.content_image VALUES (205, 102, 'http://localhost:9000/marketing/image_53.jpeg');
INSERT INTO public.content_image VALUES (206, 103, 'http://localhost:9000/marketing/image_54.png');
INSERT INTO public.content_image VALUES (207, 1, 'http://localhost:9000/marketing/image_55.png');
INSERT INTO public.content_image VALUES (208, 2, 'http://localhost:9000/marketing/image_56.png');
INSERT INTO public.content_image VALUES (209, 3, 'http://localhost:9000/marketing/image_57.jpeg');
INSERT INTO public.content_image VALUES (210, 4, 'http://localhost:9000/marketing/image_58.jpeg');
INSERT INTO public.content_image VALUES (211, 5, 'http://localhost:9000/marketing/image_59.png');
INSERT INTO public.content_image VALUES (212, 6, 'http://localhost:9000/marketing/image_6.png');
INSERT INTO public.content_image VALUES (213, 7, 'http://localhost:9000/marketing/image_60.jpeg');
INSERT INTO public.content_image VALUES (214, 8, 'http://localhost:9000/marketing/image_61.png');
INSERT INTO public.content_image VALUES (215, 9, 'http://localhost:9000/marketing/image_62.png');
INSERT INTO public.content_image VALUES (216, 10, 'http://localhost:9000/marketing/image_63.png');
INSERT INTO public.content_image VALUES (217, 11, 'http://localhost:9000/marketing/image_64.jpeg');
INSERT INTO public.content_image VALUES (218, 12, 'http://localhost:9000/marketing/image_65.jpeg');
INSERT INTO public.content_image VALUES (219, 13, 'http://localhost:9000/marketing/image_66.jpeg');
INSERT INTO public.content_image VALUES (220, 14, 'http://localhost:9000/marketing/image_67.jpeg');
INSERT INTO public.content_image VALUES (221, 15, 'http://localhost:9000/marketing/image_68.png');
INSERT INTO public.content_image VALUES (222, 16, 'http://localhost:9000/marketing/image_69.jpeg');
INSERT INTO public.content_image VALUES (223, 17, 'http://localhost:9000/marketing/image_7.jpeg');
INSERT INTO public.content_image VALUES (224, 18, 'http://localhost:9000/marketing/image_70.jpeg');
INSERT INTO public.content_image VALUES (225, 19, 'http://localhost:9000/marketing/image_71.png');
INSERT INTO public.content_image VALUES (226, 20, 'http://localhost:9000/marketing/image_72.png');
INSERT INTO public.content_image VALUES (227, 21, 'http://localhost:9000/marketing/image_73.jpeg');
INSERT INTO public.content_image VALUES (228, 22, 'http://localhost:9000/marketing/image_74.png');
INSERT INTO public.content_image VALUES (229, 23, 'http://localhost:9000/marketing/image_75.png');
INSERT INTO public.content_image VALUES (230, 24, 'http://localhost:9000/marketing/image_76.jpeg');
INSERT INTO public.content_image VALUES (231, 25, 'http://localhost:9000/marketing/image_77.jpeg');
INSERT INTO public.content_image VALUES (232, 26, 'http://localhost:9000/marketing/image_78.png');
INSERT INTO public.content_image VALUES (233, 27, 'http://localhost:9000/marketing/image_79.png');
INSERT INTO public.content_image VALUES (234, 28, 'http://localhost:9000/marketing/image_8.jpeg');
INSERT INTO public.content_image VALUES (235, 29, 'http://localhost:9000/marketing/image_80.png');
INSERT INTO public.content_image VALUES (236, 30, 'http://localhost:9000/marketing/image_81.png');
INSERT INTO public.content_image VALUES (237, 31, 'http://localhost:9000/marketing/image_82.png');
INSERT INTO public.content_image VALUES (238, 32, 'http://localhost:9000/marketing/image_83.png');
INSERT INTO public.content_image VALUES (239, 33, 'http://localhost:9000/marketing/image_84.png');
INSERT INTO public.content_image VALUES (240, 34, 'http://localhost:9000/marketing/image_85.jpeg');
INSERT INTO public.content_image VALUES (241, 35, 'http://localhost:9000/marketing/image_86.png');
INSERT INTO public.content_image VALUES (242, 36, 'http://localhost:9000/marketing/image_87.png');
INSERT INTO public.content_image VALUES (243, 37, 'http://localhost:9000/marketing/image_88.jpeg');
INSERT INTO public.content_image VALUES (244, 38, 'http://localhost:9000/marketing/image_89.png');
INSERT INTO public.content_image VALUES (245, 39, 'http://localhost:9000/marketing/image_9.png');
INSERT INTO public.content_image VALUES (246, 40, 'http://localhost:9000/marketing/image_90.png');
INSERT INTO public.content_image VALUES (247, 41, 'http://localhost:9000/marketing/image_91.png');
INSERT INTO public.content_image VALUES (248, 42, 'http://localhost:9000/marketing/image_92.png');
INSERT INTO public.content_image VALUES (249, 43, 'http://localhost:9000/marketing/image_93.png');
INSERT INTO public.content_image VALUES (250, 44, 'http://localhost:9000/marketing/image_94.png');
INSERT INTO public.content_image VALUES (251, 45, 'http://localhost:9000/marketing/image_95.png');
INSERT INTO public.content_image VALUES (252, 46, 'http://localhost:9000/marketing/image_96.png');
INSERT INTO public.content_image VALUES (253, 47, 'http://localhost:9000/marketing/image_97.jpeg');
INSERT INTO public.content_image VALUES (254, 48, 'http://localhost:9000/marketing/image_98.png');
INSERT INTO public.content_image VALUES (255, 49, 'http://localhost:9000/marketing/image_99.jpeg');


--
-- Data for Name: external_trends; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: holiday_calendar; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: ingredient; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ingredient VALUES (1, 1, '阿里山高山茶葉');
INSERT INTO public.ingredient VALUES (2, 1, '玫瑰鹽');
INSERT INTO public.ingredient VALUES (3, 1, '茉莉綠茶');
INSERT INTO public.ingredient VALUES (4, 1, '芝士奶蓋');
INSERT INTO public.ingredient VALUES (5, 1, '岩葉紅茶');
INSERT INTO public.ingredient VALUES (6, 1, '香草冰淇淋');
INSERT INTO public.ingredient VALUES (7, 1, '蘋果');
INSERT INTO public.ingredient VALUES (8, 1, '百香果');
INSERT INTO public.ingredient VALUES (9, 1, '四季春青茶');
INSERT INTO public.ingredient VALUES (10, 1, '葡萄柚');
INSERT INTO public.ingredient VALUES (11, 1, '柳橙');
INSERT INTO public.ingredient VALUES (12, 1, '綠茶');
INSERT INTO public.ingredient VALUES (13, 1, '寒天晶球');
INSERT INTO public.ingredient VALUES (14, 1, '柚子');
INSERT INTO public.ingredient VALUES (15, 1, '波霸珍珠');
INSERT INTO public.ingredient VALUES (16, 1, '黑糖');
INSERT INTO public.ingredient VALUES (17, 1, '鮮乳');
INSERT INTO public.ingredient VALUES (18, 1, '烏龍茶');
INSERT INTO public.ingredient VALUES (19, 1, '檸檬');
INSERT INTO public.ingredient VALUES (20, 1, '芭樂');
INSERT INTO public.ingredient VALUES (21, 1, '紅茶');
INSERT INTO public.ingredient VALUES (22, 1, '翠玉茶葉');
INSERT INTO public.ingredient VALUES (23, 1, '四季春茶葉');
INSERT INTO public.ingredient VALUES (24, 1, '烏龍鐵觀音茶葉');
INSERT INTO public.ingredient VALUES (25, 1, '冬瓜露');
INSERT INTO public.ingredient VALUES (26, 1, '蜜桃風味紅茶葉');
INSERT INTO public.ingredient VALUES (27, 1, '紅玉紅茶');
INSERT INTO public.ingredient VALUES (28, 1, '高山烏龍茶葉');
INSERT INTO public.ingredient VALUES (29, 1, '玫瑰風味糖漿');
INSERT INTO public.ingredient VALUES (30, 1, '特選基底茶');
INSERT INTO public.ingredient VALUES (31, 1, '青梅');
INSERT INTO public.ingredient VALUES (32, 1, '翠玉綠茶');
INSERT INTO public.ingredient VALUES (33, 1, '梅子');
INSERT INTO public.ingredient VALUES (34, 1, '乳酸飲料');
INSERT INTO public.ingredient VALUES (35, 1, '養樂多');
INSERT INTO public.ingredient VALUES (36, 1, '高山青茶');
INSERT INTO public.ingredient VALUES (37, 1, '仙草凍');
INSERT INTO public.ingredient VALUES (38, 1, '黑糖波霸');
INSERT INTO public.ingredient VALUES (39, 1, '奶茶');
INSERT INTO public.ingredient VALUES (40, 1, '蒟蒻');
INSERT INTO public.ingredient VALUES (41, 1, '珍珠');
INSERT INTO public.ingredient VALUES (42, 1, '奶精/奶粉');
INSERT INTO public.ingredient VALUES (43, 1, '錫蘭紅茶');
INSERT INTO public.ingredient VALUES (44, 1, '重焙鐵觀音');
INSERT INTO public.ingredient VALUES (45, 1, '鐵觀音烏龍茶');
INSERT INTO public.ingredient VALUES (46, 1, '伯爵紅茶');
INSERT INTO public.ingredient VALUES (47, 1, '蜜桃風味紅茶');
INSERT INTO public.ingredient VALUES (48, 1, '巧克力醬/粉');
INSERT INTO public.ingredient VALUES (49, 1, '粉粿');
INSERT INTO public.ingredient VALUES (50, 1, '柚子醬');
INSERT INTO public.ingredient VALUES (51, 1, '柳橙汁');
INSERT INTO public.ingredient VALUES (52, 1, '碧螺春綠茶');
INSERT INTO public.ingredient VALUES (53, 1, '芒果醬/果泥');
INSERT INTO public.ingredient VALUES (54, 1, '芒果');
INSERT INTO public.ingredient VALUES (55, 1, '椰果');
INSERT INTO public.ingredient VALUES (56, 1, '百香果原汁');
INSERT INTO public.ingredient VALUES (57, 1, '羅勒子');
INSERT INTO public.ingredient VALUES (58, 1, '青茶');
INSERT INTO public.ingredient VALUES (59, 1, '冬瓜茶');
INSERT INTO public.ingredient VALUES (60, 1, '檸檬原汁');
INSERT INTO public.ingredient VALUES (61, 1, '優格');
INSERT INTO public.ingredient VALUES (62, 1, '榴槤');
INSERT INTO public.ingredient VALUES (63, 1, '椰奶');
INSERT INTO public.ingredient VALUES (64, 1, '蜜紅豆');
INSERT INTO public.ingredient VALUES (65, 1, '鮮奶');
INSERT INTO public.ingredient VALUES (66, 1, '英式伯爵茶');
INSERT INTO public.ingredient VALUES (67, 1, '薑汁');
INSERT INTO public.ingredient VALUES (68, 1, '桂圓紅棗醬');
INSERT INTO public.ingredient VALUES (69, 2, '高山青茶');
INSERT INTO public.ingredient VALUES (70, 2, '桂花');
INSERT INTO public.ingredient VALUES (71, 2, '青茶');
INSERT INTO public.ingredient VALUES (72, 2, '紅玉紅茶');
INSERT INTO public.ingredient VALUES (73, 2, '綠茶');
INSERT INTO public.ingredient VALUES (74, 2, '蕎麥茶');
INSERT INTO public.ingredient VALUES (75, 2, '冬瓜糖漿');
INSERT INTO public.ingredient VALUES (76, 2, '東方美人茶葉');
INSERT INTO public.ingredient VALUES (77, 2, '金萱烏龍茶');
INSERT INTO public.ingredient VALUES (78, 2, '鳳梨醬');
INSERT INTO public.ingredient VALUES (79, 2, '玉露青茶');
INSERT INTO public.ingredient VALUES (80, 2, '蘋果');
INSERT INTO public.ingredient VALUES (81, 2, '甘蔗汁');
INSERT INTO public.ingredient VALUES (82, 2, '冬瓜露');
INSERT INTO public.ingredient VALUES (83, 2, '檸檬');
INSERT INTO public.ingredient VALUES (84, 2, '檸檬汁');
INSERT INTO public.ingredient VALUES (85, 2, '養樂多');
INSERT INTO public.ingredient VALUES (86, 2, '桂花釀');
INSERT INTO public.ingredient VALUES (87, 2, '柳橙汁');
INSERT INTO public.ingredient VALUES (88, 2, '柳橙');
INSERT INTO public.ingredient VALUES (89, 2, '酪梨泥');
INSERT INTO public.ingredient VALUES (90, 2, '鮮奶油');
INSERT INTO public.ingredient VALUES (91, 2, '酪梨');
INSERT INTO public.ingredient VALUES (92, 2, '牛奶/奶粉');
INSERT INTO public.ingredient VALUES (93, 2, '烏龍茶');
INSERT INTO public.ingredient VALUES (94, 2, '冬瓜茶');
INSERT INTO public.ingredient VALUES (95, 2, '玉露綠茶');
INSERT INTO public.ingredient VALUES (96, 2, '鮮奶');
INSERT INTO public.ingredient VALUES (97, 2, '桂花糖漿');
INSERT INTO public.ingredient VALUES (98, 2, '奶精/奶粉');
INSERT INTO public.ingredient VALUES (99, 2, '紅茶');
INSERT INTO public.ingredient VALUES (100, 2, '奶精/鮮奶');
INSERT INTO public.ingredient VALUES (101, 2, '鐵觀音茶');
INSERT INTO public.ingredient VALUES (102, 2, '翡翠綠茶');
INSERT INTO public.ingredient VALUES (103, 2, '鮮乳');
INSERT INTO public.ingredient VALUES (104, 2, '珍珠');
INSERT INTO public.ingredient VALUES (105, 2, '蕎麥茶凍');
INSERT INTO public.ingredient VALUES (106, 2, '烤糖');
INSERT INTO public.ingredient VALUES (107, 2, '奶精/鮮乳');
INSERT INTO public.ingredient VALUES (108, 2, '珈琲粉粿');
INSERT INTO public.ingredient VALUES (109, 2, '咖啡粉粿');
INSERT INTO public.ingredient VALUES (110, 2, '仙草凍');
INSERT INTO public.ingredient VALUES (111, 2, '鮮奶/奶精');
INSERT INTO public.ingredient VALUES (112, 2, '翡翠青茶');
INSERT INTO public.ingredient VALUES (113, 2, '草莓奶蓋');
INSERT INTO public.ingredient VALUES (114, 2, '優格');
INSERT INTO public.ingredient VALUES (115, 2, '草莓');
INSERT INTO public.ingredient VALUES (116, 2, '蕎麥');
INSERT INTO public.ingredient VALUES (117, 3, '紅烏龍茶');
INSERT INTO public.ingredient VALUES (118, 3, '莓果調味');
INSERT INTO public.ingredient VALUES (119, 3, '奶精');
INSERT INTO public.ingredient VALUES (120, 3, '鮮奶');
INSERT INTO public.ingredient VALUES (121, 3, '芝士奶蓋');
INSERT INTO public.ingredient VALUES (122, 3, '紅茶');
INSERT INTO public.ingredient VALUES (123, 3, '綠茶');
INSERT INTO public.ingredient VALUES (124, 3, '烏龍茶');
INSERT INTO public.ingredient VALUES (125, 3, '奶精/奶粉');
INSERT INTO public.ingredient VALUES (126, 3, '焙烏龍茶');
INSERT INTO public.ingredient VALUES (127, 3, '珍珠');
INSERT INTO public.ingredient VALUES (128, 3, '焙茶粉');
INSERT INTO public.ingredient VALUES (129, 3, '檸檬');
INSERT INTO public.ingredient VALUES (130, 3, '檸檬汁');
INSERT INTO public.ingredient VALUES (131, 3, '春烏龍茶');
INSERT INTO public.ingredient VALUES (132, 3, '柳橙');
INSERT INTO public.ingredient VALUES (133, 3, '柳橙汁');
INSERT INTO public.ingredient VALUES (134, 3, '甘蔗汁');
INSERT INTO public.ingredient VALUES (135, 3, '青梅');
INSERT INTO public.ingredient VALUES (136, 3, '梅子');
INSERT INTO public.ingredient VALUES (137, 3, '可爾必思發酵乳');
INSERT INTO public.ingredient VALUES (138, 3, '葡萄柚');
INSERT INTO public.ingredient VALUES (139, 3, '柚子');
INSERT INTO public.ingredient VALUES (140, 3, '日本柚');
INSERT INTO public.ingredient VALUES (141, 3, '春烏龍');
INSERT INTO public.ingredient VALUES (142, 3, '焙烏龍');
INSERT INTO public.ingredient VALUES (143, 3, '阿華田麥芽飲');
INSERT INTO public.ingredient VALUES (144, 4, '太妃糖糖漿');
INSERT INTO public.ingredient VALUES (145, 4, '蜜桃香料');
INSERT INTO public.ingredient VALUES (146, 4, '斯里蘭卡紅茶');
INSERT INTO public.ingredient VALUES (147, 4, '厚奶霜');
INSERT INTO public.ingredient VALUES (148, 4, '英式伯爵茶');
INSERT INTO public.ingredient VALUES (149, 4, '錫蘭紅茶');
INSERT INTO public.ingredient VALUES (150, 4, '蜜桃錫蘭紅茶');
INSERT INTO public.ingredient VALUES (151, 4, '鮮奶');
INSERT INTO public.ingredient VALUES (152, 4, '奶精/奶粉');
INSERT INTO public.ingredient VALUES (153, 4, '伯爵紅茶');
INSERT INTO public.ingredient VALUES (154, 4, '玫瑰花瓣');
INSERT INTO public.ingredient VALUES (155, 4, '柳橙');
INSERT INTO public.ingredient VALUES (156, 4, '百香果');
INSERT INTO public.ingredient VALUES (157, 4, '鳳梨');
INSERT INTO public.ingredient VALUES (158, 4, '四季春茶');
INSERT INTO public.ingredient VALUES (159, 4, '麥子');
INSERT INTO public.ingredient VALUES (160, 4, '穀物');
INSERT INTO public.ingredient VALUES (161, 4, '奶蓋');
INSERT INTO public.ingredient VALUES (162, 4, '佛手柑精油');
INSERT INTO public.ingredient VALUES (163, 4, '冬瓜露');
INSERT INTO public.ingredient VALUES (164, 4, '糯米');
INSERT INTO public.ingredient VALUES (165, 4, '烏龍茶');
INSERT INTO public.ingredient VALUES (166, 4, '茉莉花');
INSERT INTO public.ingredient VALUES (167, 4, '綠茶');
INSERT INTO public.ingredient VALUES (168, 4, '梔子花');
INSERT INTO public.ingredient VALUES (169, 4, '穀麥茶');
INSERT INTO public.ingredient VALUES (170, 4, '奶粉');
INSERT INTO public.ingredient VALUES (171, 4, '巧克力');
INSERT INTO public.ingredient VALUES (172, 4, '糯烏龍茶');
INSERT INTO public.ingredient VALUES (173, 4, '蜂蜜');
INSERT INTO public.ingredient VALUES (174, 4, '珍珠');
INSERT INTO public.ingredient VALUES (175, 5, '奶精');
INSERT INTO public.ingredient VALUES (176, 5, '杏仁粉');
INSERT INTO public.ingredient VALUES (177, 5, '鮮奶');
INSERT INTO public.ingredient VALUES (178, 5, '可可粉');
INSERT INTO public.ingredient VALUES (179, 5, '龍眼');
INSERT INTO public.ingredient VALUES (180, 5, '桂圓糖漿');
INSERT INTO public.ingredient VALUES (181, 5, '黑糖');
INSERT INTO public.ingredient VALUES (182, 5, '薑母');
INSERT INTO public.ingredient VALUES (183, 5, '奶精/奶粉');
INSERT INTO public.ingredient VALUES (184, 5, '綠茶');
INSERT INTO public.ingredient VALUES (185, 5, '烏龍茶');
INSERT INTO public.ingredient VALUES (186, 5, '紅茶');
INSERT INTO public.ingredient VALUES (187, 5, '青茶');
INSERT INTO public.ingredient VALUES (188, 5, '普洱茶');
INSERT INTO public.ingredient VALUES (189, 5, '冬瓜露');
INSERT INTO public.ingredient VALUES (190, 5, '檸檬');
INSERT INTO public.ingredient VALUES (191, 5, '檸檬汁');
INSERT INTO public.ingredient VALUES (192, 5, '百香果糖漿');
INSERT INTO public.ingredient VALUES (193, 5, '珍珠');
INSERT INTO public.ingredient VALUES (194, 5, '椰果');
INSERT INTO public.ingredient VALUES (195, 5, '錫蘭紅茶');
INSERT INTO public.ingredient VALUES (196, 5, '水蜜桃醬');
INSERT INTO public.ingredient VALUES (197, 5, '水蜜桃');
INSERT INTO public.ingredient VALUES (198, 5, '茉綠茶凍');
INSERT INTO public.ingredient VALUES (199, 5, '話梅');
INSERT INTO public.ingredient VALUES (200, 5, '梅子');
INSERT INTO public.ingredient VALUES (201, 5, '蜂蜜');
INSERT INTO public.ingredient VALUES (202, 5, '咖啡粉');
INSERT INTO public.ingredient VALUES (203, 5, '荔枝果漿');
INSERT INTO public.ingredient VALUES (204, 5, '蜂蜜蘆薈');
INSERT INTO public.ingredient VALUES (205, 5, '金桔汁');
INSERT INTO public.ingredient VALUES (206, 5, '金桔');
INSERT INTO public.ingredient VALUES (207, 5, '柳橙');
INSERT INTO public.ingredient VALUES (208, 5, '柳橙汁');
INSERT INTO public.ingredient VALUES (209, 5, '甘蔗汁');
INSERT INTO public.ingredient VALUES (210, 5, '鳳梨');
INSERT INTO public.ingredient VALUES (211, 5, '鳳梨醬');
INSERT INTO public.ingredient VALUES (212, 5, '芝麻粉');
INSERT INTO public.ingredient VALUES (213, 5, '仙草凍');
INSERT INTO public.ingredient VALUES (214, 5, '綠茶凍');
INSERT INTO public.ingredient VALUES (215, 5, '鮮乳');
INSERT INTO public.ingredient VALUES (216, 5, '草莓');
INSERT INTO public.ingredient VALUES (217, 5, '草莓醬');
INSERT INTO public.ingredient VALUES (218, 5, '烏龍綠茶');
INSERT INTO public.ingredient VALUES (219, 5, '布丁');
INSERT INTO public.ingredient VALUES (220, 5, '咖啡凍');
INSERT INTO public.ingredient VALUES (221, 5, '清心優多');
INSERT INTO public.ingredient VALUES (222, 5, '紅心芭樂');
INSERT INTO public.ingredient VALUES (223, 5, '紅心芭樂汁');
INSERT INTO public.ingredient VALUES (224, 5, '草莓糖漿');
INSERT INTO public.ingredient VALUES (225, 5, '蘋果醋');
INSERT INTO public.ingredient VALUES (226, 5, '藍莓醋');
INSERT INTO public.ingredient VALUES (227, 5, '荔枝糖漿');
INSERT INTO public.ingredient VALUES (228, 5, 'Red Bull 能量飲料');
INSERT INTO public.ingredient VALUES (229, 5, 'Red Bull 葡萄風味能量飲料');
INSERT INTO public.ingredient VALUES (230, 6, '蕎麥茶');
INSERT INTO public.ingredient VALUES (231, 6, '桂花糖漿');
INSERT INTO public.ingredient VALUES (232, 6, '盧哈娜紅茶');
INSERT INTO public.ingredient VALUES (233, 6, '鮮奶');
INSERT INTO public.ingredient VALUES (234, 6, '仙草凍');
INSERT INTO public.ingredient VALUES (235, 6, '茉莉綠茶');
INSERT INTO public.ingredient VALUES (236, 6, '芋頭泥');
INSERT INTO public.ingredient VALUES (237, 6, '焙茶');
INSERT INTO public.ingredient VALUES (238, 6, '玄米粒');
INSERT INTO public.ingredient VALUES (239, 6, '八女抹茶');
INSERT INTO public.ingredient VALUES (240, 6, '青梅露');
INSERT INTO public.ingredient VALUES (241, 6, '檸檬汁');
INSERT INTO public.ingredient VALUES (242, 6, '柚子');
INSERT INTO public.ingredient VALUES (243, 6, '柚子醬');
INSERT INTO public.ingredient VALUES (244, 6, '養樂多');
INSERT INTO public.ingredient VALUES (245, 6, '檸檬');
INSERT INTO public.ingredient VALUES (246, 6, '檸檬皮');
INSERT INTO public.ingredient VALUES (247, 6, '柳丁汁');
INSERT INTO public.ingredient VALUES (248, 6, '柳丁');
INSERT INTO public.ingredient VALUES (249, 6, '青茶');
INSERT INTO public.ingredient VALUES (250, 6, '蜂蜜');
INSERT INTO public.ingredient VALUES (251, 6, '綠茶凍');
INSERT INTO public.ingredient VALUES (252, 6, '珍珠');
INSERT INTO public.ingredient VALUES (253, 6, '黑糖');
INSERT INTO public.ingredient VALUES (254, 6, '可可粉');
INSERT INTO public.ingredient VALUES (255, 6, '玄米抹茶');
INSERT INTO public.ingredient VALUES (256, 6, '冬瓜露');
INSERT INTO public.ingredient VALUES (257, 6, '大麥茶');
INSERT INTO public.ingredient VALUES (258, 6, '決明子');
INSERT INTO public.ingredient VALUES (259, 6, '決明子大麥茶');
INSERT INTO public.ingredient VALUES (260, 6, '檸檬原汁');
INSERT INTO public.ingredient VALUES (261, 7, '四季春茶');
INSERT INTO public.ingredient VALUES (262, 7, '阿薩姆紅茶');
INSERT INTO public.ingredient VALUES (263, 7, '大麥');
INSERT INTO public.ingredient VALUES (264, 7, '煎茶');
INSERT INTO public.ingredient VALUES (265, 7, '蜂蜜');
INSERT INTO public.ingredient VALUES (266, 7, '百香果香料');
INSERT INTO public.ingredient VALUES (267, 7, '高山烏龍茶');
INSERT INTO public.ingredient VALUES (268, 7, '芒果香料');
INSERT INTO public.ingredient VALUES (269, 7, '綠茶');
INSERT INTO public.ingredient VALUES (270, 7, '烏龍茶');
INSERT INTO public.ingredient VALUES (271, 7, '碧螺春');
INSERT INTO public.ingredient VALUES (272, 7, '蔗糖液');
INSERT INTO public.ingredient VALUES (273, 7, '金萱烏龍茶湯');
INSERT INTO public.ingredient VALUES (274, 7, '紅茶');
INSERT INTO public.ingredient VALUES (275, 7, '鐵觀音茶葉');
INSERT INTO public.ingredient VALUES (276, 7, '玫瑰花香料');
INSERT INTO public.ingredient VALUES (277, 7, '普洱茶');
INSERT INTO public.ingredient VALUES (278, 7, '白桃調味液');
INSERT INTO public.ingredient VALUES (279, 7, '桂花釀');
INSERT INTO public.ingredient VALUES (280, 7, '奶精粉');
INSERT INTO public.ingredient VALUES (281, 7, '小葉紅茶');
INSERT INTO public.ingredient VALUES (282, 7, '新式奶精粉');
INSERT INTO public.ingredient VALUES (283, 7, '大麥紅茶');
INSERT INTO public.ingredient VALUES (284, 7, '紅蔗糖與蔗糖液');
INSERT INTO public.ingredient VALUES (285, 7, '蜂蜜香氣');
INSERT INTO public.ingredient VALUES (286, 7, '奶精');
INSERT INTO public.ingredient VALUES (287, 7, '日本靜岡煎茶');
INSERT INTO public.ingredient VALUES (288, 7, '熱帶水果香');
INSERT INTO public.ingredient VALUES (289, 7, '蘭花香');
INSERT INTO public.ingredient VALUES (290, 7, '四季春');
INSERT INTO public.ingredient VALUES (291, 7, '玫瑰花瓣');
INSERT INTO public.ingredient VALUES (292, 7, '奶精/奶粉');
INSERT INTO public.ingredient VALUES (293, 7, '茉莉烏龍茶');
INSERT INTO public.ingredient VALUES (294, 7, '鐵觀音烏龍');
INSERT INTO public.ingredient VALUES (295, 7, '黑糖');
INSERT INTO public.ingredient VALUES (296, 7, '鮮乳');
INSERT INTO public.ingredient VALUES (297, 7, '烏瓦紅茶');
INSERT INTO public.ingredient VALUES (298, 7, '鮮奶');
INSERT INTO public.ingredient VALUES (299, 7, '玫瑰普洱茶');
INSERT INTO public.ingredient VALUES (300, 7, '金萱茶');
INSERT INTO public.ingredient VALUES (301, 7, '珍珠');
INSERT INTO public.ingredient VALUES (302, 7, '粉條');
INSERT INTO public.ingredient VALUES (303, 7, '芋圓x薯圓');
INSERT INTO public.ingredient VALUES (304, 7, '錫蘭紅茶');
INSERT INTO public.ingredient VALUES (305, 7, '波霸/珍珠');
INSERT INTO public.ingredient VALUES (306, 7, '仙草');
INSERT INTO public.ingredient VALUES (307, 7, '桂花蜜');
INSERT INTO public.ingredient VALUES (308, 7, '淡奶（蒸發乳）');
INSERT INTO public.ingredient VALUES (309, 7, '可可粉');
INSERT INTO public.ingredient VALUES (310, 7, '抹茶粉');
INSERT INTO public.ingredient VALUES (311, 7, '話梅');
INSERT INTO public.ingredient VALUES (312, 7, '梅子');
INSERT INTO public.ingredient VALUES (313, 7, '檸檬');
INSERT INTO public.ingredient VALUES (314, 7, '荔枝');
INSERT INTO public.ingredient VALUES (315, 7, '茉莉綠茶');
INSERT INTO public.ingredient VALUES (316, 7, '荔枝果露');
INSERT INTO public.ingredient VALUES (317, 7, '養樂多');
INSERT INTO public.ingredient VALUES (318, 7, '百香果汁');
INSERT INTO public.ingredient VALUES (319, 7, '百香果');
INSERT INTO public.ingredient VALUES (320, 7, '椰果');
INSERT INTO public.ingredient VALUES (321, 7, '蘋果風味糖漿');
INSERT INTO public.ingredient VALUES (322, 7, '寒天');
INSERT INTO public.ingredient VALUES (323, 7, '檸檬汁');
INSERT INTO public.ingredient VALUES (324, 7, '鳳梨');
INSERT INTO public.ingredient VALUES (325, 7, '鳳梨汁');
INSERT INTO public.ingredient VALUES (326, 7, '芭樂汁');
INSERT INTO public.ingredient VALUES (327, 7, '芭樂');
INSERT INTO public.ingredient VALUES (328, 7, '金桔原汁');
INSERT INTO public.ingredient VALUES (329, 7, '化應子（台灣甲仙話梅）');
INSERT INTO public.ingredient VALUES (330, 7, '金桔');
INSERT INTO public.ingredient VALUES (331, 7, '蘆薈');
INSERT INTO public.ingredient VALUES (332, 7, '荔枝凍');
INSERT INTO public.ingredient VALUES (333, 7, '玫瑰果露');
INSERT INTO public.ingredient VALUES (334, 7, '愛玉');
INSERT INTO public.ingredient VALUES (335, 7, '桔子汁');
INSERT INTO public.ingredient VALUES (336, 7, '小紫蘇');
INSERT INTO public.ingredient VALUES (337, 7, '葡萄柚');
INSERT INTO public.ingredient VALUES (338, 7, '紅棗');
INSERT INTO public.ingredient VALUES (339, 7, '桂圓');
INSERT INTO public.ingredient VALUES (340, 7, '薑汁');
INSERT INTO public.ingredient VALUES (341, 7, '紫米');
INSERT INTO public.ingredient VALUES (342, 7, '可可/巧克力');
INSERT INTO public.ingredient VALUES (343, 8, '紅茶');
INSERT INTO public.ingredient VALUES (344, 8, '綠茶');
INSERT INTO public.ingredient VALUES (345, 8, '青茶');
INSERT INTO public.ingredient VALUES (346, 8, '金萱');
INSERT INTO public.ingredient VALUES (347, 8, '烏龍茶');
INSERT INTO public.ingredient VALUES (348, 8, '普洱茶');
INSERT INTO public.ingredient VALUES (349, 8, '紅葡萄柚果肉');
INSERT INTO public.ingredient VALUES (350, 8, '葡萄柚');
INSERT INTO public.ingredient VALUES (351, 8, '百香果');
INSERT INTO public.ingredient VALUES (352, 8, '檸檬');
INSERT INTO public.ingredient VALUES (353, 8, '檸檬汁');
INSERT INTO public.ingredient VALUES (354, 8, '柳橙');
INSERT INTO public.ingredient VALUES (355, 8, '柳丁汁');
INSERT INTO public.ingredient VALUES (356, 8, '蘋果濃縮汁');
INSERT INTO public.ingredient VALUES (357, 8, '蘋果');
INSERT INTO public.ingredient VALUES (358, 8, '蜜桃果肉');
INSERT INTO public.ingredient VALUES (359, 8, '水蜜桃');
INSERT INTO public.ingredient VALUES (360, 8, '楊桃汁');
INSERT INTO public.ingredient VALUES (361, 8, '楊桃');
INSERT INTO public.ingredient VALUES (362, 8, '楊桃蜜');
INSERT INTO public.ingredient VALUES (363, 8, '冬瓜茶');
INSERT INTO public.ingredient VALUES (364, 8, '甘蔗原汁');
INSERT INTO public.ingredient VALUES (365, 8, '豆漿');
INSERT INTO public.ingredient VALUES (366, 8, '鮮奶');
INSERT INTO public.ingredient VALUES (367, 8, '冬瓜');
INSERT INTO public.ingredient VALUES (368, 8, '可可粉');
INSERT INTO public.ingredient VALUES (369, 8, '蜂蜜');
INSERT INTO public.ingredient VALUES (370, 8, '四季春茶');
INSERT INTO public.ingredient VALUES (371, 8, '蘆薈');
INSERT INTO public.ingredient VALUES (372, 8, '奶精/奶粉');
INSERT INTO public.ingredient VALUES (373, 8, '奶精粉');
INSERT INTO public.ingredient VALUES (374, 8, '波霸/珍珠');
INSERT INTO public.ingredient VALUES (375, 8, '薑汁');
INSERT INTO public.ingredient VALUES (376, 9, '紅茶');
INSERT INTO public.ingredient VALUES (377, 9, '綠茶');
INSERT INTO public.ingredient VALUES (378, 9, '青茶');
INSERT INTO public.ingredient VALUES (379, 9, '烏龍茶');
INSERT INTO public.ingredient VALUES (380, 9, '檸檬');
INSERT INTO public.ingredient VALUES (381, 9, '檸檬汁');
INSERT INTO public.ingredient VALUES (382, 9, '梅醬');
INSERT INTO public.ingredient VALUES (383, 9, '金桔汁');
INSERT INTO public.ingredient VALUES (384, 9, '梅子醬');
INSERT INTO public.ingredient VALUES (385, 9, '金桔');
INSERT INTO public.ingredient VALUES (386, 9, '養樂多');
INSERT INTO public.ingredient VALUES (387, 9, '鳳梨');
INSERT INTO public.ingredient VALUES (388, 9, '鳳梨汁');
INSERT INTO public.ingredient VALUES (389, 9, '柚子醬');
INSERT INTO public.ingredient VALUES (390, 9, '柚子');
INSERT INTO public.ingredient VALUES (391, 9, '麵茶粉');
INSERT INTO public.ingredient VALUES (392, 9, '奶精/奶粉');
INSERT INTO public.ingredient VALUES (393, 9, '鮮奶油');
INSERT INTO public.ingredient VALUES (394, 9, '清查');
INSERT INTO public.ingredient VALUES (395, 9, '奶精');
INSERT INTO public.ingredient VALUES (396, 9, '可可粉');
INSERT INTO public.ingredient VALUES (397, 9, '波霸');
INSERT INTO public.ingredient VALUES (398, 9, '波霸/珍珠');
INSERT INTO public.ingredient VALUES (399, 9, '珍珠');
INSERT INTO public.ingredient VALUES (400, 9, '布丁');
INSERT INTO public.ingredient VALUES (401, 9, '椰果');
INSERT INTO public.ingredient VALUES (402, 9, '鮮奶');
INSERT INTO public.ingredient VALUES (403, 9, '梅子');
INSERT INTO public.ingredient VALUES (404, 9, '紅/綠/青/春茶');
INSERT INTO public.ingredient VALUES (405, 9, '芒果醬');
INSERT INTO public.ingredient VALUES (406, 9, '芒果');
INSERT INTO public.ingredient VALUES (407, 9, '荔枝');
INSERT INTO public.ingredient VALUES (408, 9, '荔枝醬');
INSERT INTO public.ingredient VALUES (409, 9, '冰淇淋');
INSERT INTO public.ingredient VALUES (410, 10, '咖啡濃縮液');
INSERT INTO public.ingredient VALUES (411, 10, '鮮奶');
INSERT INTO public.ingredient VALUES (412, 10, '珍珠');
INSERT INTO public.ingredient VALUES (413, 10, '粉角');
INSERT INTO public.ingredient VALUES (414, 10, '黑糖');
INSERT INTO public.ingredient VALUES (415, 10, '波霸/珍珠');
INSERT INTO public.ingredient VALUES (416, 10, '柚子');
INSERT INTO public.ingredient VALUES (417, 10, '紅柚醬');
INSERT INTO public.ingredient VALUES (418, 10, '檸檬');
INSERT INTO public.ingredient VALUES (419, 10, '檸檬汁');
INSERT INTO public.ingredient VALUES (420, 10, '檸檬片');
INSERT INTO public.ingredient VALUES (421, 10, '椰子');
INSERT INTO public.ingredient VALUES (422, 10, '生椰乳');
INSERT INTO public.ingredient VALUES (423, 10, '柳丁片');
INSERT INTO public.ingredient VALUES (424, 10, '柳丁汁');
INSERT INTO public.ingredient VALUES (425, 10, '柳丁');
INSERT INTO public.ingredient VALUES (426, 10, '玄米');
INSERT INTO public.ingredient VALUES (427, 10, '六條大麥');
INSERT INTO public.ingredient VALUES (428, 10, '薏仁');
INSERT INTO public.ingredient VALUES (429, 10, '蕎麥');
INSERT INTO public.ingredient VALUES (430, 10, '二條大麥');
INSERT INTO public.ingredient VALUES (431, 10, '決明子');
INSERT INTO public.ingredient VALUES (432, 10, '冬瓜露');
INSERT INTO public.ingredient VALUES (433, 10, '仙草');
INSERT INTO public.ingredient VALUES (434, 10, '鮮乳');
INSERT INTO public.ingredient VALUES (435, 10, '綠茶');
INSERT INTO public.ingredient VALUES (436, 10, '紅茶');
INSERT INTO public.ingredient VALUES (437, 10, '青茶');
INSERT INTO public.ingredient VALUES (438, 10, '焙茶');
INSERT INTO public.ingredient VALUES (439, 10, '烏龍茶');
INSERT INTO public.ingredient VALUES (440, 10, '仙草凍');
INSERT INTO public.ingredient VALUES (441, 10, '糖水');
INSERT INTO public.ingredient VALUES (442, 10, '椰果');
INSERT INTO public.ingredient VALUES (443, 10, '蜜香凍');
INSERT INTO public.ingredient VALUES (444, 10, '冬瓜');
INSERT INTO public.ingredient VALUES (445, 10, '奇亞籽');
INSERT INTO public.ingredient VALUES (446, 10, '金桔');
INSERT INTO public.ingredient VALUES (447, 10, '話梅');
INSERT INTO public.ingredient VALUES (448, 10, '金桔汁');
INSERT INTO public.ingredient VALUES (449, 10, '梅子');
INSERT INTO public.ingredient VALUES (450, 10, '芒果果露');
INSERT INTO public.ingredient VALUES (451, 10, '芒果');
INSERT INTO public.ingredient VALUES (452, 10, '百香果');
INSERT INTO public.ingredient VALUES (453, 10, '葡萄柚');
INSERT INTO public.ingredient VALUES (454, 10, '芒果醬');
INSERT INTO public.ingredient VALUES (455, 10, '冬瓜茶');
INSERT INTO public.ingredient VALUES (456, 10, '蕎麥茶');
INSERT INTO public.ingredient VALUES (457, 10, '養樂多');
INSERT INTO public.ingredient VALUES (458, 10, '草莓');
INSERT INTO public.ingredient VALUES (459, 10, '蔓越莓');
INSERT INTO public.ingredient VALUES (460, 10, '奶精/奶粉');
INSERT INTO public.ingredient VALUES (461, 10, '布丁');
INSERT INTO public.ingredient VALUES (462, 10, '擂茶');
INSERT INTO public.ingredient VALUES (463, 10, '芋泥');
INSERT INTO public.ingredient VALUES (464, 10, '芋泥；鮮奶');


--
-- Data for Name: marketing_content; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.marketing_content VALUES (1, 1, 'FB', '[Text] 黑霸烏龍奶', '＼迎接假期！／
限時 #買一送一 先開喝！
來杯「黑霸烏龍奶」提前進入𝐇𝐨𝐥𝐢𝐝𝐚𝐲 𝐌𝐨𝐝𝐞
年假即將來臨，忙碌中還是要懂得享受 ·͜·♡
給準備放假的你，一個剛好的理由
#限時優惠 𝟎𝟐.𝟎𝟗 - 𝟎𝟐.𝟏𝟑 ─── .✦.
聯名限定．#黑霸烏龍奶 限時買❶送❶！
烏龍奶茶暗藏火力，遇上波霸的甜蜜攻擊
猶如出拳前的蓄勢待發！一口引爆烈焰
假期來臨！就讓「黑霸烏龍奶」來開場！
．活動限來店；每人限購2 組。
．本優惠不得與其他優惠併用。
#電影 #功夫 #九把刀作品
#0213 全台盛大上映', '2026-02-02 00:00:00', 1216);
INSERT INTO public.marketing_content VALUES (2, 1, 'FB', '[Text] 黑霸烏龍奶', '電影的狠勁，都在 #黑霸烏龍奶 內！
不張揚，卻很有立場 ────────.✦.
九把刀執導並改編自同名小說
最擅長的熱血情感與逆襲快感
揭開九把刀宇宙的華麗篇章 .ılı.lı.ıl
把故事裝進手裡的「黑霸烏龍奶」
燃起內心無限可能，登頂功夫之巔！
一馬當先、霸氣開春！𝟎𝟐.𝟏𝟑戲院見
#電影 #功夫 #九把刀作品
#0213 全台盛大上映
黑糖波霸秘煉𝟏𝟐𝟎分，層層吸收黑糖精華', '2026-01-21 00:00:00', 38);
INSERT INTO public.marketing_content VALUES (3, 1, 'FB', '[Text] 黑霸烏龍奶', '與烏龍奶茶正面交鋒！沉穩茶香隨奶香釋放~
焙香、奶香暗藏火力，濃烈不失細膩
九把刀最強奇幻動作電影《功夫》
配上用真功夫製作的「黑霸烏龍奶」
聯手來場充滿力量的手搖體驗！
𝟎𝟐.𝟏𝟑 - 𝟎𝟑.𝟎𝟖 ─.✦.───
享「黑霸烏龍奶」#現折10 元優惠 ◡̎
憑當月份《功夫》電影票根
𝟎𝟐.𝟎𝟗 - 𝟎𝟐.𝟏𝟑 ─.✦.───
購買「黑霸烏龍奶」即享 #買1 送1
．每張票根限折乙杯。買一送一限購2 組。
．活動限來店；不得與其他優惠併用。
#電影 #功夫 #九把刀作品
#0213 全台盛大上映
即將迎來新年第一天，好心情一起打包◡̎', '2026-01-16 00:00:00', 35);
INSERT INTO public.marketing_content VALUES (4, 1, 'FB', '[Text] 蜜桃胭脂紅茶', '𝟐𝟎𝟐𝟔.𝟎𝟏.𝟎𝟏 #元旦限定 —————
▹ ▸ 蜜桃胭脂紅茶〔買一送一〕.ᐟᐟ.
#蜜桃胭脂紅茶
𝐏𝐞𝐚𝐜𝐡 𝐁𝐥𝐚𝐜𝐤 𝐓𝐞𝐚
桃香與茶香完美並存的單品紅茶
淡淡香氣有如剛摘下的蜜桃，沿途留香
新的一年，一起舉杯歡慶
感受到茶香細膩，輕盈清爽～
．每人限購乙組。活動限來店
．優惠不得合併使用。數量有限售完為止
#元旦 #新年快樂 #HappyNewYear
＼聖誕節快樂！／𝐌𝐞𝐫𝐫𝐲 𝐂𝐡𝐫𝐢𝐬𝐭𝐦𝐚𝐬     
 
濃濃的聖誕氛圍，剛剛好就很溫暖！ 
用一杯柔順的拿鐵，還有一杯清爽的茶， 
將忙碌拋在腦後，把美好留給自己吧◡̎', '2025-12-31 00:00:00', 570);
INSERT INTO public.marketing_content VALUES (7, 1, 'FB', '[Text] 烏龍觀音拿鐵', '幫你找到最適合今日心情的組合 .ᐟᐟ.
𝟏𝟏.𝟎𝟏-𝟎𝟏.𝟏𝟏｜雙饗茶會  
𝐏𝐚𝐢𝐫 + 𝐒𝐡𝐚𝐫𝐞，各選一杯，享優惠價
𝐏𝐚𝐢𝐫 ｜原境茶選
隱山烏龍 ✧ 功夫茶王 
 𝐒𝐡𝐚𝐫𝐞｜醇厚拿鐵
岩葉紅茶拿鐵 ꕤ 烏龍觀音拿鐵 ꕤ 蜜桃胭脂拿鐵 
 
꒰ 隱山烏龍 × 烏龍觀音拿鐵 ꒱ 
最適合想要獨處、沉澱心情的你
沉穩安定的茶香，忙碌後優雅慢下腳步
最適合缺乏活力、急需朋友慰藉的你 
與好友暢聊、釋放壞情緒的最佳能量飲品
#KUNGFUTEA 功夫茶 #功夫茶 
#隱山烏龍 #雙饗茶會 #優惠活動', '2025-11-06 00:00:00', 32);
INSERT INTO public.marketing_content VALUES (8, 1, 'FB', '[Text] 岩葉紅茶拿鐵', '幫你找到最適合今日心情的組合 .ᐟᐟ.
𝟏𝟏.𝟎𝟏-𝟎𝟏.𝟏𝟏｜雙饗茶會  
𝐏𝐚𝐢𝐫 + 𝐒𝐡𝐚𝐫𝐞，各選一杯，享優惠價
𝐏𝐚𝐢𝐫 ｜原境茶選
隱山烏龍 ✧ 功夫茶王 
 𝐒𝐡𝐚𝐫𝐞｜醇厚拿鐵
岩葉紅茶拿鐵 ꕤ 烏龍觀音拿鐵 ꕤ 蜜桃胭脂拿鐵 
 
꒰ 隱山烏龍 × 烏龍觀音拿鐵 ꒱ 
最適合想要獨處、沉澱心情的你
沉穩安定的茶香，忙碌後優雅慢下腳步
最適合缺乏活力、急需朋友慰藉的你 
與好友暢聊、釋放壞情緒的最佳能量飲品
#KUNGFUTEA 功夫茶 #功夫茶 
#隱山烏龍 #雙饗茶會 #優惠活動', '2025-11-06 00:00:00', 32);
INSERT INTO public.marketing_content VALUES (9, 1, 'FB', '[Text] 蜜桃胭脂拿鐵', '幫你找到最適合今日心情的組合 .ᐟᐟ.
𝟏𝟏.𝟎𝟏-𝟎𝟏.𝟏𝟏｜雙饗茶會  
𝐏𝐚𝐢𝐫 + 𝐒𝐡𝐚𝐫𝐞，各選一杯，享優惠價
𝐏𝐚𝐢𝐫 ｜原境茶選
隱山烏龍 ✧ 功夫茶王 
 𝐒𝐡𝐚𝐫𝐞｜醇厚拿鐵
岩葉紅茶拿鐵 ꕤ 烏龍觀音拿鐵 ꕤ 蜜桃胭脂拿鐵 
 
꒰ 隱山烏龍 × 烏龍觀音拿鐵 ꒱ 
最適合想要獨處、沉澱心情的你
沉穩安定的茶香，忙碌後優雅慢下腳步
最適合缺乏活力、急需朋友慰藉的你 
與好友暢聊、釋放壞情緒的最佳能量飲品
#KUNGFUTEA 功夫茶 #功夫茶 
#隱山烏龍 #雙饗茶會 #優惠活動', '2025-11-06 00:00:00', 32);
INSERT INTO public.marketing_content VALUES (10, 1, 'FB', '[Text] 功夫茶王', '幫你找到最適合今日心情的組合 .ᐟᐟ.
𝟏𝟏.𝟎𝟏-𝟎𝟏.𝟏𝟏｜雙饗茶會  
𝐏𝐚𝐢𝐫 + 𝐒𝐡𝐚𝐫𝐞，各選一杯，享優惠價
𝐏𝐚𝐢𝐫 ｜原境茶選
隱山烏龍 ✧ 功夫茶王 
 𝐒𝐡𝐚𝐫𝐞｜醇厚拿鐵
岩葉紅茶拿鐵 ꕤ 烏龍觀音拿鐵 ꕤ 蜜桃胭脂拿鐵 
 
꒰ 隱山烏龍 × 烏龍觀音拿鐵 ꒱ 
最適合想要獨處、沉澱心情的你
沉穩安定的茶香，忙碌後優雅慢下腳步
最適合缺乏活力、急需朋友慰藉的你 
與好友暢聊、釋放壞情緒的最佳能量飲品
#KUNGFUTEA 功夫茶 #功夫茶 
#隱山烏龍 #雙饗茶會 #優惠活動', '2025-11-06 00:00:00', 32);
INSERT INTO public.marketing_content VALUES (11, 1, 'FB', '[Text] 隱山烏龍', '幫你找到最適合今日心情的組合 .ᐟᐟ.
𝟏𝟏.𝟎𝟏-𝟎𝟏.𝟏𝟏｜雙饗茶會  
𝐏𝐚𝐢𝐫 + 𝐒𝐡𝐚𝐫𝐞，各選一杯，享優惠價
𝐏𝐚𝐢𝐫 ｜原境茶選
隱山烏龍 ✧ 功夫茶王 
 𝐒𝐡𝐚𝐫𝐞｜醇厚拿鐵
岩葉紅茶拿鐵 ꕤ 烏龍觀音拿鐵 ꕤ 蜜桃胭脂拿鐵 
 
꒰ 隱山烏龍 × 烏龍觀音拿鐵 ꒱ 
最適合想要獨處、沉澱心情的你
沉穩安定的茶香，忙碌後優雅慢下腳步
最適合缺乏活力、急需朋友慰藉的你 
與好友暢聊、釋放壞情緒的最佳能量飲品
#KUNGFUTEA 功夫茶 #功夫茶 
#隱山烏龍 #雙饗茶會 #優惠活動', '2025-11-06 00:00:00', 32);
INSERT INTO public.marketing_content VALUES (12, 1, 'FB', '[Text] 38奶霸', '𝑻𝒐𝒑 𝑷𝒊𝒄𝒌 ✧ 38 奶霸 ✧ 超有料
萬聖節就喝這杯，不喝就搗蛋 .ᐟ.ᐟ
最黑的夜空揉成焦糖圓球 𖣐 
點綴上晶瑩寶石、黑夜濃霧
喝一口，幸福感爆棚，超滿足 ෆ
𝓗𝓐𝓟𝓟𝓨  𝓗𝓐𝓛𝓛𝓞𝓦𝓔𝓔𝓝
꒦꒷꒦꒷꒦꒷꒦꒷꒦꒷꒦꒷꒦꒷꒦꒷꒦꒷꒦꒷꒦꒷꒦꒷
#KUNGFUTEA 功夫茶 #功夫茶 #萬聖節', '2025-10-30 00:00:00', 30);
INSERT INTO public.marketing_content VALUES (13, 1, 'FB', '[Text] 隱山烏龍', '連假出遊，熱到快融化
真想來杯沁涼解渴的飲料 .ᐟ ᐟ.
꒰ 隱山烏龍 ꒱ 𝓷𝓮𝔀
茶香四溢，順口不苦澀
冰涼清爽，一掃身體的燥熱 ❆
無糖限定，感受最純粹的茶香♡
隱山烏龍・沁涼上市
是你連假出遊的最佳夥伴 ✧˚.
#隱山烏龍 #無糖茶 #國慶日
中秋節快樂𓂃⟡.·𓂃 
吃柚子、嚐月餅、烤肉一口接一口', '2025-10-09 00:00:00', 406);
INSERT INTO public.marketing_content VALUES (14, 1, 'FB', '[Text] 隱山烏龍', '團員聚會好熱鬧，親朋好友共度好時光 ✦
來一杯 
 隱山烏龍 𝒏𝒆𝒘
回甘不苦澀，入喉沁涼解渴
無糖限定，讓你喝得安心無負擔
團圓賞月，舉杯歡聚
清爽過中秋，就選隱山烏龍！
#隱山烏龍 #中秋節快樂 #無糖也好喝', '2025-10-04 00:00:00', 21);
INSERT INTO public.marketing_content VALUES (15, 2, 'FB', '[Text] 柳橙翡翠青', '#柳橙翡翠青 #經典回歸
剛剛好，你也還在
剛剛好，我也沒變
我們一起等到——
柳橙最剛好的時刻
這不是提早，也不是將就
而是等到果香最飽滿、酸甜最平衡
才願意端出的那一杯
這份陽光下的鮮甜美好
是去年度季節限定 No.1 的回憶
也是今年，終於等到的完美風味
我們再一次，回味重遊
柳橙翡翠青
1/26（一）全台經典回歸上市
嚴選鮮甜柳橙
搭配沁涼爽口的翡翠青茶
在柳橙最佳成熟時刻榨取
完整保留果香層次與清爽茶韻
年度好評敲碗回歸 !
｜大茗官方網站｜https://www.damingtea.com.tw
#大茗本位製茶堂 #柳橙翡翠青經典回歸', '2026-01-23 00:00:00', 76);
INSERT INTO public.marketing_content VALUES (16, 2, 'FB', '[Text] 懷舊經典奶茶', '#
  
#啟動年末微醺儀式 #莓醉雙奏章幸福聯乘
#勤美誠品綠園道限定 #聯名酒精飲特調
草莓飲品喝不夠
要再來點Chill 的嗎
我們從上波爵士音樂節的茶酒特調再次昇華
這波莓醉的幸福耶誕禮，明日起限定開喝
DAMING X Teapsy 丨 莓醉雙奏章
12/24(三) - 12/31(三) 限時8 天
⭓ 莓醉玉露 / 4% vol. / ★★★★★ 
(玉露奶青/草莓果釀/原萃青茶茶酒)
細緻奶青交織甜蜜草莓果香
滿滿草莓奶酒的微醺清甜
⭓ 莓醺奶紅 / 4% vol. / ★★★★★
(懷舊經典奶茶/草莓果釀/原萃紅茶茶酒)
濃郁的古早味奶紅配上草莓甜酸
溫潤迷人～莓醉又回味的Chill
/ / / 
* 未滿18 歲禁止飲酒
* 喝酒不開車，安全有保障
大茗本位製茶堂丨勤美誠品綠園道店
地址：台中市西區公益路68 號B1
電話：04-2321-0823
｜大茗官方網站｜https://www.damingtea.com.tw
莓醉雙奏章 丨 限定聯名酒精飲特調
@daming_tea @teapsyco_official', '2025-12-23 00:00:00', 60);
INSERT INTO public.marketing_content VALUES (17, 2, 'FB', '[Text] 玉露奶青', '#
  
#啟動年末微醺儀式 #莓醉雙奏章幸福聯乘
#勤美誠品綠園道限定 #聯名酒精飲特調
草莓飲品喝不夠
要再來點Chill 的嗎
我們從上波爵士音樂節的茶酒特調再次昇華
這波莓醉的幸福耶誕禮，明日起限定開喝
DAMING X Teapsy 丨 莓醉雙奏章
12/24(三) - 12/31(三) 限時8 天
⭓ 莓醉玉露 / 4% vol. / ★★★★★ 
(玉露奶青/草莓果釀/原萃青茶茶酒)
細緻奶青交織甜蜜草莓果香
滿滿草莓奶酒的微醺清甜
⭓ 莓醺奶紅 / 4% vol. / ★★★★★
(懷舊經典奶茶/草莓果釀/原萃紅茶茶酒)
濃郁的古早味奶紅配上草莓甜酸
溫潤迷人～莓醉又回味的Chill
/ / / 
* 未滿18 歲禁止飲酒
* 喝酒不開車，安全有保障
大茗本位製茶堂丨勤美誠品綠園道店
地址：台中市西區公益路68 號B1
電話：04-2321-0823
｜大茗官方網站｜https://www.damingtea.com.tw
莓醉雙奏章 丨 限定聯名酒精飲特調
@daming_tea @teapsyco_official', '2025-12-23 00:00:00', 60);
INSERT INTO public.marketing_content VALUES (19, 2, 'FB', '[OCR] 翡翠莓香', '#莓光甜室
Sweet Berry Moments
12/10(三)全台新品上市
讓每一天，
都有一點柔軟的甜。
融進口裡，收在心裡
｜大茗官方網站｜https://www.damingtea.com.tw
#草莓要來了
 #就是下周
#大茗本位製茶堂', '2025-12-02 00:00:00', 309);
INSERT INTO public.marketing_content VALUES (20, 2, 'FB', '[Text] 芒果青', '#芒果青 #青熟感限定茗作
熱烈加開！熱烈加開！
這杯獻給你，用芒果的酸甜填滿日常的空隙。
喝過才知道，大茗的味道真的上癮
在地芒果細火慢熬出的天然熟果香，
喝過的都驚嘆
 限量開賣再擴大開催～～
手工芒果醬 ✕ 翡翠青茶
11/14(五)起 中區、彰化、嘉義、斗六門市限量開喝！
｜大茗官方網站｜https://www.damingtea.com.tw/
#芒果青 #指定區域門市開喝
#大茗本位製茶堂', '2025-11-11 00:00:00', 11);
INSERT INTO public.marketing_content VALUES (21, 2, 'FB', '[Text] 芫荽酪梨奶蓋', '這個萬聖節，不搞怪也能很有戲
芫荽與酪梨攜手施展綠色魔法，三款奶蓋茶限時登場，
每一口都是萬聖夜的神秘咒語——清香、焙香、還有一點暗夜的驚喜
萬聖限定・芫荽酪梨奶蓋系列
2025/10/31-11/2
綠茶｜清新登場
清爽綠茶遇上芫荽酪梨奶蓋，淡雅香氣裡帶點意外驚喜
蕎麥｜焙香現身
焙香蕎麥融合草本奶蓋的柔滑，香氣溫潤，喝起來很舒服
烏龍｜暗夜限定
炭焙茶香交織酪梨奶香，層次豐富又細膩
每日限量供應
限現場購買
可先來電門市詢問
｜大茗官方網站｜https://www.damingtea.com.tw/
#大茗新品上市 #萬聖節限定 #芫荽酪梨奶蓋
#大茗本位製茶堂', '2025-10-28 00:00:00', 227);
INSERT INTO public.marketing_content VALUES (22, 2, 'FB', '[Text] 芒果青', '#芒果青 #青熟感限定茗作
#北區南區第二波指定門市開喝
熱烈加開！熱烈加開！
這杯獻給你，也許你心裡的洞能被填滿一點？
大茗你就愛了吧！哪次不愛
在地芒果細火慢熬出的天然熟果香
喝過的都驚嘆 第二波指定店限量販售開催～～
手工芒果醬 ✕ 翡翠青茶
10/23(四)起第二波區域門市限量開喝
指定販售門市
北區指定門市
台北公館 / 台北內湖 / 桃園藝文
新竹城隍 / 新竹金山 / 竹南博愛
中區指定門市
勤美模範 / 台中高工 / 台中水湳
逢甲西屯 / 逢甲福星 / 漢口青海
* 11/14(五)起中區全門市供應
南區指定門市
台南中正 / 台南中華
高雄至聖 / 高雄自強 / 高雄裕誠
高雄文化 / 高雄楠梓 / 高雄岡山
｜大茗官方網站｜https://www.damingtea.com.tw/
#芒果青 #第二波指定區域門市開喝
#大茗本位製茶堂', '2025-10-22 00:00:00', 14);
INSERT INTO public.marketing_content VALUES (24, 2, 'FB', '[Text] 珈琲粉粿蕎麥奶', 'DAMING | Happy Moon Festival
中秋烤肉聚餐，解膩神隊友必不可少
#玉露青茶 —— 清爽解膩、涼意滿滿
#熟成油切蕎麥 —— 助你油膩OUT、暢快加倍
想換換口味也可以點
#珈琲粉粿蕎麥奶 —— 一口濃郁烘焙香氣，一口滑順溫柔的老派浪漫。
#珍珠粉粿牛奶 ——珍珠＋粉粿＝雙重咬感爆擊！雙料大滿足
聚會來上一杯，中秋就更圓滿。
㊗️大家中秋節快樂
｜大茗官方網站｜https://www.damingtea.com.tw/
#大茗本位製茶堂 #中秋節快樂', '2025-10-05 00:00:00', 17);
INSERT INTO public.marketing_content VALUES (25, 2, 'FB', '[Text] 熟成油切蕎麥', 'DAMING | Happy Moon Festival
中秋烤肉聚餐，解膩神隊友必不可少
#玉露青茶 —— 清爽解膩、涼意滿滿
#熟成油切蕎麥 —— 助你油膩OUT、暢快加倍
想換換口味也可以點
#珈琲粉粿蕎麥奶 —— 一口濃郁烘焙香氣，一口滑順溫柔的老派浪漫。
#珍珠粉粿牛奶 ——珍珠＋粉粿＝雙重咬感爆擊！雙料大滿足
聚會來上一杯，中秋就更圓滿。
㊗️大家中秋節快樂
｜大茗官方網站｜https://www.damingtea.com.tw/
#大茗本位製茶堂 #中秋節快樂', '2025-10-05 00:00:00', 17);
INSERT INTO public.marketing_content VALUES (26, 2, 'FB', '[Text] 珍珠粉粿牛奶', 'DAMING | Happy Moon Festival
中秋烤肉聚餐，解膩神隊友必不可少
#玉露青茶 —— 清爽解膩、涼意滿滿
#熟成油切蕎麥 —— 助你油膩OUT、暢快加倍
想換換口味也可以點
#珈琲粉粿蕎麥奶 —— 一口濃郁烘焙香氣，一口滑順溫柔的老派浪漫。
#珍珠粉粿牛奶 ——珍珠＋粉粿＝雙重咬感爆擊！雙料大滿足
聚會來上一杯，中秋就更圓滿。
㊗️大家中秋節快樂
｜大茗官方網站｜https://www.damingtea.com.tw/
#大茗本位製茶堂 #中秋節快樂', '2025-10-05 00:00:00', 17);
INSERT INTO public.marketing_content VALUES (27, 2, 'FB', '[Text] 玉露青茶', 'DAMING | Happy Moon Festival
中秋烤肉聚餐，解膩神隊友必不可少
#玉露青茶 —— 清爽解膩、涼意滿滿
#熟成油切蕎麥 —— 助你油膩OUT、暢快加倍
想換換口味也可以點
#珈琲粉粿蕎麥奶 —— 一口濃郁烘焙香氣，一口滑順溫柔的老派浪漫。
#珍珠粉粿牛奶 ——珍珠＋粉粿＝雙重咬感爆擊！雙料大滿足
聚會來上一杯，中秋就更圓滿。
㊗️大家中秋節快樂
｜大茗官方網站｜https://www.damingtea.com.tw/
#大茗本位製茶堂 #中秋節快樂', '2025-10-05 00:00:00', 17);
INSERT INTO public.marketing_content VALUES (28, 2, 'FB', '[Text] 芒果青', '細火慢熬，以手作果醬入茶
#芒果青 #青熟感限定茗作
#台中首波指定門市上車囉
嚴選台灣在地芒果，手作慢熬釋放天然果香，
以黃金比例入茗翡翠青，果香與茶韻完美交織。
清爽回甘、果甜不膩
青熟感限定茗作 手工芒果醬✕翡翠茶
9/19(五)起指定區域首波限量開喝
指定販售門市
勤美模範 / 台中高工
台中水湳 / 逢甲西屯
逢甲福星 / 台中大雅
漢口青海 / 勤美誠品
嘉義民族
｜大茗官方網站｜https://www.damingtea.com.tw/
#大茗新品上市 #芒果青
#大茗本位製茶 #台中首波上市
v', '2025-09-17 00:00:00', 39);
INSERT INTO public.marketing_content VALUES (29, 2, 'FB', '[Text] 珈琲粉粿蕎麥奶', '#七夕
用一杯飲料，說盡我想對你說的情話
#珈琲粉粿蕎麥奶
牛郎織女一年見一次，
我要的是和你天天共享一杯老派的浪漫。
#珍珠粉粿牛奶
你是珍珠，我是粉粿，
我們加在一起就是最對味的愛情。
𝘁𝗮𝗴 你最想共享一杯的他/她 ♡
今年七夕，就用Ｑ彈的「 老派浪漫」告白，
#七夕 #七夕情人節 #老派靈魂新派味道
#大茗新品 #珈琲粉粿蕎麥奶 #珍珠粉粿牛奶
#大茗本位製茶堂 #新品上市', '2025-08-29 00:00:00', 10);
INSERT INTO public.marketing_content VALUES (30, 2, 'FB', '[Text] 珍珠粉粿牛奶', '#七夕
用一杯飲料，說盡我想對你說的情話
#珈琲粉粿蕎麥奶
牛郎織女一年見一次，
我要的是和你天天共享一杯老派的浪漫。
#珍珠粉粿牛奶
你是珍珠，我是粉粿，
我們加在一起就是最對味的愛情。
𝘁𝗮𝗴 你最想共享一杯的他/她 ♡
今年七夕，就用Ｑ彈的「 老派浪漫」告白，
#七夕 #七夕情人節 #老派靈魂新派味道
#大茗新品 #珈琲粉粿蕎麥奶 #珍珠粉粿牛奶
#大茗本位製茶堂 #新品上市', '2025-08-29 00:00:00', 10);
INSERT INTO public.marketing_content VALUES (31, 3, 'FB', '[Text] 芝士奶蓋緋烏龍', '身處湧動時代 復古卻成了新語言
偕茶師重新對焦
#緋烏龍系列 再次加載登場！
全新風味升級：首次加入緋烏龍、馥莓緋烏龍
在新與舊之間
注入靈魂播放昔日回憶
緋紅序曲已揭幕
邀你舉杯，共襄年末盛宴
> .collection - "𝓡ed Oolong Tea 緋烏龍系列"
.
[0]  緋烏龍........................M 35｜L 40
[1]  馥莓緋烏龍................M 50｜L 60
[2]  緋烏龍奶茶................M 50｜L 55
[3]  緋烏龍鮮奶................M 60｜L 70
[4]  芝士奶蓋緋烏龍........M 55｜L 65
STATUS: 全門市販售中
𝑪𝒉𝒂𝒑𝒕𝒆𝒓 𝟎𝟒｜芝士奶蓋緋烏龍  Cheese Milk Foam 𝓡ed Oolong Tea', '2025-12-17 00:00:00', 50);
INSERT INTO public.marketing_content VALUES (32, 3, 'FB', '[Text] 緋烏龍奶茶', '身處湧動時代 復古卻成了新語言
偕茶師重新對焦
#緋烏龍系列 再次加載登場！
全新風味升級：首次加入緋烏龍、馥莓緋烏龍
在新與舊之間
注入靈魂播放昔日回憶
緋紅序曲已揭幕
邀你舉杯，共襄年末盛宴
> .collection - "𝓡ed Oolong Tea 緋烏龍系列"
.
[0]  緋烏龍........................M 35｜L 40
[1]  馥莓緋烏龍................M 50｜L 60
[2]  緋烏龍奶茶................M 50｜L 55
[3]  緋烏龍鮮奶................M 60｜L 70
[4]  芝士奶蓋緋烏龍........M 55｜L 65
STATUS: 全門市販售中
𝑪𝒉𝒂𝒑𝒕𝒆𝒓 𝟎𝟒｜芝士奶蓋緋烏龍  Cheese Milk Foam 𝓡ed Oolong Tea', '2025-12-17 00:00:00', 50);
INSERT INTO public.marketing_content VALUES (33, 3, 'FB', '[Text] 緋烏龍鮮奶', '身處湧動時代 復古卻成了新語言
偕茶師重新對焦
#緋烏龍系列 再次加載登場！
全新風味升級：首次加入緋烏龍、馥莓緋烏龍
在新與舊之間
注入靈魂播放昔日回憶
緋紅序曲已揭幕
邀你舉杯，共襄年末盛宴
> .collection - "𝓡ed Oolong Tea 緋烏龍系列"
.
[0]  緋烏龍........................M 35｜L 40
[1]  馥莓緋烏龍................M 50｜L 60
[2]  緋烏龍奶茶................M 50｜L 55
[3]  緋烏龍鮮奶................M 60｜L 70
[4]  芝士奶蓋緋烏龍........M 55｜L 65
STATUS: 全門市販售中
𝑪𝒉𝒂𝒑𝒕𝒆𝒓 𝟎𝟒｜芝士奶蓋緋烏龍  Cheese Milk Foam 𝓡ed Oolong Tea', '2025-12-17 00:00:00', 50);
INSERT INTO public.marketing_content VALUES (34, 3, 'FB', '[Text] 馥莓緋烏龍', '身處湧動時代 復古卻成了新語言
偕茶師重新對焦
#緋烏龍系列 再次加載登場！
全新風味升級：首次加入緋烏龍、馥莓緋烏龍
在新與舊之間
注入靈魂播放昔日回憶
緋紅序曲已揭幕
邀你舉杯，共襄年末盛宴
> .collection - "𝓡ed Oolong Tea 緋烏龍系列"
.
[0]  緋烏龍........................M 35｜L 40
[1]  馥莓緋烏龍................M 50｜L 60
[2]  緋烏龍奶茶................M 50｜L 55
[3]  緋烏龍鮮奶................M 60｜L 70
[4]  芝士奶蓋緋烏龍........M 55｜L 65
STATUS: 全門市販售中
𝑪𝒉𝒂𝒑𝒕𝒆𝒓 𝟎𝟒｜芝士奶蓋緋烏龍  Cheese Milk Foam 𝓡ed Oolong Tea', '2025-12-17 00:00:00', 50);
INSERT INTO public.marketing_content VALUES (83, 5, 'FB', '[Text] 茉綠茶凍拿鐵', '清心福全×變種吉娃娃 
連假超吉美食推薦
連假少不了的吃吃喝喝，「超吉」搭配超過癮！
吉凍套餐：脆皮吉排＆茉綠茶凍拿鐵，一口酥脆一口Q 嗲嗲的絕妙搭配（￣︶
￣）
#清心福全 #手搖飲料 #變種吉娃娃 #連假限定 #茉綠茶凍拿鐵', '2025-10-23 00:00:00', 333);
INSERT INTO public.marketing_content VALUES (35, 3, 'FB', '[Text] 緋烏龍', '身處湧動時代 復古卻成了新語言
偕茶師重新對焦
#緋烏龍系列 再次加載登場！
全新風味升級：首次加入緋烏龍、馥莓緋烏龍
在新與舊之間
注入靈魂播放昔日回憶
緋紅序曲已揭幕
邀你舉杯，共襄年末盛宴
> .collection - "𝓡ed Oolong Tea 緋烏龍系列"
.
[0]  緋烏龍........................M 35｜L 40
[1]  馥莓緋烏龍................M 50｜L 60
[2]  緋烏龍奶茶................M 50｜L 55
[3]  緋烏龍鮮奶................M 60｜L 70
[4]  芝士奶蓋緋烏龍........M 55｜L 65
STATUS: 全門市販售中
𝑪𝒉𝒂𝒑𝒕𝒆𝒓 𝟎𝟒｜芝士奶蓋緋烏龍  Cheese Milk Foam 𝓡ed Oolong Tea', '2025-12-17 00:00:00', 50);
INSERT INTO public.marketing_content VALUES (36, 3, 'FB', '[Text] 緋烏龍鮮奶', '收音機嗡嗡作響
戴上耳機隔出一片自在zone
音符在空氣跳躍
鹹香芝士奶蓋
佐緋烏龍獨有熟果前調及蜜香喉韻
Volume up ! 𝓡eloading on 𝟏𝟐/𝟏𝟕 （﹙˓  ˒﹚）
滋味醇厚、回甘悠長
𝑪𝒉𝒂𝒑𝒕𝒆𝒓 𝟎𝟑｜緋烏龍鮮奶 𝓡ed Oolong Tea Latte', '2025-12-12 00:00:00', 49);
INSERT INTO public.marketing_content VALUES (37, 3, 'FB', '[Text] 緋烏龍', '收音機嗡嗡作響
戴上耳機隔出一片自在zone
音符在空氣跳躍
鹹香芝士奶蓋
佐緋烏龍獨有熟果前調及蜜香喉韻
Volume up ! 𝓡eloading on 𝟏𝟐/𝟏𝟕 （﹙˓  ˒﹚）
滋味醇厚、回甘悠長
𝑪𝒉𝒂𝒑𝒕𝒆𝒓 𝟎𝟑｜緋烏龍鮮奶 𝓡ed Oolong Tea Latte', '2025-12-12 00:00:00', 49);
INSERT INTO public.marketing_content VALUES (38, 3, 'FB', '[Text] 馥莓緋烏龍', '調整焦距，緋紅身影漸漸清晰
熟果基調揉合烏龍韻
奶香柔潤細膩
覆蓋舌尖
每口都是風味的細膩映像
帶著去年的悸動
Keep rolling ! 𝓡eloading on 𝟏𝟐/𝟏𝟕
回憶幀幀重現，逐格展開
𝑪𝒉𝒂𝒑𝒕𝒆𝒓 𝟎𝟐｜馥莓緋烏龍 Berrys 𝓡ed Oolong Tea', '2025-12-11 00:00:00', 73);
INSERT INTO public.marketing_content VALUES (39, 3, 'FB', '[Text] 緋烏龍', '調整焦距，緋紅身影漸漸清晰
熟果基調揉合烏龍韻
奶香柔潤細膩
覆蓋舌尖
每口都是風味的細膩映像
帶著去年的悸動
Keep rolling ! 𝓡eloading on 𝟏𝟐/𝟏𝟕
回憶幀幀重現，逐格展開
𝑪𝒉𝒂𝒑𝒕𝒆𝒓 𝟎𝟐｜馥莓緋烏龍 Berrys 𝓡ed Oolong Tea', '2025-12-11 00:00:00', 73);
INSERT INTO public.marketing_content VALUES (40, 3, 'FB', '[Text] 緋烏龍', '循電波傳遞酸甜訊號  • ılıılıılılıılıılı. 0
紫桑率先登場
緋烏龍沉靜其後，釋放熟果木質溫潤
再以覆盆子微酸收束
莓緋色澤
內斂卻蘊藏深意
Don’t hang up! 𝓡eloading on 𝟏𝟐/𝟏𝟕
以嫣紅映照明媚冬日與土地回甘
𝑪𝒉𝒂𝒑𝒕𝒆𝒓 𝟎𝟏｜緋烏龍 𝓡ed Oolong Tea', '2025-12-10 00:00:00', 77);
INSERT INTO public.marketing_content VALUES (41, 3, 'FB', '[Text] 緋烏龍', '#緋烏龍 ｛ 𝖿ē𝗂 𝗐𝗎𝗅ó𝗇𝗀｝ 選用台東紅烏龍，以夏秋茶葉為本結合紅茶加工特點，採重
指尖穿梭光影翩然敲打，緋紅色溫於膠卷顯影
發酵製成，果韻滋味明亮飽滿。
因水色呈現橙紅色澤而得名，一入口就能感受熟果及木質圓潤香氣，風味甘甜且喉韻
今年！原茶款首次加入，風味純粹卻足以撩動心弦 𝓡eloading on 𝟏𝟐/𝟏𝟕
悠長，紅韻入杯紅玉香、烏龍韻，香氣縈繞層次分明。', '2025-12-09 00:00:00', 58);
INSERT INTO public.marketing_content VALUES (49, 4, 'FB', '[Text] 英式玫瑰特調茶', 'HAPPY FRIDAY｜𝟮/𝟭𝟯 情人節必喝  玫瑰限定    玫瑰水、英式玫瑰拿鐵 第二杯10 元
2/13 情人節限定｜玫瑰系必喝
懂茶的人，最懂怎麼說愛。
在玫瑰盛開的季節，
用一杯花香，替情人節加點溫柔的儀式感。
玫瑰水｜把浪漫喝進日常
使用 先喝道自製玫瑰露調製，無人工甜味劑、無防腐劑，
清透順口、輕柔不膩，細緻花香在舌尖停留，為日常增添浪漫。
英式玫瑰拿鐵｜專屬午後的溫柔告白
以斯里蘭卡莊園紅茶為基底，搭配米其林ITQI 2 星認證絕佳風味好茶英式玫瑰特調
茶，層層融入奶香與玫瑰香，溫潤柔和，完美午後茶時光必備。
快揪朋友一起喝，讓玫瑰香點亮你的週五！
𝟭.每人限購3 組
活動注意事項
𝟮.限現場/你訂自取 (優惠活動不合併使用)
𝟯.各門市數量有限，售完為止
#先喝道 #把世界放在一杯茶中 #嚴選世界好茶 #TAOTAOTEA #精品茶 #ITQI 得獎茶 #
手搖飲 #手搖推薦 #古典玫瑰園 #下午茶時間', '2026-02-08 00:00:00', 267);
INSERT INTO public.marketing_content VALUES (45, 3, 'FB', '[需人工確認] 圖片限定或無飲品', '更迭沉潛，大地悄悄甦醒
陽光鋪展金光覆滿田野、碧綠金澄
化身不同花色地毯
✦ 
𝘎𝘳𝘦𝘦𝘯 𝘙𝘰𝘰𝘪𝘣𝘰𝘴 𝘛𝘦𝘢 𝘚𝘦𝘳𝘪𝘦𝘴 蕎麥綠寶系列
風味穀香淡雅、溫潤回甘
8/27 清爽上市', '2025-08-25 00:00:00', 66);
INSERT INTO public.marketing_content VALUES (48, 4, 'FB', '[需人工確認] 圖片限定或無飲品', '新的一年，願每一步都奔向更好的風景。
用一杯好茶，陪伴大家迎接嶄新的新年時刻。
限量設計，只為今年的相遇，
不只是喝茶，更是一份祝福、一份陪伴。
願馬年——
馬到成功 
茶香常在 
好運滿杯
#先喝道 #馬年限定杯 #新年喝好茶 #馬到成功 #陪你走過每一個新開始 #把世
界放在一杯茶中 #嚴選世界好茶 #TAOTAOTEA #精品茶 #ITQI 得獎茶 #手搖飲
#手搖推薦 #古典玫瑰園 #下午茶時間', '2026-02-10 00:00:00', 37);
INSERT INTO public.marketing_content VALUES (50, 4, 'FB', '[Text] 英式玫瑰拿鐵', 'HAPPY FRIDAY｜𝟮/𝟭𝟯 情人節必喝  玫瑰限定    玫瑰水、英式玫瑰拿鐵 第二杯10 元
2/13 情人節限定｜玫瑰系必喝
懂茶的人，最懂怎麼說愛。
在玫瑰盛開的季節，
用一杯花香，替情人節加點溫柔的儀式感。
玫瑰水｜把浪漫喝進日常
使用 先喝道自製玫瑰露調製，無人工甜味劑、無防腐劑，
清透順口、輕柔不膩，細緻花香在舌尖停留，為日常增添浪漫。
英式玫瑰拿鐵｜專屬午後的溫柔告白
以斯里蘭卡莊園紅茶為基底，搭配米其林ITQI 2 星認證絕佳風味好茶英式玫瑰特調
茶，層層融入奶香與玫瑰香，溫潤柔和，完美午後茶時光必備。
快揪朋友一起喝，讓玫瑰香點亮你的週五！
𝟭.每人限購3 組
活動注意事項
𝟮.限現場/你訂自取 (優惠活動不合併使用)
𝟯.各門市數量有限，售完為止
#先喝道 #把世界放在一杯茶中 #嚴選世界好茶 #TAOTAOTEA #精品茶 #ITQI 得獎茶 #
手搖飲 #手搖推薦 #古典玫瑰園 #下午茶時間', '2026-02-08 00:00:00', 267);
INSERT INTO public.marketing_content VALUES (51, 4, 'FB', '[Text] 玫瑰水', 'HAPPY FRIDAY｜𝟮/𝟭𝟯 情人節必喝  玫瑰限定    玫瑰水、英式玫瑰拿鐵 第二杯10 元
2/13 情人節限定｜玫瑰系必喝
懂茶的人，最懂怎麼說愛。
在玫瑰盛開的季節，
用一杯花香，替情人節加點溫柔的儀式感。
玫瑰水｜把浪漫喝進日常
使用 先喝道自製玫瑰露調製，無人工甜味劑、無防腐劑，
清透順口、輕柔不膩，細緻花香在舌尖停留，為日常增添浪漫。
英式玫瑰拿鐵｜專屬午後的溫柔告白
以斯里蘭卡莊園紅茶為基底，搭配米其林ITQI 2 星認證絕佳風味好茶英式玫瑰特調
茶，層層融入奶香與玫瑰香，溫潤柔和，完美午後茶時光必備。
快揪朋友一起喝，讓玫瑰香點亮你的週五！
𝟭.每人限購3 組
活動注意事項
𝟮.限現場/你訂自取 (優惠活動不合併使用)
𝟯.各門市數量有限，售完為止
#先喝道 #把世界放在一杯茶中 #嚴選世界好茶 #TAOTAOTEA #精品茶 #ITQI 得獎茶 #
手搖飲 #手搖推薦 #古典玫瑰園 #下午茶時間', '2026-02-08 00:00:00', 267);
INSERT INTO public.marketing_content VALUES (52, 4, 'FB', '[Text] 蜂蜜四季春茶', '有些茶，不需要多說，
一入口，就知道為什麼會被反覆點名。
四季春茶王
米其林級ITQI 最高3 星認證絕佳風味，第一口是清亮的茶湯，接著花香慢慢在口
中散開，尾韻回甘，是一杯會讓人默默一直喝下去的經典。
蜂蜜四季春茶
清新的四季春茶香先到，隨後蜂蜜的溫潤甜感，柔和不膩，口感圓順，每一口都輕
盈愉悅
好茶獻給懂喝的人，全台先喝道，隨時享受。
2/6 限定｜四季春茶王第二杯半價、蜂蜜四季春茶第二杯10 元
𝟭.每人限購3 組
活動注意事項
𝟮.限現場/你訂自取 (優惠活動不合併使用)
𝟯.各門市數量有限，售完為止
#先喝道#把世界放在一杯茶中#嚴選世界好茶#TAOTAOTEA#精品茶#ITQI 得獎茶#
手搖飲#手搖推薦#古典玫瑰園#下午茶時間', '2026-02-04 00:00:00', 36);
INSERT INTO public.marketing_content VALUES (53, 4, 'FB', '[Text] 四季春茶王', '有些茶，不需要多說，
一入口，就知道為什麼會被反覆點名。
四季春茶王
米其林級ITQI 最高3 星認證絕佳風味，第一口是清亮的茶湯，接著花香慢慢在口
中散開，尾韻回甘，是一杯會讓人默默一直喝下去的經典。
蜂蜜四季春茶
清新的四季春茶香先到，隨後蜂蜜的溫潤甜感，柔和不膩，口感圓順，每一口都輕
盈愉悅
好茶獻給懂喝的人，全台先喝道，隨時享受。
2/6 限定｜四季春茶王第二杯半價、蜂蜜四季春茶第二杯10 元
𝟭.每人限購3 組
活動注意事項
𝟮.限現場/你訂自取 (優惠活動不合併使用)
𝟯.各門市數量有限，售完為止
#先喝道#把世界放在一杯茶中#嚴選世界好茶#TAOTAOTEA#精品茶#ITQI 得獎茶#
手搖飲#手搖推薦#古典玫瑰園#下午茶時間', '2026-02-04 00:00:00', 36);
INSERT INTO public.marketing_content VALUES (54, 4, 'FB', '[Text] 蜂蜜四季春茶', 'HAPPY FRIDAY｜四季春系列 (ITQI 3 星得獎茶) 指定飲品優惠
懂喝茶的人都知道，
四季春的魅力，在那一口清爽花香與回甘之間。
先喝道-四季春茶王(ITQI 3 星得獎茶)
選用台灣優質茶葉，茶湯清透、口感輕盈，
自然花香在舌尖綻放，回甘乾淨不厚重，
是一杯每天都喝不膩的經典好茶。
蜂蜜四季春茶
以四季春為基底，加入香甜蜂蜜，
茶香依舊清爽，尾韻多了一抹溫潤甜感，清新柔和、順口耐喝。
2/6 限定｜四季春茶王第二杯半價、蜂蜜四季春茶第二杯10 元
𝟭.每人限購3 組
活動注意事項
𝟮.限現場/你訂自取 (優惠活動不合併使用)
𝟯.各門市數量有限，售完為止
#先喝道 #把世界放在一杯茶中 #嚴選世界好茶 #TAOTAOTEA #精品茶 #ITQI 得
獎茶 #手搖飲 #手搖推薦 #古典玫瑰園 #下午茶時間', '2026-02-01 00:00:00', 620);
INSERT INTO public.marketing_content VALUES (55, 4, 'FB', '[Text] 四季春茶王', 'HAPPY FRIDAY｜四季春系列 (ITQI 3 星得獎茶) 指定飲品優惠
懂喝茶的人都知道，
四季春的魅力，在那一口清爽花香與回甘之間。
先喝道-四季春茶王(ITQI 3 星得獎茶)
選用台灣優質茶葉，茶湯清透、口感輕盈，
自然花香在舌尖綻放，回甘乾淨不厚重，
是一杯每天都喝不膩的經典好茶。
蜂蜜四季春茶
以四季春為基底，加入香甜蜂蜜，
茶香依舊清爽，尾韻多了一抹溫潤甜感，清新柔和、順口耐喝。
2/6 限定｜四季春茶王第二杯半價、蜂蜜四季春茶第二杯10 元
𝟭.每人限購3 組
活動注意事項
𝟮.限現場/你訂自取 (優惠活動不合併使用)
𝟯.各門市數量有限，售完為止
#先喝道 #把世界放在一杯茶中 #嚴選世界好茶 #TAOTAOTEA #精品茶 #ITQI 得
獎茶 #手搖飲 #手搖推薦 #古典玫瑰園 #下午茶時間', '2026-02-01 00:00:00', 620);
INSERT INTO public.marketing_content VALUES (57, 4, 'FB', '[Text] 輕焙榖麥茶', '當世界太吵的時候，
不妨慢下來，
把世界放進一杯茶裡。
輕焙榖麥茶—— 
像是一封焙火寫給大地的情書。穀麥在低溫中慢慢甦醒，香氣不張揚，卻在杯中繾
綣不散；入口是溫柔的穀香與淡淡烘焙甜，讓心也跟著安靜下來。
榮獲
**2024 比利時布魯塞爾 iTQi 美食評鑑「最佳風味好茶」得獎茶款。
#先喝道 #把世界放在一杯茶中 #輕焙榖麥茶 #嚴選世界好茶 #iTQi 得獎茶 #英
式下午茶 #古典玫瑰園', '2026-01-29 00:00:00', 20);
INSERT INTO public.marketing_content VALUES (84, 5, 'FB', '[Text] 荔枝蘋果醋', '#雙十節快樂 十月連假第二彈
又是一個三天連假，千萬別把好時光蹉跎掉了，
來杯清心福全的 #荔枝蘋果醋 慶祝連假萬睡。
更多變種吉娃娃資訊請鎖定 ：
官方網站連結：https://www.chingshin.tw/
Instagram 連結：https://pse.is/M9RBB
YouTube 連結：https://bit.ly/2rtxr5o
#變種吉娃娃 #清心福全 #手搖飲料 #小狗 #聯名活動', '2025-10-09 00:00:00', 433);
INSERT INTO public.marketing_content VALUES (58, 4, 'FB', '[Text] 英式玫瑰拿鐵', '當午後的光線變得柔軟，就讓一杯花香，慢慢展開
玫瑰水
清透順口、輕柔不膩，細緻的玫瑰香氣，
在入口之間輕輕停留，芬芳綻放為日常增添浪漫。
英式玫瑰拿鐵
在溫潤茶香中，玫瑰悄然綻放，
與柔和奶香層層相融，完美的恰到好處。
週五讓這份剛剛好的玫瑰風味伴隨茶香陪你一起迎接浪漫午茶時光
1/30 限定｜玫瑰水第二杯半價、玫瑰拿鐵中杯(Ｍ)49 元第二杯半價
𝟭.每人限購3 組
活動注意事項
𝟮.限現場/你訂自取 (優惠活動不合併使用)
𝟯.各門市數量有限售完為止
#先喝道 #TAOTAOTEA #手搖飲 #好茶 #米其林 #四季春茶王 #台灣四大名茶 #嚴選世
界好茶 #英式下午茶 #英國茶 #台灣茶 #手搖推薦 #古典玫瑰園', '2026-01-28 00:00:00', 34);
INSERT INTO public.marketing_content VALUES (60, 4, 'FB', '[Text] 四季春茶王', '當午後的光線變得柔軟，就讓一杯花香，慢慢展開
玫瑰水
清透順口、輕柔不膩，細緻的玫瑰香氣，
在入口之間輕輕停留，芬芳綻放為日常增添浪漫。
英式玫瑰拿鐵
在溫潤茶香中，玫瑰悄然綻放，
與柔和奶香層層相融，完美的恰到好處。
週五讓這份剛剛好的玫瑰風味伴隨茶香陪你一起迎接浪漫午茶時光
1/30 限定｜玫瑰水第二杯半價、玫瑰拿鐵中杯(Ｍ)49 元第二杯半價
𝟭.每人限購3 組
活動注意事項
𝟮.限現場/你訂自取 (優惠活動不合併使用)
𝟯.各門市數量有限售完為止
#先喝道 #TAOTAOTEA #手搖飲 #好茶 #米其林 #四季春茶王 #台灣四大名茶 #嚴選世
界好茶 #英式下午茶 #英國茶 #台灣茶 #手搖推薦 #古典玫瑰園', '2026-01-28 00:00:00', 34);
INSERT INTO public.marketing_content VALUES (61, 4, 'FB', '[Text] 玫瑰水', '當午後的光線變得柔軟，就讓一杯花香，慢慢展開
玫瑰水
清透順口、輕柔不膩，細緻的玫瑰香氣，
在入口之間輕輕停留，芬芳綻放為日常增添浪漫。
英式玫瑰拿鐵
在溫潤茶香中，玫瑰悄然綻放，
與柔和奶香層層相融，完美的恰到好處。
週五讓這份剛剛好的玫瑰風味伴隨茶香陪你一起迎接浪漫午茶時光
1/30 限定｜玫瑰水第二杯半價、玫瑰拿鐵中杯(Ｍ)49 元第二杯半價
𝟭.每人限購3 組
活動注意事項
𝟮.限現場/你訂自取 (優惠活動不合併使用)
𝟯.各門市數量有限售完為止
#先喝道 #TAOTAOTEA #手搖飲 #好茶 #米其林 #四季春茶王 #台灣四大名茶 #嚴選世
界好茶 #英式下午茶 #英國茶 #台灣茶 #手搖推薦 #古典玫瑰園', '2026-01-28 00:00:00', 34);
INSERT INTO public.marketing_content VALUES (63, 4, 'FB', '[Text] 太妃蜜桃風味厚奶霜', '期間限定！消失的驚喜味道，1/17 日起限定回歸
還記得那口驚艷味蕾、帶有迷人香草氣息的「金杯烏瓦系列」嗎？
在無數粉絲的敲杯後，我們決定讓它期間門店限定復活了！
選用世界三大紅茶之一的斯里蘭卡烏瓦紅茶（Uva Tea）作為基底，來自知名烏瓦高
地。
以優雅的香草清香揭開序幕，隨後濃厚的麥芽香氣沉穩入喉，
尾韻透出甜美的柑橘風味，與細緻奶香交織，
層層堆疊出香醇濃郁、溫潤不膩的經典茶韻。
回歸日期：
1/17 (六) 起 ，全台18 間門市限定販售，數量有限，售完為止
販售門市：
台南新營、嘉義興業、台南民族、梧棲文化、台中嶺東、台中大甲、台南新市、台中
向心、新竹南大、台中潭子、沙鹿中山、龍井中央、林口長庚、北投石牌、桃園青
埔、中科永福、屏東廣東、仁武京吉
1/16 即將登場｜買太妃蜜桃風味厚奶霜送蜜桃風味茶一杯
#先喝道 #TAOTAOTEA #手搖飲 #好茶 #米其林 #金杯烏瓦 #世界三大紅茶 #嚴選世界
好茶 #英式下午茶 #英國茶 #台灣茶 #手搖推薦 #古典玫瑰園', '2026-01-14 00:00:00', 122);
INSERT INTO public.marketing_content VALUES (85, 5, 'FB', '[Text] 蘋果醋', '#雙十節快樂 十月連假第二彈
又是一個三天連假，千萬別把好時光蹉跎掉了，
來杯清心福全的 #荔枝蘋果醋 慶祝連假萬睡。
更多變種吉娃娃資訊請鎖定 ：
官方網站連結：https://www.chingshin.tw/
Instagram 連結：https://pse.is/M9RBB
YouTube 連結：https://bit.ly/2rtxr5o
#變種吉娃娃 #清心福全 #手搖飲料 #小狗 #聯名活動', '2025-10-09 00:00:00', 433);
INSERT INTO public.marketing_content VALUES (66, 4, 'FB', '[Text] 四季春茶王', '山嵐間的花香與回甘，是被米其林記住的味道
什麼樣的茶，能讓國際評審點頭認證？
從台灣優質茶園出發，茶湯清透、花香自然，
入口輕盈不苦澀，尾韻帶著乾淨回甘，越喝越順，
透過職人細緻的製茶工藝，把茶葉最純粹的風味完整留下。
也因為這份對風味的堅持，讓它獲得國際評審一致肯定，
榮獲食品界米其林 iTQi 三星認證。
這不只是一杯日常手搖飲，而是一杯被世界記住的 台灣好茶。
不用特地上山尋找，先喝道全台門市，就能喝到這杯嚴選世界好茶
四季春茶王
#先喝道 #TAOTAOTEA #手搖飲 #好茶 #米其林 #四季春茶王 #台灣四大名茶 #嚴選世
界好茶 #英式下午茶 #英國茶 #台灣茶 #手搖推薦 #古典玫瑰園', '2026-01-13 00:00:00', 23);
INSERT INTO public.marketing_content VALUES (67, 5, 'FB', '[Text] 烏龍綠茶', '【厚雪奶蓋系列 新品上市 #指定門市 試賣中】
口感綿密，像雪一樣輕柔的「厚雪奶蓋」
讓人忍不住一口接一口，快來清心點一杯！
厚雪‧烏龍奶蓋
甘醇的烏龍綠茶，頂層覆蓋「厚雪」奶蓋，入口濃郁卻如初雪般輕盈不膩。
厚雪‧頂級可可奶蓋
頂級可可與「厚雪」奶蓋完美結合。奶蓋的淡雅奶香融入香醇可可，口感飽滿厚
實。
厚雪‧ 紅心芭樂奶蓋
清香的紅心芭樂，頂端鋪滿一層「厚雪」奶蓋，每一口都能喝得到芭樂的香甜與柔
滑綿密的奶蓋。
只在指定門市才能喝到!!
販售門市供應，請參見：https://reurl.cc/2lV2za
清心福全據點搜尋：http://www.chingshin.tw/store.php', '2026-01-06 00:00:00', 421);
INSERT INTO public.marketing_content VALUES (68, 5, 'FB', '[Text] 頂級可可', '【厚雪奶蓋系列 新品上市 #指定門市 試賣中】
口感綿密，像雪一樣輕柔的「厚雪奶蓋」
讓人忍不住一口接一口，快來清心點一杯！
厚雪‧烏龍奶蓋
甘醇的烏龍綠茶，頂層覆蓋「厚雪」奶蓋，入口濃郁卻如初雪般輕盈不膩。
厚雪‧頂級可可奶蓋
頂級可可與「厚雪」奶蓋完美結合。奶蓋的淡雅奶香融入香醇可可，口感飽滿厚
實。
厚雪‧ 紅心芭樂奶蓋
清香的紅心芭樂，頂端鋪滿一層「厚雪」奶蓋，每一口都能喝得到芭樂的香甜與柔
滑綿密的奶蓋。
只在指定門市才能喝到!!
販售門市供應，請參見：https://reurl.cc/2lV2za
清心福全據點搜尋：http://www.chingshin.tw/store.php', '2026-01-06 00:00:00', 421);
INSERT INTO public.marketing_content VALUES (69, 5, 'FB', '[Text] 厚雪奶蓋', '【厚雪奶蓋系列 新品上市 #指定門市 試賣中】
口感綿密，像雪一樣輕柔的「厚雪奶蓋」
讓人忍不住一口接一口，快來清心點一杯！
厚雪‧烏龍奶蓋
甘醇的烏龍綠茶，頂層覆蓋「厚雪」奶蓋，入口濃郁卻如初雪般輕盈不膩。
厚雪‧頂級可可奶蓋
頂級可可與「厚雪」奶蓋完美結合。奶蓋的淡雅奶香融入香醇可可，口感飽滿厚
實。
厚雪‧ 紅心芭樂奶蓋
清香的紅心芭樂，頂端鋪滿一層「厚雪」奶蓋，每一口都能喝得到芭樂的香甜與柔
滑綿密的奶蓋。
只在指定門市才能喝到!!
販售門市供應，請參見：https://reurl.cc/2lV2za
清心福全據點搜尋：http://www.chingshin.tw/store.php', '2026-01-06 00:00:00', 421);
INSERT INTO public.marketing_content VALUES (70, 5, 'FB', '[Text] 錫蘭奶紅', '告別 2025・迎接嶄新的一年
清心福全陪你一起倒數，用熟悉的好味道迎接全新的開始
【跨年必喝】優惠活動
活動時間：12/31(三)～1/6(二)
優惠內容：大杯指定飲品「第二杯折價10 元」
「珍珠奶茶」、「粉圓奶茶」、「椰果奶茶」和「錫蘭奶紅」
活動注意事項：
1.本優惠不得與其他優惠併用。
2.僅適用於大杯指定飲品，且限來店自取。
3.不適用於外送平台、外送及線上點餐。
4.本公司保有解釋、修正與終止活動之權利。
#清心福全 #優惠活動 #新年快樂 #手搖飲料 #2026', '2025-12-29 00:00:00', 2571);
INSERT INTO public.marketing_content VALUES (71, 5, 'FB', '[Text] 椰果奶茶', '告別 2025・迎接嶄新的一年
清心福全陪你一起倒數，用熟悉的好味道迎接全新的開始
【跨年必喝】優惠活動
活動時間：12/31(三)～1/6(二)
優惠內容：大杯指定飲品「第二杯折價10 元」
「珍珠奶茶」、「粉圓奶茶」、「椰果奶茶」和「錫蘭奶紅」
活動注意事項：
1.本優惠不得與其他優惠併用。
2.僅適用於大杯指定飲品，且限來店自取。
3.不適用於外送平台、外送及線上點餐。
4.本公司保有解釋、修正與終止活動之權利。
#清心福全 #優惠活動 #新年快樂 #手搖飲料 #2026', '2025-12-29 00:00:00', 2571);
INSERT INTO public.marketing_content VALUES (72, 5, 'FB', '[Text] 珍珠奶茶', '告別 2025・迎接嶄新的一年
清心福全陪你一起倒數，用熟悉的好味道迎接全新的開始
【跨年必喝】優惠活動
活動時間：12/31(三)～1/6(二)
優惠內容：大杯指定飲品「第二杯折價10 元」
「珍珠奶茶」、「粉圓奶茶」、「椰果奶茶」和「錫蘭奶紅」
活動注意事項：
1.本優惠不得與其他優惠併用。
2.僅適用於大杯指定飲品，且限來店自取。
3.不適用於外送平台、外送及線上點餐。
4.本公司保有解釋、修正與終止活動之權利。
#清心福全 #優惠活動 #新年快樂 #手搖飲料 #2026', '2025-12-29 00:00:00', 2571);
INSERT INTO public.marketing_content VALUES (73, 5, 'FB', '[Text] 奶茶', '告別 2025・迎接嶄新的一年
清心福全陪你一起倒數，用熟悉的好味道迎接全新的開始
【跨年必喝】優惠活動
活動時間：12/31(三)～1/6(二)
優惠內容：大杯指定飲品「第二杯折價10 元」
「珍珠奶茶」、「粉圓奶茶」、「椰果奶茶」和「錫蘭奶紅」
活動注意事項：
1.本優惠不得與其他優惠併用。
2.僅適用於大杯指定飲品，且限來店自取。
3.不適用於外送平台、外送及線上點餐。
4.本公司保有解釋、修正與終止活動之權利。
#清心福全 #優惠活動 #新年快樂 #手搖飲料 #2026', '2025-12-29 00:00:00', 2571);
INSERT INTO public.marketing_content VALUES (74, 5, 'FB', '[Text] 白韻杏仁頂級可可', '冷氣團來襲，低溫拉警報，不想離開被窩就來杯能把冬天融化的「杏福滋味」吧！
冬季新品【白韻杏仁系列】純淨的白更韻涵典雅韻味，將純淨的幸福感留在唇齒間，
韻味無窮。
#白韻杏仁頂級可可 $80：創新口味，將東方傳統風味的「杏仁粉」溶入頂級可可，雙
重甜蜜滋味豪華升級。
#白韻杏仁奶 $65：以南杏研磨的「特級杏仁粉」，搭配醇正香濃的「嚴選奶精」，每一
口都是幸福細密的滑順口感。
#白韻杏仁鮮奶 $85：以南杏研磨的「特級杏仁粉」，搭配鮮潤的「崙背鮮乳」，杏仁香
與乳香完美結合，成就濃郁渾厚的極致口感。
找回杏福，暖暖過冬，一起拒絕“冷暴力”
更多資訊請鎖定 ：
官方網站連結：https://www.chingshin.tw/
Instagram 連結：https://pse.is/M9RBB
YouTube 連結：https://bit.ly/2rtxr5o
#清心福全 #手搖飲料 #新品登場 #冬季飲品 #暖暖過冬', '2025-12-15 00:00:00', 4353);
INSERT INTO public.marketing_content VALUES (75, 5, 'FB', '[Text] 白韻杏仁鮮奶', '冷氣團來襲，低溫拉警報，不想離開被窩就來杯能把冬天融化的「杏福滋味」吧！
冬季新品【白韻杏仁系列】純淨的白更韻涵典雅韻味，將純淨的幸福感留在唇齒間，
韻味無窮。
#白韻杏仁頂級可可 $80：創新口味，將東方傳統風味的「杏仁粉」溶入頂級可可，雙
重甜蜜滋味豪華升級。
#白韻杏仁奶 $65：以南杏研磨的「特級杏仁粉」，搭配醇正香濃的「嚴選奶精」，每一
口都是幸福細密的滑順口感。
#白韻杏仁鮮奶 $85：以南杏研磨的「特級杏仁粉」，搭配鮮潤的「崙背鮮乳」，杏仁香
與乳香完美結合，成就濃郁渾厚的極致口感。
找回杏福，暖暖過冬，一起拒絕“冷暴力”
更多資訊請鎖定 ：
官方網站連結：https://www.chingshin.tw/
Instagram 連結：https://pse.is/M9RBB
YouTube 連結：https://bit.ly/2rtxr5o
#清心福全 #手搖飲料 #新品登場 #冬季飲品 #暖暖過冬', '2025-12-15 00:00:00', 4353);
INSERT INTO public.marketing_content VALUES (76, 5, 'FB', '[Text] 白韻杏仁奶', '冷氣團來襲，低溫拉警報，不想離開被窩就來杯能把冬天融化的「杏福滋味」吧！
冬季新品【白韻杏仁系列】純淨的白更韻涵典雅韻味，將純淨的幸福感留在唇齒間，
韻味無窮。
#白韻杏仁頂級可可 $80：創新口味，將東方傳統風味的「杏仁粉」溶入頂級可可，雙
重甜蜜滋味豪華升級。
#白韻杏仁奶 $65：以南杏研磨的「特級杏仁粉」，搭配醇正香濃的「嚴選奶精」，每一
口都是幸福細密的滑順口感。
#白韻杏仁鮮奶 $85：以南杏研磨的「特級杏仁粉」，搭配鮮潤的「崙背鮮乳」，杏仁香
與乳香完美結合，成就濃郁渾厚的極致口感。
找回杏福，暖暖過冬，一起拒絕“冷暴力”
更多資訊請鎖定 ：
官方網站連結：https://www.chingshin.tw/
Instagram 連結：https://pse.is/M9RBB
YouTube 連結：https://bit.ly/2rtxr5o
#清心福全 #手搖飲料 #新品登場 #冬季飲品 #暖暖過冬', '2025-12-15 00:00:00', 4353);
INSERT INTO public.marketing_content VALUES (77, 5, 'FB', '[Text] 頂級可可', '冷氣團來襲，低溫拉警報，不想離開被窩就來杯能把冬天融化的「杏福滋味」吧！
冬季新品【白韻杏仁系列】純淨的白更韻涵典雅韻味，將純淨的幸福感留在唇齒間，
韻味無窮。
#白韻杏仁頂級可可 $80：創新口味，將東方傳統風味的「杏仁粉」溶入頂級可可，雙
重甜蜜滋味豪華升級。
#白韻杏仁奶 $65：以南杏研磨的「特級杏仁粉」，搭配醇正香濃的「嚴選奶精」，每一
口都是幸福細密的滑順口感。
#白韻杏仁鮮奶 $85：以南杏研磨的「特級杏仁粉」，搭配鮮潤的「崙背鮮乳」，杏仁香
與乳香完美結合，成就濃郁渾厚的極致口感。
找回杏福，暖暖過冬，一起拒絕“冷暴力”
更多資訊請鎖定 ：
官方網站連結：https://www.chingshin.tw/
Instagram 連結：https://pse.is/M9RBB
YouTube 連結：https://bit.ly/2rtxr5o
#清心福全 #手搖飲料 #新品登場 #冬季飲品 #暖暖過冬', '2025-12-15 00:00:00', 4353);
INSERT INTO public.marketing_content VALUES (78, 5, 'FB', '[Text] 白韻杏仁頂級可可', '別讓冷空氣覆蓋了你的好精神，冬季新品上市，品嘗杏福滋味～
冬季新品【白韻杏仁系列】純淨的白更韻涵典雅韻味，將純淨的幸福感留在唇齒
間，韻味無窮。
#白韻杏仁奶 $65：以南杏研磨的「特級杏仁粉」，搭配醇正香濃的「嚴選奶
精」，每一口都是幸福細密的滑順口感。
#白韻杏仁頂級可可 $80：創新口味，將東方傳統風味的「杏仁粉」溶入頂級可
可，雙重甜蜜滋味豪華升級。
同步推薦【經典冬季不敗飲品】 #珍珠琥珀黑糖鮮奶 #芝麻奶茶 #桂圓鮮奶茶
找回杏福，暖暖過冬，一起拒絕“冷暴力”
更多資訊請鎖定 ：
官方網站連結：https://www.chingshin.tw/
Instagram 連結：https://pse.is/M9RBB
YouTube 連結：https://bit.ly/2rtxr5o
#清心福全 #手搖飲料 #新品登場 #冬季飲品 #暖暖過冬', '2025-11-18 00:00:00', 3830);
INSERT INTO public.marketing_content VALUES (79, 5, 'FB', '[Text] 珍珠琥珀黑糖鮮奶', '別讓冷空氣覆蓋了你的好精神，冬季新品上市，品嘗杏福滋味～
冬季新品【白韻杏仁系列】純淨的白更韻涵典雅韻味，將純淨的幸福感留在唇齒
間，韻味無窮。
#白韻杏仁奶 $65：以南杏研磨的「特級杏仁粉」，搭配醇正香濃的「嚴選奶
精」，每一口都是幸福細密的滑順口感。
#白韻杏仁頂級可可 $80：創新口味，將東方傳統風味的「杏仁粉」溶入頂級可
可，雙重甜蜜滋味豪華升級。
同步推薦【經典冬季不敗飲品】 #珍珠琥珀黑糖鮮奶 #芝麻奶茶 #桂圓鮮奶茶
找回杏福，暖暖過冬，一起拒絕“冷暴力”
更多資訊請鎖定 ：
官方網站連結：https://www.chingshin.tw/
Instagram 連結：https://pse.is/M9RBB
YouTube 連結：https://bit.ly/2rtxr5o
#清心福全 #手搖飲料 #新品登場 #冬季飲品 #暖暖過冬', '2025-11-18 00:00:00', 3830);
INSERT INTO public.marketing_content VALUES (80, 5, 'FB', '[Text] 白韻杏仁奶', '別讓冷空氣覆蓋了你的好精神，冬季新品上市，品嘗杏福滋味～
冬季新品【白韻杏仁系列】純淨的白更韻涵典雅韻味，將純淨的幸福感留在唇齒
間，韻味無窮。
#白韻杏仁奶 $65：以南杏研磨的「特級杏仁粉」，搭配醇正香濃的「嚴選奶
精」，每一口都是幸福細密的滑順口感。
#白韻杏仁頂級可可 $80：創新口味，將東方傳統風味的「杏仁粉」溶入頂級可
可，雙重甜蜜滋味豪華升級。
同步推薦【經典冬季不敗飲品】 #珍珠琥珀黑糖鮮奶 #芝麻奶茶 #桂圓鮮奶茶
找回杏福，暖暖過冬，一起拒絕“冷暴力”
更多資訊請鎖定 ：
官方網站連結：https://www.chingshin.tw/
Instagram 連結：https://pse.is/M9RBB
YouTube 連結：https://bit.ly/2rtxr5o
#清心福全 #手搖飲料 #新品登場 #冬季飲品 #暖暖過冬', '2025-11-18 00:00:00', 3830);
INSERT INTO public.marketing_content VALUES (81, 5, 'FB', '[Text] 桂圓鮮奶茶', '別讓冷空氣覆蓋了你的好精神，冬季新品上市，品嘗杏福滋味～
冬季新品【白韻杏仁系列】純淨的白更韻涵典雅韻味，將純淨的幸福感留在唇齒
間，韻味無窮。
#白韻杏仁奶 $65：以南杏研磨的「特級杏仁粉」，搭配醇正香濃的「嚴選奶
精」，每一口都是幸福細密的滑順口感。
#白韻杏仁頂級可可 $80：創新口味，將東方傳統風味的「杏仁粉」溶入頂級可
可，雙重甜蜜滋味豪華升級。
同步推薦【經典冬季不敗飲品】 #珍珠琥珀黑糖鮮奶 #芝麻奶茶 #桂圓鮮奶茶
找回杏福，暖暖過冬，一起拒絕“冷暴力”
更多資訊請鎖定 ：
官方網站連結：https://www.chingshin.tw/
Instagram 連結：https://pse.is/M9RBB
YouTube 連結：https://bit.ly/2rtxr5o
#清心福全 #手搖飲料 #新品登場 #冬季飲品 #暖暖過冬', '2025-11-18 00:00:00', 3830);
INSERT INTO public.marketing_content VALUES (82, 5, 'FB', '[Text] 芝麻奶茶', '別讓冷空氣覆蓋了你的好精神，冬季新品上市，品嘗杏福滋味～
冬季新品【白韻杏仁系列】純淨的白更韻涵典雅韻味，將純淨的幸福感留在唇齒
間，韻味無窮。
#白韻杏仁奶 $65：以南杏研磨的「特級杏仁粉」，搭配醇正香濃的「嚴選奶
精」，每一口都是幸福細密的滑順口感。
#白韻杏仁頂級可可 $80：創新口味，將東方傳統風味的「杏仁粉」溶入頂級可
可，雙重甜蜜滋味豪華升級。
同步推薦【經典冬季不敗飲品】 #珍珠琥珀黑糖鮮奶 #芝麻奶茶 #桂圓鮮奶茶
找回杏福，暖暖過冬，一起拒絕“冷暴力”
更多資訊請鎖定 ：
官方網站連結：https://www.chingshin.tw/
Instagram 連結：https://pse.is/M9RBB
YouTube 連結：https://bit.ly/2rtxr5o
#清心福全 #手搖飲料 #新品登場 #冬季飲品 #暖暖過冬', '2025-11-18 00:00:00', 3830);
INSERT INTO public.marketing_content VALUES (86, 5, 'FB', '[Text] 珍珠琥珀黑糖鮮奶', '謝謝老師的用心教誨，在特別的日子裡加碼作業，
來杯
大人的滋味 #咖啡凍奶茶，苦甜苦甜才是人生。 
更多變種吉娃娃資訊請鎖定 ： 
官方網站連結：https://www.chingshin.tw/ 
Instagram 連結：https://pse.is/M9RBB 
YouTube 連結：https://bit.ly/2rtxr5o
#變種吉娃娃 #清心福全 #手搖飲料 #小狗 #聯名活動
來杯甜甜的，讀書就不會那麼辛苦了 ₊˚⊹♡ 
#珍珠琥珀黑糖鮮奶 黑糖香氣滿滿～Q 彈珍珠咬一口就超幸福', '2025-09-26 00:00:00', 216);
INSERT INTO public.marketing_content VALUES (87, 5, 'FB', '[Text] 咖啡凍奶茶', '謝謝老師的用心教誨，在特別的日子裡加碼作業，
來杯
大人的滋味 #咖啡凍奶茶，苦甜苦甜才是人生。 
更多變種吉娃娃資訊請鎖定 ： 
官方網站連結：https://www.chingshin.tw/ 
Instagram 連結：https://pse.is/M9RBB 
YouTube 連結：https://bit.ly/2rtxr5o
#變種吉娃娃 #清心福全 #手搖飲料 #小狗 #聯名活動
來杯甜甜的，讀書就不會那麼辛苦了 ₊˚⊹♡ 
#珍珠琥珀黑糖鮮奶 黑糖香氣滿滿～Q 彈珍珠咬一口就超幸福', '2025-09-26 00:00:00', 216);
INSERT INTO public.marketing_content VALUES (88, 5, 'FB', '[Text] 奶茶', '謝謝老師的用心教誨，在特別的日子裡加碼作業，
來杯
大人的滋味 #咖啡凍奶茶，苦甜苦甜才是人生。 
更多變種吉娃娃資訊請鎖定 ： 
官方網站連結：https://www.chingshin.tw/ 
Instagram 連結：https://pse.is/M9RBB 
YouTube 連結：https://bit.ly/2rtxr5o
#變種吉娃娃 #清心福全 #手搖飲料 #小狗 #聯名活動
來杯甜甜的，讀書就不會那麼辛苦了 ₊˚⊹♡ 
#珍珠琥珀黑糖鮮奶 黑糖香氣滿滿～Q 彈珍珠咬一口就超幸福', '2025-09-26 00:00:00', 216);
INSERT INTO public.marketing_content VALUES (89, 5, 'FB', '[Text] 珍珠蜂蜜鮮奶普洱', '#隱藏版 (珍珠蜂蜜鮮奶普洱) 甜而不膩～給你滿滿好心情
讓清心飲料＆變種吉娃娃陪你收穫好成績！！
#變種吉娃娃 #清心福全 #聯名活動 #手搖飲料 #小狗勾療癒陪伴', '2025-09-23 00:00:00', 279);
INSERT INTO public.marketing_content VALUES (90, 5, 'FB', '[Text] 蜜桃凍紅茶', '這個夏天超吉喜歡喝涼涼的飲料～～
香甜清爽的 #柳橙綠、 甜Q 爽口的 #蜜桃凍紅茶、 酸甜活力的 #紅心芭樂優
持續關注⇩⇩⇩
多，快來清心一口喝下你的新學期元氣，讓開學大吉大利！
官方網站連結：https://www.chingshin.tw/
Instagram 連結：https://pse.is/M9RBB
YouTube 連結：https://bit.ly/2rtxr5o
#變種吉娃娃 #清心福全 #聯名活動 #手搖飲料 #可愛的小狗勾', '2025-08-19 00:00:00', 408);
INSERT INTO public.marketing_content VALUES (91, 5, 'FB', '[Text] 柳橙綠', '這個夏天超吉喜歡喝涼涼的飲料～～
香甜清爽的 #柳橙綠、 甜Q 爽口的 #蜜桃凍紅茶、 酸甜活力的 #紅心芭樂優
持續關注⇩⇩⇩
多，快來清心一口喝下你的新學期元氣，讓開學大吉大利！
官方網站連結：https://www.chingshin.tw/
Instagram 連結：https://pse.is/M9RBB
YouTube 連結：https://bit.ly/2rtxr5o
#變種吉娃娃 #清心福全 #聯名活動 #手搖飲料 #可愛的小狗勾', '2025-08-19 00:00:00', 408);
INSERT INTO public.marketing_content VALUES (92, 5, 'FB', '[Text] 粉戀莓莓', '520 「莓」你不行的戀愛滋味
#粉戀莓莓 像是她微笑時的甜
#情人茶 像戀愛一樣清爽又讓人心動
清心福全×三麗鷗男團 給你表白的勇氣
今天不來一杯怎麼行？讓我們在清心一起心動！
小編今天只幫你助攻到這～剩下的，就靠你自己加油啦
更多資訊 ：
官方網站連結：https://www.chingshin.tw/
Instagram: https://reurl.cc/67Rn3Z 
YouTube 連結：https://bit.ly/2rtxr5o
#清心福全 #手搖飲料 #三麗鷗男團 #飲料推薦 #520 莓你不行', '2025-05-20 00:00:00', 374);
INSERT INTO public.marketing_content VALUES (93, 5, 'FB', '[Text] 情人茶', '520 「莓」你不行的戀愛滋味
#粉戀莓莓 像是她微笑時的甜
#情人茶 像戀愛一樣清爽又讓人心動
清心福全×三麗鷗男團 給你表白的勇氣
今天不來一杯怎麼行？讓我們在清心一起心動！
小編今天只幫你助攻到這～剩下的，就靠你自己加油啦
更多資訊 ：
官方網站連結：https://www.chingshin.tw/
Instagram: https://reurl.cc/67Rn3Z 
YouTube 連結：https://bit.ly/2rtxr5o
#清心福全 #手搖飲料 #三麗鷗男團 #飲料推薦 #520 莓你不行', '2025-05-20 00:00:00', 374);
INSERT INTO public.marketing_content VALUES (94, 6, 'FB', '[Text] 香芋仙草綠茶拿鐵', '涼涼的天適合暖暖的那一杯
法芙娜可可鮮奶｜𝟭𝟬𝟬%法芙娜可可粉，入口滑順
冬天，就該給自己一杯迷客夏的暖心系熱飲
珍珠紅茶拿鐵｜𝗤 彈香甜，冬天熱熱喝更對味
靜岡焙焙鮮奶｜焙香濃郁，暖到心坎裡~
香芋仙草綠茶拿鐵｜芋頭 x 仙草凍 x 綠茶，暖甜飽足感滿滿
現在買𝟮杯還能抽𝗶𝗣𝗵𝗼𝗻𝗲 𝟭𝟳等豪禮
暖暖喝，好運暖暖暖~起來
現場門市限定：熱門指定單茶&茶拿鐵組合價只要$𝟳𝟵(南)／$𝟴𝟵(北)
迷點自取限定：滿𝟮杯即贈「愛茶的牛」指定飲品電子兌換券乙張
現在下單給自己一個暖心飲品 https://reurl.cc/R9GaXZ
活動詳見官網  https://reurl.cc/gnyg7X
#迷客夏 #milksha #為了你嚴選每一杯
#雀蘋中選週週抽 #iPhone 抽獎
#雙週門市驚喜第二彈 #迷點自取買二送一', '2026-01-23 00:00:00', 82);
INSERT INTO public.marketing_content VALUES (95, 6, 'FB', '[Text] 法芙娜可可鮮奶', '涼涼的天適合暖暖的那一杯
法芙娜可可鮮奶｜𝟭𝟬𝟬%法芙娜可可粉，入口滑順
冬天，就該給自己一杯迷客夏的暖心系熱飲
珍珠紅茶拿鐵｜𝗤 彈香甜，冬天熱熱喝更對味
靜岡焙焙鮮奶｜焙香濃郁，暖到心坎裡~
香芋仙草綠茶拿鐵｜芋頭 x 仙草凍 x 綠茶，暖甜飽足感滿滿
現在買𝟮杯還能抽𝗶𝗣𝗵𝗼𝗻𝗲 𝟭𝟳等豪禮
暖暖喝，好運暖暖暖~起來
現場門市限定：熱門指定單茶&茶拿鐵組合價只要$𝟳𝟵(南)／$𝟴𝟵(北)
迷點自取限定：滿𝟮杯即贈「愛茶的牛」指定飲品電子兌換券乙張
現在下單給自己一個暖心飲品 https://reurl.cc/R9GaXZ
活動詳見官網  https://reurl.cc/gnyg7X
#迷客夏 #milksha #為了你嚴選每一杯
#雀蘋中選週週抽 #iPhone 抽獎
#雙週門市驚喜第二彈 #迷點自取買二送一', '2026-01-23 00:00:00', 82);
INSERT INTO public.marketing_content VALUES (96, 6, 'FB', '[Text] 靜岡焙焙鮮奶', '涼涼的天適合暖暖的那一杯
法芙娜可可鮮奶｜𝟭𝟬𝟬%法芙娜可可粉，入口滑順
冬天，就該給自己一杯迷客夏的暖心系熱飲
珍珠紅茶拿鐵｜𝗤 彈香甜，冬天熱熱喝更對味
靜岡焙焙鮮奶｜焙香濃郁，暖到心坎裡~
香芋仙草綠茶拿鐵｜芋頭 x 仙草凍 x 綠茶，暖甜飽足感滿滿
現在買𝟮杯還能抽𝗶𝗣𝗵𝗼𝗻𝗲 𝟭𝟳等豪禮
暖暖喝，好運暖暖暖~起來
現場門市限定：熱門指定單茶&茶拿鐵組合價只要$𝟳𝟵(南)／$𝟴𝟵(北)
迷點自取限定：滿𝟮杯即贈「愛茶的牛」指定飲品電子兌換券乙張
現在下單給自己一個暖心飲品 https://reurl.cc/R9GaXZ
活動詳見官網  https://reurl.cc/gnyg7X
#迷客夏 #milksha #為了你嚴選每一杯
#雀蘋中選週週抽 #iPhone 抽獎
#雙週門市驚喜第二彈 #迷點自取買二送一', '2026-01-23 00:00:00', 82);
INSERT INTO public.marketing_content VALUES (127, 7, 'FB', '[Text] 雙Q', '跨年夜一定要來點「咀嚼系幸福」(〃∀〃)
今年最後一杯＆新年第一杯——
#COMEBUY #沖繩黑糖奶茶
雙𝗤𝟭號（珍珠＋粉條）
—— 甜度僅靠黑糖
半糖以上最有味 ♡
𝗤彈、軟糯、焦香、濃奶一次登場
比煙火還療癒的口感衝擊就在這刻炸開
跨年的願望不一定要很偉大：
喝到好喝的
心情甜一點
明年更順一點
迎向 𝟮𝟬𝟮𝟲，讓暖甜先替你開個好頭吧～
這杯就能全包辦 (๑˃ᴗ˂) و♡
#跨年 #新年必喝 #雙Q 咀嚼控集合
#黑糖不另外加糖 #半糖以上最有味
𝗠𝗲𝗿𝗿𝘆 𝗖𝗵𝗿𝗶𝘀𝘁𝗺𝗮𝘀 
 
聖誕快樂呀大家 (ﾉ>▽<)ﾉ', '2025-12-31 00:00:00', 35);
INSERT INTO public.marketing_content VALUES (97, 6, 'FB', '[Text] 茉莉原淬綠茶', '𝟭月份雙週限定驚喜 𝗽𝗮𝗿𝘁 𝟮
你的迷客夏新春大禮包第二彈來襲
𝟭/𝟮𝟭 (三)~𝟮/𝟯(二)
<門市現場購買> 𝗔＋𝗕限定好康
𝗔 區 醇濃鮮奶茶(𝗟) ＋ 𝗕 區 愛茶的牛
組合價 $𝟳𝟵(南)／$𝟴𝟵(北)
一次喝到 濃郁奶香 × 清爽茶韻
鮮奶控＆茶控都滿足的雙杯組合
醇濃鮮奶茶/愛茶的牛適用茶底：
大正醇香紅茶/英倫伯爵紅茶/茉莉原淬綠茶/原片初露青茶/琥珀高峰烏龍
新年好康連連~雙倍幸福一次喝
查詢鄰近門市享好康 https://reurl.cc/7Kr7bQ
活動詳情請見官網 https://reurl.cc/EbaKAn
#迷客夏 #milksha #為了你嚴選每一杯 #雙週門市驚喜第二彈', '2026-01-20 00:00:00', 166);
INSERT INTO public.marketing_content VALUES (98, 6, 'FB', '[Text] 茉香綠茶拿鐵', '𝟭月份雙週限定驚喜
第一彈
你的迷客夏新春大禮包已送達
即日起~𝟭/𝟮𝟬(二)
<門市現場購買>任𝟮杯全系列飲品
即可享
加購$𝟯𝟵茶拿鐵(𝗠)𝟭杯
𝟯𝟵元就能享受迷人的奶香茶韻
活動加購茶拿鐵適用品項：
大正紅茶拿鐵/伯爵紅茶拿鐵/茉香綠茶拿鐵/原片青茶拿鐵/琥珀烏龍拿鐵
新年好康連連，別錯過這一杯
立即前往鄰近門市享優惠 https://reurl.cc/7Kr7bQ
活動詳情請見官網 https://reurl.cc/EbaKAn
#迷客夏 #milksha #為了你嚴選每一杯 #雙週門市驚喜第一彈
迎接 𝟮𝟬𝟮𝟲 倒數計時！誰陪你跨年?!
 
在煙火綻放的那一刻，', '2026-01-09 00:00:00', 78);
INSERT INTO public.marketing_content VALUES (99, 6, 'FB', '[OCR] 淌央單茶', '手裡拿的是哪一杯最愛的迷客夏？  
快在下方用「表情符號」投出你的最愛 
看看哪一派粉絲軍團最強大！
醇濃茶拿鐵派：迷客夏人氣必喝，最對味！ 
清爽單茶派：解膩神助攻，清爽回甘
特調果香派：果香明亮，層次迷人 
香醇鮮奶派：濃郁順口，暖心首選 
現在就預約你的跨年小夥伴！
https://miniapp.line.me/1657225662-ARnXEvKb 
#迷客夏 #milksha #為了你嚴選每一杯 #2025 年度TOP10 #年度推薦 
#2026 新年快樂
回顧𝟮𝟬𝟮𝟱年，大家最愛的迷客夏飲料有哪些?!(下集)', '2025-12-31 00:00:00', 96);
INSERT INTO public.marketing_content VALUES (100, 6, 'FB', '[Text] 珍珠大正紅茶拿鐵', '快看你的迷客夏必喝有沒有上榜！
𝗧𝗢𝗣𝟭 #珍珠大正紅茶拿鐵
拿起你最愛的那杯，一起看年度旁行榜
 https://milksha.nidin.shop/
融合錫蘭 × 阿薩姆紅茶的多層次茶香
𝗤 彈香甜、冬天必喝
加上醇濃綠光鮮奶與蜜漬白玉珍珠
𝗧𝗢𝗣𝟮 #輕纖蕎麥茶
無咖啡因首選
蕎麥穀香濃而不澀，溫潤順口、自然回甘
獨家製程，讓香氣更純粹
𝗧𝗢𝗣𝟯 #伯爵紅茶拿鐵
給想減少咖啡因的小迷人
釋放獨特佛手柑優雅果香
完美調和綠光鮮奶
𝗧𝗢𝗣𝟰 #原片初露青茶
口感醇厚柔順無人不愛
單茶控的清爽心頭好
選用台灣原片青茶
𝗧𝗢𝗣𝟱 #芋頭鮮奶
滋味淡雅清香、圓潤清甜
持續擔綱迷客夏「鎮店之寶」寶座
選用高雄一號芋頭精心製作
保留精華中段，手工壓製成綿密芋泥
搭配綠光鮮奶，每口都有濃濃芋頭香氣和顆粒
#迷客夏 #milksha #為了你嚴選每一杯 #2025 年度TOP10 #年度推薦
回顧𝟮𝟬𝟮𝟱年，大家最愛的迷客夏飲料有哪些?!(上集)', '2025-12-21 00:00:00', 64);
INSERT INTO public.marketing_content VALUES (101, 6, 'FB', '[Text] 伯爵紅茶拿鐵', '快看你的迷客夏必喝有沒有上榜！
𝗧𝗢𝗣𝟭 #珍珠大正紅茶拿鐵
拿起你最愛的那杯，一起看年度旁行榜
 https://milksha.nidin.shop/
融合錫蘭 × 阿薩姆紅茶的多層次茶香
𝗤 彈香甜、冬天必喝
加上醇濃綠光鮮奶與蜜漬白玉珍珠
𝗧𝗢𝗣𝟮 #輕纖蕎麥茶
無咖啡因首選
蕎麥穀香濃而不澀，溫潤順口、自然回甘
獨家製程，讓香氣更純粹
𝗧𝗢𝗣𝟯 #伯爵紅茶拿鐵
給想減少咖啡因的小迷人
釋放獨特佛手柑優雅果香
完美調和綠光鮮奶
𝗧𝗢𝗣𝟰 #原片初露青茶
口感醇厚柔順無人不愛
單茶控的清爽心頭好
選用台灣原片青茶
𝗧𝗢𝗣𝟱 #芋頭鮮奶
滋味淡雅清香、圓潤清甜
持續擔綱迷客夏「鎮店之寶」寶座
選用高雄一號芋頭精心製作
保留精華中段，手工壓製成綿密芋泥
搭配綠光鮮奶，每口都有濃濃芋頭香氣和顆粒
#迷客夏 #milksha #為了你嚴選每一杯 #2025 年度TOP10 #年度推薦
回顧𝟮𝟬𝟮𝟱年，大家最愛的迷客夏飲料有哪些?!(上集)', '2025-12-21 00:00:00', 64);
INSERT INTO public.marketing_content VALUES (102, 6, 'FB', '[Text] 原片初露青茶', '快看你的迷客夏必喝有沒有上榜！
𝗧𝗢𝗣𝟭 #珍珠大正紅茶拿鐵
拿起你最愛的那杯，一起看年度旁行榜
 https://milksha.nidin.shop/
融合錫蘭 × 阿薩姆紅茶的多層次茶香
𝗤 彈香甜、冬天必喝
加上醇濃綠光鮮奶與蜜漬白玉珍珠
𝗧𝗢𝗣𝟮 #輕纖蕎麥茶
無咖啡因首選
蕎麥穀香濃而不澀，溫潤順口、自然回甘
獨家製程，讓香氣更純粹
𝗧𝗢𝗣𝟯 #伯爵紅茶拿鐵
給想減少咖啡因的小迷人
釋放獨特佛手柑優雅果香
完美調和綠光鮮奶
𝗧𝗢𝗣𝟰 #原片初露青茶
口感醇厚柔順無人不愛
單茶控的清爽心頭好
選用台灣原片青茶
𝗧𝗢𝗣𝟱 #芋頭鮮奶
滋味淡雅清香、圓潤清甜
持續擔綱迷客夏「鎮店之寶」寶座
選用高雄一號芋頭精心製作
保留精華中段，手工壓製成綿密芋泥
搭配綠光鮮奶，每口都有濃濃芋頭香氣和顆粒
#迷客夏 #milksha #為了你嚴選每一杯 #2025 年度TOP10 #年度推薦
回顧𝟮𝟬𝟮𝟱年，大家最愛的迷客夏飲料有哪些?!(上集)', '2025-12-21 00:00:00', 64);
INSERT INTO public.marketing_content VALUES (103, 6, 'FB', '[Text] 輕纖蕎麥茶', '快看你的迷客夏必喝有沒有上榜！
𝗧𝗢𝗣𝟭 #珍珠大正紅茶拿鐵
拿起你最愛的那杯，一起看年度旁行榜
 https://milksha.nidin.shop/
融合錫蘭 × 阿薩姆紅茶的多層次茶香
𝗤 彈香甜、冬天必喝
加上醇濃綠光鮮奶與蜜漬白玉珍珠
𝗧𝗢𝗣𝟮 #輕纖蕎麥茶
無咖啡因首選
蕎麥穀香濃而不澀，溫潤順口、自然回甘
獨家製程，讓香氣更純粹
𝗧𝗢𝗣𝟯 #伯爵紅茶拿鐵
給想減少咖啡因的小迷人
釋放獨特佛手柑優雅果香
完美調和綠光鮮奶
𝗧𝗢𝗣𝟰 #原片初露青茶
口感醇厚柔順無人不愛
單茶控的清爽心頭好
選用台灣原片青茶
𝗧𝗢𝗣𝟱 #芋頭鮮奶
滋味淡雅清香、圓潤清甜
持續擔綱迷客夏「鎮店之寶」寶座
選用高雄一號芋頭精心製作
保留精華中段，手工壓製成綿密芋泥
搭配綠光鮮奶，每口都有濃濃芋頭香氣和顆粒
#迷客夏 #milksha #為了你嚴選每一杯 #2025 年度TOP10 #年度推薦
回顧𝟮𝟬𝟮𝟱年，大家最愛的迷客夏飲料有哪些?!(上集)', '2025-12-21 00:00:00', 64);
INSERT INTO public.marketing_content VALUES (117, 6, 'FB', '[Text] 法芙娜可可鮮奶', '大家敲破碗的 #冬季限定 人氣飲品回歸啦！
靜岡焙焙鮮奶、靜岡焙焙烏龍拿鐵 濃郁登場
嚴選靜岡製茶名家精工研磨，細緻茶粉完整釋放焙香茶韻
#靜岡焙焙鮮奶 迷編最推薦
靜岡焙茶烤焙香氣 × 綠光鮮奶的醇厚滑順
一口享受高品質的飲茶體驗
榮獲𝗜𝗧𝗜風味絕佳二星獎章的 #琥珀高峰烏龍茶 x #綠光鮮奶
#靜岡焙焙烏龍拿鐵
炭焙茶香交織濃郁奶香，清爽甘醇不膩口
同場加映
法國 𝗩𝗮𝗹𝗿𝗵𝗼𝗻𝗮 頂級純可可 × 綠光鮮奶
#法芙娜可可鮮奶 重磅歸隊！
苦甜香氣細緻升級，滑順濃郁更迷人
回味「焙」感溫暖的懷抱 ➜ https://milksha.nidin.shop/ 
#迷客夏 #milksha #為了你嚴選每一杯 #濃焙茶 #重磅回歸', '2025-11-13 00:00:00', 146);
INSERT INTO public.marketing_content VALUES (104, 6, 'FB', '[Text] 芋頭鮮奶', '快看你的迷客夏必喝有沒有上榜！
𝗧𝗢𝗣𝟭 #珍珠大正紅茶拿鐵
拿起你最愛的那杯，一起看年度旁行榜
 https://milksha.nidin.shop/
融合錫蘭 × 阿薩姆紅茶的多層次茶香
𝗤 彈香甜、冬天必喝
加上醇濃綠光鮮奶與蜜漬白玉珍珠
𝗧𝗢𝗣𝟮 #輕纖蕎麥茶
無咖啡因首選
蕎麥穀香濃而不澀，溫潤順口、自然回甘
獨家製程，讓香氣更純粹
𝗧𝗢𝗣𝟯 #伯爵紅茶拿鐵
給想減少咖啡因的小迷人
釋放獨特佛手柑優雅果香
完美調和綠光鮮奶
𝗧𝗢𝗣𝟰 #原片初露青茶
口感醇厚柔順無人不愛
單茶控的清爽心頭好
選用台灣原片青茶
𝗧𝗢𝗣𝟱 #芋頭鮮奶
滋味淡雅清香、圓潤清甜
持續擔綱迷客夏「鎮店之寶」寶座
選用高雄一號芋頭精心製作
保留精華中段，手工壓製成綿密芋泥
搭配綠光鮮奶，每口都有濃濃芋頭香氣和顆粒
#迷客夏 #milksha #為了你嚴選每一杯 #2025 年度TOP10 #年度推薦
回顧𝟮𝟬𝟮𝟱年，大家最愛的迷客夏飲料有哪些?!(上集)', '2025-12-21 00:00:00', 64);
INSERT INTO public.marketing_content VALUES (105, 6, 'FB', '[Text] 法芙娜可可鮮奶', '快看你的迷客夏必喝有沒有上榜！
𝗧𝗢𝗣𝟲 #手炒黑糖鮮奶
拿起你最愛的那杯，一起看年度排行榜  https://milksha.nidin.shop/
門市手工炒製的黑糖，清甜焦香不膩口
𝗧𝗢𝗣𝟳 #柳丁綠茶
搭配綠光鮮奶，醇香可口
𝟭𝟬𝟬%柳丁原汁融合茉莉原淬綠茶
迷客夏經典不敗清爽滋味
𝗧𝗢𝗣𝟴 #琥珀高峰烏龍
清新花香襯托柑橘果香，喝得到柳丁果肉
榮獲𝟮𝟬𝟮𝟯 𝗜𝗧𝗜風味絕佳二星獎章
獨特烤焙工藝，於嗅覺評分項目獲最高肯定
𝗧𝗢𝗣𝟵 #靜岡焙焙鮮奶
琥珀色烏龍茶湯，炭焙香氣回甘留香
冬日療癒，「焙」感幸福
採用嚴選靜岡直送茶葉
獨特烘烤香氣搭配濃醇的綠光鮮奶
𝗧𝗢𝗣𝟭𝟬 #法芙娜可可鮮奶
口感醇厚滑順，完美融合焙茶＆奶香
𝗧𝗵𝗿𝗲𝗮𝗱𝘀爆紅回歸款
𝟭𝟬𝟬%法芙娜純可可粉 × 綠光鮮奶
可可香氣細緻濃香，入口滑順有層次
微糖熱飲必點
#迷客夏 #milksha #為了你嚴選每一杯 #2025 年度TOP10 #年度推薦', '2025-12-20 00:00:00', 93);
INSERT INTO public.marketing_content VALUES (106, 6, 'FB', '[Text] 茉莉原淬綠茶', '快看你的迷客夏必喝有沒有上榜！
𝗧𝗢𝗣𝟲 #手炒黑糖鮮奶
拿起你最愛的那杯，一起看年度排行榜  https://milksha.nidin.shop/
門市手工炒製的黑糖，清甜焦香不膩口
𝗧𝗢𝗣𝟳 #柳丁綠茶
搭配綠光鮮奶，醇香可口
𝟭𝟬𝟬%柳丁原汁融合茉莉原淬綠茶
迷客夏經典不敗清爽滋味
𝗧𝗢𝗣𝟴 #琥珀高峰烏龍
清新花香襯托柑橘果香，喝得到柳丁果肉
榮獲𝟮𝟬𝟮𝟯 𝗜𝗧𝗜風味絕佳二星獎章
獨特烤焙工藝，於嗅覺評分項目獲最高肯定
𝗧𝗢𝗣𝟵 #靜岡焙焙鮮奶
琥珀色烏龍茶湯，炭焙香氣回甘留香
冬日療癒，「焙」感幸福
採用嚴選靜岡直送茶葉
獨特烘烤香氣搭配濃醇的綠光鮮奶
𝗧𝗢𝗣𝟭𝟬 #法芙娜可可鮮奶
口感醇厚滑順，完美融合焙茶＆奶香
𝗧𝗵𝗿𝗲𝗮𝗱𝘀爆紅回歸款
𝟭𝟬𝟬%法芙娜純可可粉 × 綠光鮮奶
可可香氣細緻濃香，入口滑順有層次
微糖熱飲必點
#迷客夏 #milksha #為了你嚴選每一杯 #2025 年度TOP10 #年度推薦', '2025-12-20 00:00:00', 93);
INSERT INTO public.marketing_content VALUES (107, 6, 'FB', '[Text] 靜岡焙焙鮮奶', '快看你的迷客夏必喝有沒有上榜！
𝗧𝗢𝗣𝟲 #手炒黑糖鮮奶
拿起你最愛的那杯，一起看年度排行榜  https://milksha.nidin.shop/
門市手工炒製的黑糖，清甜焦香不膩口
𝗧𝗢𝗣𝟳 #柳丁綠茶
搭配綠光鮮奶，醇香可口
𝟭𝟬𝟬%柳丁原汁融合茉莉原淬綠茶
迷客夏經典不敗清爽滋味
𝗧𝗢𝗣𝟴 #琥珀高峰烏龍
清新花香襯托柑橘果香，喝得到柳丁果肉
榮獲𝟮𝟬𝟮𝟯 𝗜𝗧𝗜風味絕佳二星獎章
獨特烤焙工藝，於嗅覺評分項目獲最高肯定
𝗧𝗢𝗣𝟵 #靜岡焙焙鮮奶
琥珀色烏龍茶湯，炭焙香氣回甘留香
冬日療癒，「焙」感幸福
採用嚴選靜岡直送茶葉
獨特烘烤香氣搭配濃醇的綠光鮮奶
𝗧𝗢𝗣𝟭𝟬 #法芙娜可可鮮奶
口感醇厚滑順，完美融合焙茶＆奶香
𝗧𝗵𝗿𝗲𝗮𝗱𝘀爆紅回歸款
𝟭𝟬𝟬%法芙娜純可可粉 × 綠光鮮奶
可可香氣細緻濃香，入口滑順有層次
微糖熱飲必點
#迷客夏 #milksha #為了你嚴選每一杯 #2025 年度TOP10 #年度推薦', '2025-12-20 00:00:00', 93);
INSERT INTO public.marketing_content VALUES (108, 6, 'FB', '[Text] 琥珀高峰烏龍', '快看你的迷客夏必喝有沒有上榜！
𝗧𝗢𝗣𝟲 #手炒黑糖鮮奶
拿起你最愛的那杯，一起看年度排行榜  https://milksha.nidin.shop/
門市手工炒製的黑糖，清甜焦香不膩口
𝗧𝗢𝗣𝟳 #柳丁綠茶
搭配綠光鮮奶，醇香可口
𝟭𝟬𝟬%柳丁原汁融合茉莉原淬綠茶
迷客夏經典不敗清爽滋味
𝗧𝗢𝗣𝟴 #琥珀高峰烏龍
清新花香襯托柑橘果香，喝得到柳丁果肉
榮獲𝟮𝟬𝟮𝟯 𝗜𝗧𝗜風味絕佳二星獎章
獨特烤焙工藝，於嗅覺評分項目獲最高肯定
𝗧𝗢𝗣𝟵 #靜岡焙焙鮮奶
琥珀色烏龍茶湯，炭焙香氣回甘留香
冬日療癒，「焙」感幸福
採用嚴選靜岡直送茶葉
獨特烘烤香氣搭配濃醇的綠光鮮奶
𝗧𝗢𝗣𝟭𝟬 #法芙娜可可鮮奶
口感醇厚滑順，完美融合焙茶＆奶香
𝗧𝗵𝗿𝗲𝗮𝗱𝘀爆紅回歸款
𝟭𝟬𝟬%法芙娜純可可粉 × 綠光鮮奶
可可香氣細緻濃香，入口滑順有層次
微糖熱飲必點
#迷客夏 #milksha #為了你嚴選每一杯 #2025 年度TOP10 #年度推薦', '2025-12-20 00:00:00', 93);
INSERT INTO public.marketing_content VALUES (109, 6, 'FB', '[Text] 手炒黑糖鮮奶', '快看你的迷客夏必喝有沒有上榜！
𝗧𝗢𝗣𝟲 #手炒黑糖鮮奶
拿起你最愛的那杯，一起看年度排行榜  https://milksha.nidin.shop/
門市手工炒製的黑糖，清甜焦香不膩口
𝗧𝗢𝗣𝟳 #柳丁綠茶
搭配綠光鮮奶，醇香可口
𝟭𝟬𝟬%柳丁原汁融合茉莉原淬綠茶
迷客夏經典不敗清爽滋味
𝗧𝗢𝗣𝟴 #琥珀高峰烏龍
清新花香襯托柑橘果香，喝得到柳丁果肉
榮獲𝟮𝟬𝟮𝟯 𝗜𝗧𝗜風味絕佳二星獎章
獨特烤焙工藝，於嗅覺評分項目獲最高肯定
𝗧𝗢𝗣𝟵 #靜岡焙焙鮮奶
琥珀色烏龍茶湯，炭焙香氣回甘留香
冬日療癒，「焙」感幸福
採用嚴選靜岡直送茶葉
獨特烘烤香氣搭配濃醇的綠光鮮奶
𝗧𝗢𝗣𝟭𝟬 #法芙娜可可鮮奶
口感醇厚滑順，完美融合焙茶＆奶香
𝗧𝗵𝗿𝗲𝗮𝗱𝘀爆紅回歸款
𝟭𝟬𝟬%法芙娜純可可粉 × 綠光鮮奶
可可香氣細緻濃香，入口滑順有層次
微糖熱飲必點
#迷客夏 #milksha #為了你嚴選每一杯 #2025 年度TOP10 #年度推薦', '2025-12-20 00:00:00', 93);
INSERT INTO public.marketing_content VALUES (110, 6, 'FB', '[Text] 靜岡焙焙鮮奶', '𝟭𝟮/𝟮𝟰、𝟭𝟮/𝟮𝟱
\齁齁齁~~聖誕加「焙」幸福已抵達
/
門市現場購買 #𝟮杯靜岡焙焙鮮奶 (𝗠) 
只要 $𝟵𝟵
溫暖加焙、幸福加倍
現在就 @想一起喝迷客夏的小寶焙
一起過暖暖聖誕節
活動詳情請見官網
https://reurl.cc/xKWqKV
#迷客夏 #milksha #為了你嚴選每一杯 #靜岡焙焙鮮奶 #聖誕節快樂
𝟮𝟬𝟮𝟱 冬日暖心熱飲，你喝過哪些了呢？', '2025-12-19 00:00:00', 153);
INSERT INTO public.marketing_content VALUES (111, 6, 'FB', '[Text] 香芋仙草綠茶拿鐵', '一起收藏最療癒的冬季 𝗧𝗢𝗣 清單！
𝗧𝗢𝗣𝟭 #靜岡焙焙鮮奶
冬日療癒，「焙」感幸福
嚴選自靜岡的特選製茶名家，焙香濃郁
𝗧𝗢𝗣𝟮 #珍珠大正紅茶拿鐵
搭配綠光鮮奶，滑順醇厚、暖心必喝
大正紅茶融合錫蘭 × 阿薩姆紅茶的多層次茶香
𝗤 彈香甜、冬天必喝
加上醇濃綠光鮮奶與蜜漬白玉珍珠
𝗧𝗢𝗣𝟯 #法芙娜可可鮮奶
選用可可屆愛馬仕的𝟭𝟬𝟬%頂級法芙娜純可可粉
網友敲碗~重磅回歸刮起法芙娜可可旋風
高雅的苦甜香氣搭配滑順濃香的綠光鮮奶
入口時可可香氣層次明顯
𝗧𝗢𝗣𝟰 #琥珀烏龍拿鐵
推薦微糖熱飲最美味
炭焙香氣 × 綠光鮮奶
𝗧𝗢𝗣𝟱 #香芋仙草綠茶拿鐵
柔順口感、層次豐富的冬日暖意
延續榮獲 𝗔.𝗔. 純粹品味三星獎的芋頭鮮奶口碑
創新結合綠茶與嫩仙草凍
𝗧𝗢𝗣𝟲 #白甘蔗青茶
仙草甘味與滑順奶香蔓延口中
選用台灣𝟭𝟬𝟬%白甘蔗原汁
搭配清新青茶，滋味圓潤清甜
最療癒的冬季，需要最暖心的熱飲  https://milksha.nidin.shop/
#迷客夏 #milksha #為了你嚴選每一杯 #2025 冬日暖心推薦 #冬日必喝', '2025-12-10 00:00:00', 143);
INSERT INTO public.marketing_content VALUES (112, 6, 'FB', '[Text] 珍珠大正紅茶拿鐵', '一起收藏最療癒的冬季 𝗧𝗢𝗣 清單！
𝗧𝗢𝗣𝟭 #靜岡焙焙鮮奶
冬日療癒，「焙」感幸福
嚴選自靜岡的特選製茶名家，焙香濃郁
𝗧𝗢𝗣𝟮 #珍珠大正紅茶拿鐵
搭配綠光鮮奶，滑順醇厚、暖心必喝
大正紅茶融合錫蘭 × 阿薩姆紅茶的多層次茶香
𝗤 彈香甜、冬天必喝
加上醇濃綠光鮮奶與蜜漬白玉珍珠
𝗧𝗢𝗣𝟯 #法芙娜可可鮮奶
選用可可屆愛馬仕的𝟭𝟬𝟬%頂級法芙娜純可可粉
網友敲碗~重磅回歸刮起法芙娜可可旋風
高雅的苦甜香氣搭配滑順濃香的綠光鮮奶
入口時可可香氣層次明顯
𝗧𝗢𝗣𝟰 #琥珀烏龍拿鐵
推薦微糖熱飲最美味
炭焙香氣 × 綠光鮮奶
𝗧𝗢𝗣𝟱 #香芋仙草綠茶拿鐵
柔順口感、層次豐富的冬日暖意
延續榮獲 𝗔.𝗔. 純粹品味三星獎的芋頭鮮奶口碑
創新結合綠茶與嫩仙草凍
𝗧𝗢𝗣𝟲 #白甘蔗青茶
仙草甘味與滑順奶香蔓延口中
選用台灣𝟭𝟬𝟬%白甘蔗原汁
搭配清新青茶，滋味圓潤清甜
最療癒的冬季，需要最暖心的熱飲  https://milksha.nidin.shop/
#迷客夏 #milksha #為了你嚴選每一杯 #2025 冬日暖心推薦 #冬日必喝', '2025-12-10 00:00:00', 143);
INSERT INTO public.marketing_content VALUES (113, 6, 'FB', '[Text] 法芙娜可可鮮奶', '一起收藏最療癒的冬季 𝗧𝗢𝗣 清單！
𝗧𝗢𝗣𝟭 #靜岡焙焙鮮奶
冬日療癒，「焙」感幸福
嚴選自靜岡的特選製茶名家，焙香濃郁
𝗧𝗢𝗣𝟮 #珍珠大正紅茶拿鐵
搭配綠光鮮奶，滑順醇厚、暖心必喝
大正紅茶融合錫蘭 × 阿薩姆紅茶的多層次茶香
𝗤 彈香甜、冬天必喝
加上醇濃綠光鮮奶與蜜漬白玉珍珠
𝗧𝗢𝗣𝟯 #法芙娜可可鮮奶
選用可可屆愛馬仕的𝟭𝟬𝟬%頂級法芙娜純可可粉
網友敲碗~重磅回歸刮起法芙娜可可旋風
高雅的苦甜香氣搭配滑順濃香的綠光鮮奶
入口時可可香氣層次明顯
𝗧𝗢𝗣𝟰 #琥珀烏龍拿鐵
推薦微糖熱飲最美味
炭焙香氣 × 綠光鮮奶
𝗧𝗢𝗣𝟱 #香芋仙草綠茶拿鐵
柔順口感、層次豐富的冬日暖意
延續榮獲 𝗔.𝗔. 純粹品味三星獎的芋頭鮮奶口碑
創新結合綠茶與嫩仙草凍
𝗧𝗢𝗣𝟲 #白甘蔗青茶
仙草甘味與滑順奶香蔓延口中
選用台灣𝟭𝟬𝟬%白甘蔗原汁
搭配清新青茶，滋味圓潤清甜
最療癒的冬季，需要最暖心的熱飲  https://milksha.nidin.shop/
#迷客夏 #milksha #為了你嚴選每一杯 #2025 冬日暖心推薦 #冬日必喝', '2025-12-10 00:00:00', 143);
INSERT INTO public.marketing_content VALUES (114, 6, 'FB', '[Text] 靜岡焙焙鮮奶', '一起收藏最療癒的冬季 𝗧𝗢𝗣 清單！
𝗧𝗢𝗣𝟭 #靜岡焙焙鮮奶
冬日療癒，「焙」感幸福
嚴選自靜岡的特選製茶名家，焙香濃郁
𝗧𝗢𝗣𝟮 #珍珠大正紅茶拿鐵
搭配綠光鮮奶，滑順醇厚、暖心必喝
大正紅茶融合錫蘭 × 阿薩姆紅茶的多層次茶香
𝗤 彈香甜、冬天必喝
加上醇濃綠光鮮奶與蜜漬白玉珍珠
𝗧𝗢𝗣𝟯 #法芙娜可可鮮奶
選用可可屆愛馬仕的𝟭𝟬𝟬%頂級法芙娜純可可粉
網友敲碗~重磅回歸刮起法芙娜可可旋風
高雅的苦甜香氣搭配滑順濃香的綠光鮮奶
入口時可可香氣層次明顯
𝗧𝗢𝗣𝟰 #琥珀烏龍拿鐵
推薦微糖熱飲最美味
炭焙香氣 × 綠光鮮奶
𝗧𝗢𝗣𝟱 #香芋仙草綠茶拿鐵
柔順口感、層次豐富的冬日暖意
延續榮獲 𝗔.𝗔. 純粹品味三星獎的芋頭鮮奶口碑
創新結合綠茶與嫩仙草凍
𝗧𝗢𝗣𝟲 #白甘蔗青茶
仙草甘味與滑順奶香蔓延口中
選用台灣𝟭𝟬𝟬%白甘蔗原汁
搭配清新青茶，滋味圓潤清甜
最療癒的冬季，需要最暖心的熱飲  https://milksha.nidin.shop/
#迷客夏 #milksha #為了你嚴選每一杯 #2025 冬日暖心推薦 #冬日必喝', '2025-12-10 00:00:00', 143);
INSERT INTO public.marketing_content VALUES (115, 6, 'FB', '[Text] 琥珀烏龍拿鐵', '一起收藏最療癒的冬季 𝗧𝗢𝗣 清單！
𝗧𝗢𝗣𝟭 #靜岡焙焙鮮奶
冬日療癒，「焙」感幸福
嚴選自靜岡的特選製茶名家，焙香濃郁
𝗧𝗢𝗣𝟮 #珍珠大正紅茶拿鐵
搭配綠光鮮奶，滑順醇厚、暖心必喝
大正紅茶融合錫蘭 × 阿薩姆紅茶的多層次茶香
𝗤 彈香甜、冬天必喝
加上醇濃綠光鮮奶與蜜漬白玉珍珠
𝗧𝗢𝗣𝟯 #法芙娜可可鮮奶
選用可可屆愛馬仕的𝟭𝟬𝟬%頂級法芙娜純可可粉
網友敲碗~重磅回歸刮起法芙娜可可旋風
高雅的苦甜香氣搭配滑順濃香的綠光鮮奶
入口時可可香氣層次明顯
𝗧𝗢𝗣𝟰 #琥珀烏龍拿鐵
推薦微糖熱飲最美味
炭焙香氣 × 綠光鮮奶
𝗧𝗢𝗣𝟱 #香芋仙草綠茶拿鐵
柔順口感、層次豐富的冬日暖意
延續榮獲 𝗔.𝗔. 純粹品味三星獎的芋頭鮮奶口碑
創新結合綠茶與嫩仙草凍
𝗧𝗢𝗣𝟲 #白甘蔗青茶
仙草甘味與滑順奶香蔓延口中
選用台灣𝟭𝟬𝟬%白甘蔗原汁
搭配清新青茶，滋味圓潤清甜
最療癒的冬季，需要最暖心的熱飲  https://milksha.nidin.shop/
#迷客夏 #milksha #為了你嚴選每一杯 #2025 冬日暖心推薦 #冬日必喝', '2025-12-10 00:00:00', 143);
INSERT INTO public.marketing_content VALUES (116, 6, 'FB', '[Text] 靜岡焙焙烏龍拿鐵', '大家敲破碗的 #冬季限定 人氣飲品回歸啦！
靜岡焙焙鮮奶、靜岡焙焙烏龍拿鐵 濃郁登場
嚴選靜岡製茶名家精工研磨，細緻茶粉完整釋放焙香茶韻
#靜岡焙焙鮮奶 迷編最推薦
靜岡焙茶烤焙香氣 × 綠光鮮奶的醇厚滑順
一口享受高品質的飲茶體驗
榮獲𝗜𝗧𝗜風味絕佳二星獎章的 #琥珀高峰烏龍茶 x #綠光鮮奶
#靜岡焙焙烏龍拿鐵
炭焙茶香交織濃郁奶香，清爽甘醇不膩口
同場加映
法國 𝗩𝗮𝗹𝗿𝗵𝗼𝗻𝗮 頂級純可可 × 綠光鮮奶
#法芙娜可可鮮奶 重磅歸隊！
苦甜香氣細緻升級，滑順濃郁更迷人
回味「焙」感溫暖的懷抱 ➜ https://milksha.nidin.shop/ 
#迷客夏 #milksha #為了你嚴選每一杯 #濃焙茶 #重磅回歸', '2025-11-13 00:00:00', 146);
INSERT INTO public.marketing_content VALUES (128, 7, 'FB', '[Text] 沖繩黑糖奶茶', '今天就讓一杯暖甜的 #沖繩黑糖系列
陪你一起度過最閃亮的節日吧～
透過完美比例與台灣黑糖蔗香融合
焦香 × 奶香 × 茶香 層層堆疊
喝一口直接：天啊也太幸福了吧 (๑´ڡ`๑)
和最重要的朋友在這一天相聚
一杯暖暖黑糖飲＝完美儀式感 ♡ 
#沖繩黑糖奶茶 #沖繩黑糖奶綠
#黑糖紅茶拿鐵 #黑糖港式厚奶
#聖誕節快樂 #暖心必喝 #無可取代的單杯現萃', '2025-12-25 00:00:00', 23);
INSERT INTO public.marketing_content VALUES (118, 6, 'FB', '[Text] 琥珀高峰烏龍茶', '大家敲破碗的 #冬季限定 人氣飲品回歸啦！
靜岡焙焙鮮奶、靜岡焙焙烏龍拿鐵 濃郁登場
嚴選靜岡製茶名家精工研磨，細緻茶粉完整釋放焙香茶韻
#靜岡焙焙鮮奶 迷編最推薦
靜岡焙茶烤焙香氣 × 綠光鮮奶的醇厚滑順
一口享受高品質的飲茶體驗
榮獲𝗜𝗧𝗜風味絕佳二星獎章的 #琥珀高峰烏龍茶 x #綠光鮮奶
#靜岡焙焙烏龍拿鐵
炭焙茶香交織濃郁奶香，清爽甘醇不膩口
同場加映
法國 𝗩𝗮𝗹𝗿𝗵𝗼𝗻𝗮 頂級純可可 × 綠光鮮奶
#法芙娜可可鮮奶 重磅歸隊！
苦甜香氣細緻升級，滑順濃郁更迷人
回味「焙」感溫暖的懷抱 ➜ https://milksha.nidin.shop/ 
#迷客夏 #milksha #為了你嚴選每一杯 #濃焙茶 #重磅回歸', '2025-11-13 00:00:00', 146);
INSERT INTO public.marketing_content VALUES (119, 6, 'FB', '[Text] 靜岡焙焙鮮奶', '大家敲破碗的 #冬季限定 人氣飲品回歸啦！
靜岡焙焙鮮奶、靜岡焙焙烏龍拿鐵 濃郁登場
嚴選靜岡製茶名家精工研磨，細緻茶粉完整釋放焙香茶韻
#靜岡焙焙鮮奶 迷編最推薦
靜岡焙茶烤焙香氣 × 綠光鮮奶的醇厚滑順
一口享受高品質的飲茶體驗
榮獲𝗜𝗧𝗜風味絕佳二星獎章的 #琥珀高峰烏龍茶 x #綠光鮮奶
#靜岡焙焙烏龍拿鐵
炭焙茶香交織濃郁奶香，清爽甘醇不膩口
同場加映
法國 𝗩𝗮𝗹𝗿𝗵𝗼𝗻𝗮 頂級純可可 × 綠光鮮奶
#法芙娜可可鮮奶 重磅歸隊！
苦甜香氣細緻升級，滑順濃郁更迷人
回味「焙」感溫暖的懷抱 ➜ https://milksha.nidin.shop/ 
#迷客夏 #milksha #為了你嚴選每一杯 #濃焙茶 #重磅回歸', '2025-11-13 00:00:00', 146);
INSERT INTO public.marketing_content VALUES (120, 6, 'FB', '[Text] 綠光鮮奶', '大家敲破碗的 #冬季限定 人氣飲品回歸啦！
靜岡焙焙鮮奶、靜岡焙焙烏龍拿鐵 濃郁登場
嚴選靜岡製茶名家精工研磨，細緻茶粉完整釋放焙香茶韻
#靜岡焙焙鮮奶 迷編最推薦
靜岡焙茶烤焙香氣 × 綠光鮮奶的醇厚滑順
一口享受高品質的飲茶體驗
榮獲𝗜𝗧𝗜風味絕佳二星獎章的 #琥珀高峰烏龍茶 x #綠光鮮奶
#靜岡焙焙烏龍拿鐵
炭焙茶香交織濃郁奶香，清爽甘醇不膩口
同場加映
法國 𝗩𝗮𝗹𝗿𝗵𝗼𝗻𝗮 頂級純可可 × 綠光鮮奶
#法芙娜可可鮮奶 重磅歸隊！
苦甜香氣細緻升級，滑順濃郁更迷人
回味「焙」感溫暖的懷抱 ➜ https://milksha.nidin.shop/ 
#迷客夏 #milksha #為了你嚴選每一杯 #濃焙茶 #重磅回歸', '2025-11-13 00:00:00', 146);
INSERT INTO public.marketing_content VALUES (121, 6, 'FB', '[Text] 娜杯桂香拿鐵', '\首款花香基調 —「桂香茶境」𝟭𝟭/𝟱 桂香四溢/
花香與茶香的邂逅
#娜杯桂香拿鐵
花香、茶香、奶香交織出圓潤細滑的優雅風味
#桂香青檸粉粿
搭配𝗤彈粉粿，一口沁香爽感
桂花香氣融合青茶與檸檬微酸
#桂香原片青
嚴選台灣原片青茶結合金桂甜韻
清爽甘醇如微風拂過花園
#桂香輕蕎麥
蕎麥穀香交織桂花柔香
溫潤回甘、無咖啡因的療癒系飲品
迷客夏首款花香系𝗤彈粉粿登場.ᐟ
#桂香粉粿
每一口都散發柔香餘韻，搭配各式茶飲都超加分
立即沉浸在桂香茶境中
https://reurl.cc/pKd0mx 
#迷客夏 #milksha #喝一口繼續走 #桂香茶境', '2025-11-04 00:00:00', 111);
INSERT INTO public.marketing_content VALUES (122, 6, 'FB', '[Text] 桂香原片青', '\首款花香基調 —「桂香茶境」𝟭𝟭/𝟱 桂香四溢/
花香與茶香的邂逅
#娜杯桂香拿鐵
花香、茶香、奶香交織出圓潤細滑的優雅風味
#桂香青檸粉粿
搭配𝗤彈粉粿，一口沁香爽感
桂花香氣融合青茶與檸檬微酸
#桂香原片青
嚴選台灣原片青茶結合金桂甜韻
清爽甘醇如微風拂過花園
#桂香輕蕎麥
蕎麥穀香交織桂花柔香
溫潤回甘、無咖啡因的療癒系飲品
迷客夏首款花香系𝗤彈粉粿登場.ᐟ
#桂香粉粿
每一口都散發柔香餘韻，搭配各式茶飲都超加分
立即沉浸在桂香茶境中
https://reurl.cc/pKd0mx 
#迷客夏 #milksha #喝一口繼續走 #桂香茶境', '2025-11-04 00:00:00', 111);
INSERT INTO public.marketing_content VALUES (123, 6, 'FB', '[Text] 桂香輕蕎麥', '\首款花香基調 —「桂香茶境」𝟭𝟭/𝟱 桂香四溢/
花香與茶香的邂逅
#娜杯桂香拿鐵
花香、茶香、奶香交織出圓潤細滑的優雅風味
#桂香青檸粉粿
搭配𝗤彈粉粿，一口沁香爽感
桂花香氣融合青茶與檸檬微酸
#桂香原片青
嚴選台灣原片青茶結合金桂甜韻
清爽甘醇如微風拂過花園
#桂香輕蕎麥
蕎麥穀香交織桂花柔香
溫潤回甘、無咖啡因的療癒系飲品
迷客夏首款花香系𝗤彈粉粿登場.ᐟ
#桂香粉粿
每一口都散發柔香餘韻，搭配各式茶飲都超加分
立即沉浸在桂香茶境中
https://reurl.cc/pKd0mx 
#迷客夏 #milksha #喝一口繼續走 #桂香茶境', '2025-11-04 00:00:00', 111);
INSERT INTO public.marketing_content VALUES (126, 7, 'FB', '[Text] 沖繩黑糖奶茶', '跨年夜一定要來點「咀嚼系幸福」(〃∀〃)
今年最後一杯＆新年第一杯——
#COMEBUY #沖繩黑糖奶茶
雙𝗤𝟭號（珍珠＋粉條）
—— 甜度僅靠黑糖
半糖以上最有味 ♡
𝗤彈、軟糯、焦香、濃奶一次登場
比煙火還療癒的口感衝擊就在這刻炸開
跨年的願望不一定要很偉大：
喝到好喝的
心情甜一點
明年更順一點
迎向 𝟮𝟬𝟮𝟲，讓暖甜先替你開個好頭吧～
這杯就能全包辦 (๑˃ᴗ˂) و♡
#跨年 #新年必喝 #雙Q 咀嚼控集合
#黑糖不另外加糖 #半糖以上最有味
𝗠𝗲𝗿𝗿𝘆 𝗖𝗵𝗿𝗶𝘀𝘁𝗺𝗮𝘀 
 
聖誕快樂呀大家 (ﾉ>▽<)ﾉ', '2025-12-31 00:00:00', 35);
INSERT INTO public.marketing_content VALUES (129, 7, 'FB', '[Text] 黑糖港式厚奶', '今天就讓一杯暖甜的 #沖繩黑糖系列
陪你一起度過最閃亮的節日吧～
透過完美比例與台灣黑糖蔗香融合
焦香 × 奶香 × 茶香 層層堆疊
喝一口直接：天啊也太幸福了吧 (๑´ڡ`๑)
和最重要的朋友在這一天相聚
一杯暖暖黑糖飲＝完美儀式感 ♡ 
#沖繩黑糖奶茶 #沖繩黑糖奶綠
#黑糖紅茶拿鐵 #黑糖港式厚奶
#聖誕節快樂 #暖心必喝 #無可取代的單杯現萃', '2025-12-25 00:00:00', 23);
INSERT INTO public.marketing_content VALUES (130, 7, 'FB', '[Text] 黑糖紅茶拿鐵', '今天就讓一杯暖甜的 #沖繩黑糖系列
陪你一起度過最閃亮的節日吧～
透過完美比例與台灣黑糖蔗香融合
焦香 × 奶香 × 茶香 層層堆疊
喝一口直接：天啊也太幸福了吧 (๑´ڡ`๑)
和最重要的朋友在這一天相聚
一杯暖暖黑糖飲＝完美儀式感 ♡ 
#沖繩黑糖奶茶 #沖繩黑糖奶綠
#黑糖紅茶拿鐵 #黑糖港式厚奶
#聖誕節快樂 #暖心必喝 #無可取代的單杯現萃', '2025-12-25 00:00:00', 23);
INSERT INTO public.marketing_content VALUES (131, 7, 'FB', '[Text] 沖繩黑糖奶綠', '今天就讓一杯暖甜的 #沖繩黑糖系列
陪你一起度過最閃亮的節日吧～
透過完美比例與台灣黑糖蔗香融合
焦香 × 奶香 × 茶香 層層堆疊
喝一口直接：天啊也太幸福了吧 (๑´ڡ`๑)
和最重要的朋友在這一天相聚
一杯暖暖黑糖飲＝完美儀式感 ♡ 
#沖繩黑糖奶茶 #沖繩黑糖奶綠
#黑糖紅茶拿鐵 #黑糖港式厚奶
#聖誕節快樂 #暖心必喝 #無可取代的單杯現萃', '2025-12-25 00:00:00', 23);
INSERT INTO public.marketing_content VALUES (132, 7, 'FB', '[Text] 港式厚奶', '今天就讓一杯暖甜的 #沖繩黑糖系列
陪你一起度過最閃亮的節日吧～
透過完美比例與台灣黑糖蔗香融合
焦香 × 奶香 × 茶香 層層堆疊
喝一口直接：天啊也太幸福了吧 (๑´ڡ`๑)
和最重要的朋友在這一天相聚
一杯暖暖黑糖飲＝完美儀式感 ♡ 
#沖繩黑糖奶茶 #沖繩黑糖奶綠
#黑糖紅茶拿鐵 #黑糖港式厚奶
#聖誕節快樂 #暖心必喝 #無可取代的單杯現萃', '2025-12-25 00:00:00', 23);
INSERT INTO public.marketing_content VALUES (133, 7, 'FB', '[Text] 沖繩黑糖奶茶', '\\ 期盼の新品來了 //
熬煮香氣升級的【沖繩黑糖系列】全新上市
喝一口就知道——這次真的很可以 (*´∀`)ﾉ
融合台灣黑糖蔗香，堆疊出馥郁焦糖香氣
#沖繩黑糖奶茶 $𝟲𝟬(𝗟)
台灣黑糖 × 沖繩黑糖，融入錫蘭紅茶與醇厚奶香，
#沖繩黑糖奶綠 $𝟲𝟬(𝗟)
馥郁焦糖香交織甜潤奶茶，香濃不膩、飽滿順口！
雙黑糖結合醺香綠茶與奶香，
#黑糖紅茶拿鐵 $𝟳𝟱(𝗟)
散發焦糖香氣，茶感清爽、奶韻柔和的完美平衡！
現泡烏瓦紅茶＋鮮乳，茶香濃厚香醇；
#黑糖港式厚奶 $𝟴𝟬(𝗠)
雙黑糖提味，焦香迷人卻不膩口，是鮮奶茶愛好者首選！
現泡錫蘭紅茶混淡奶打造港式厚實口感，
搭配雙黑糖提升焦甜層次，濃郁茶香與滑順奶韻一次到位！
#新品上市 #沖繩融合台灣黑糖 #馥郁焦糖香
#無可取代的單杯現萃 #半糖以上風味最佳 #暖心登場
⧁ 加入官方𝗟𝗜𝗡𝗘點連結拿𝟵折券 ➙ https://comebuy.pse.is/74g326
—
⧁ 全台門市據點 ➙ https://lihi1.com/9IiXS
⧁ 門市菜單 ➙ https://lihi1.com/xbX73', '2025-12-19 00:00:00', 30);
INSERT INTO public.marketing_content VALUES (134, 7, 'FB', '[Text] 黑糖港式厚奶', '\\ 期盼の新品來了 //
熬煮香氣升級的【沖繩黑糖系列】全新上市
喝一口就知道——這次真的很可以 (*´∀`)ﾉ
融合台灣黑糖蔗香，堆疊出馥郁焦糖香氣
#沖繩黑糖奶茶 $𝟲𝟬(𝗟)
台灣黑糖 × 沖繩黑糖，融入錫蘭紅茶與醇厚奶香，
#沖繩黑糖奶綠 $𝟲𝟬(𝗟)
馥郁焦糖香交織甜潤奶茶，香濃不膩、飽滿順口！
雙黑糖結合醺香綠茶與奶香，
#黑糖紅茶拿鐵 $𝟳𝟱(𝗟)
散發焦糖香氣，茶感清爽、奶韻柔和的完美平衡！
現泡烏瓦紅茶＋鮮乳，茶香濃厚香醇；
#黑糖港式厚奶 $𝟴𝟬(𝗠)
雙黑糖提味，焦香迷人卻不膩口，是鮮奶茶愛好者首選！
現泡錫蘭紅茶混淡奶打造港式厚實口感，
搭配雙黑糖提升焦甜層次，濃郁茶香與滑順奶韻一次到位！
#新品上市 #沖繩融合台灣黑糖 #馥郁焦糖香
#無可取代的單杯現萃 #半糖以上風味最佳 #暖心登場
⧁ 加入官方𝗟𝗜𝗡𝗘點連結拿𝟵折券 ➙ https://comebuy.pse.is/74g326
—
⧁ 全台門市據點 ➙ https://lihi1.com/9IiXS
⧁ 門市菜單 ➙ https://lihi1.com/xbX73', '2025-12-19 00:00:00', 30);
INSERT INTO public.marketing_content VALUES (135, 7, 'FB', '[Text] 黑糖紅茶拿鐵', '\\ 期盼の新品來了 //
熬煮香氣升級的【沖繩黑糖系列】全新上市
喝一口就知道——這次真的很可以 (*´∀`)ﾉ
融合台灣黑糖蔗香，堆疊出馥郁焦糖香氣
#沖繩黑糖奶茶 $𝟲𝟬(𝗟)
台灣黑糖 × 沖繩黑糖，融入錫蘭紅茶與醇厚奶香，
#沖繩黑糖奶綠 $𝟲𝟬(𝗟)
馥郁焦糖香交織甜潤奶茶，香濃不膩、飽滿順口！
雙黑糖結合醺香綠茶與奶香，
#黑糖紅茶拿鐵 $𝟳𝟱(𝗟)
散發焦糖香氣，茶感清爽、奶韻柔和的完美平衡！
現泡烏瓦紅茶＋鮮乳，茶香濃厚香醇；
#黑糖港式厚奶 $𝟴𝟬(𝗠)
雙黑糖提味，焦香迷人卻不膩口，是鮮奶茶愛好者首選！
現泡錫蘭紅茶混淡奶打造港式厚實口感，
搭配雙黑糖提升焦甜層次，濃郁茶香與滑順奶韻一次到位！
#新品上市 #沖繩融合台灣黑糖 #馥郁焦糖香
#無可取代的單杯現萃 #半糖以上風味最佳 #暖心登場
⧁ 加入官方𝗟𝗜𝗡𝗘點連結拿𝟵折券 ➙ https://comebuy.pse.is/74g326
—
⧁ 全台門市據點 ➙ https://lihi1.com/9IiXS
⧁ 門市菜單 ➙ https://lihi1.com/xbX73', '2025-12-19 00:00:00', 30);
INSERT INTO public.marketing_content VALUES (136, 7, 'FB', '[Text] 沖繩黑糖奶綠', '\\ 期盼の新品來了 //
熬煮香氣升級的【沖繩黑糖系列】全新上市
喝一口就知道——這次真的很可以 (*´∀`)ﾉ
融合台灣黑糖蔗香，堆疊出馥郁焦糖香氣
#沖繩黑糖奶茶 $𝟲𝟬(𝗟)
台灣黑糖 × 沖繩黑糖，融入錫蘭紅茶與醇厚奶香，
#沖繩黑糖奶綠 $𝟲𝟬(𝗟)
馥郁焦糖香交織甜潤奶茶，香濃不膩、飽滿順口！
雙黑糖結合醺香綠茶與奶香，
#黑糖紅茶拿鐵 $𝟳𝟱(𝗟)
散發焦糖香氣，茶感清爽、奶韻柔和的完美平衡！
現泡烏瓦紅茶＋鮮乳，茶香濃厚香醇；
#黑糖港式厚奶 $𝟴𝟬(𝗠)
雙黑糖提味，焦香迷人卻不膩口，是鮮奶茶愛好者首選！
現泡錫蘭紅茶混淡奶打造港式厚實口感，
搭配雙黑糖提升焦甜層次，濃郁茶香與滑順奶韻一次到位！
#新品上市 #沖繩融合台灣黑糖 #馥郁焦糖香
#無可取代的單杯現萃 #半糖以上風味最佳 #暖心登場
⧁ 加入官方𝗟𝗜𝗡𝗘點連結拿𝟵折券 ➙ https://comebuy.pse.is/74g326
—
⧁ 全台門市據點 ➙ https://lihi1.com/9IiXS
⧁ 門市菜單 ➙ https://lihi1.com/xbX73', '2025-12-19 00:00:00', 30);
INSERT INTO public.marketing_content VALUES (155, 8, 'FB', '[Text] 普洱', '龜記茗品×  樂步le brewlife
當茶遇上咖啡，碰撞出這個秋冬最獨特的香氣
龜記攜手不斷挑戰與創新的樂步 le brewlife，
雙品牌貫徹重視的「品質」與「生活感」，
打破手搖飲的傳統框架。
結合樂步的義式濃醇咖啡
融合順滑奶感，帶出濃郁溫暖的冬季限定特調。
驚喜又充滿細節與質感的風味，
完美展現兩個品牌的堅持與講究。
溫馨提醒：本產品以 100% 純咖啡液製成，咖啡液中含有多酚類等活性成分，在儲存
過程中可能產生微量沉澱，屬於正常現象不影響品質，為天然純咖啡的特徵之一。
#龜記 #GUIJI #樂步 #lebrewlife #普洱 #咖啡 #普洱咖啡奶茶 #普洱咖啡鮮乳', '2025-10-28 00:00:00', 99);
INSERT INTO public.marketing_content VALUES (138, 7, 'FB', '[Text] 小葉紅拿鐵', '\ 葉~~~~~~~~真的回來了.ᐟ.ᐟ /
國際連鎖品牌中 #COMEBUY 全球首賣
限量嫩採的《小葉紅茶》重磅回歸
在地好茶就是要 #現萃 才好喝 (✪ω✪)
#小葉紅茶 $𝟱𝟬(𝗟)
一起品味頂級紅茶、享受質感生活
嚴選南投縣名間鄉嫩採的四季春重發酵製成
#小葉紅奶茶 $𝟳𝟬(𝗟)
擁有獨特果蜜香，茶湯溫潤、細緻高雅、不苦不澀！
滋味柔順、甘甜順口的小葉紅茶混入奶精粉
#小葉紅拿鐵 $𝟳𝟱(𝗟)
昇華香醇豐厚口感，奶茶控必喝！
順口回甘小葉紅茶加入香醇鮮奶
成為健康族群最愛的頂級鮮奶茶！
#季節限定 #四季春 #高品質 #紅茶 #限量嫩採
#無可取代的單杯現萃 #限來店購買 #售完為止
⧁ 加入官方𝗟𝗜𝗡𝗘點連結拿𝟵折券 ➙ https://comebuy.pse.is/74g326
—
⧁ 全台門市據點 ➙ https://lihi1.com/9IiXS
⧁ 門市菜單 ➙ https://lihi1.com/xbX73', '2025-11-06 00:00:00', 41);
INSERT INTO public.marketing_content VALUES (139, 7, 'FB', '[Text] 小葉紅奶茶', '\ 葉~~~~~~~~真的回來了.ᐟ.ᐟ /
國際連鎖品牌中 #COMEBUY 全球首賣
限量嫩採的《小葉紅茶》重磅回歸
在地好茶就是要 #現萃 才好喝 (✪ω✪)
#小葉紅茶 $𝟱𝟬(𝗟)
一起品味頂級紅茶、享受質感生活
嚴選南投縣名間鄉嫩採的四季春重發酵製成
#小葉紅奶茶 $𝟳𝟬(𝗟)
擁有獨特果蜜香，茶湯溫潤、細緻高雅、不苦不澀！
滋味柔順、甘甜順口的小葉紅茶混入奶精粉
#小葉紅拿鐵 $𝟳𝟱(𝗟)
昇華香醇豐厚口感，奶茶控必喝！
順口回甘小葉紅茶加入香醇鮮奶
成為健康族群最愛的頂級鮮奶茶！
#季節限定 #四季春 #高品質 #紅茶 #限量嫩採
#無可取代的單杯現萃 #限來店購買 #售完為止
⧁ 加入官方𝗟𝗜𝗡𝗘點連結拿𝟵折券 ➙ https://comebuy.pse.is/74g326
—
⧁ 全台門市據點 ➙ https://lihi1.com/9IiXS
⧁ 門市菜單 ➙ https://lihi1.com/xbX73', '2025-11-06 00:00:00', 41);
INSERT INTO public.marketing_content VALUES (140, 7, 'FB', '[Text] 小葉紅茶', '\ 葉~~~~~~~~真的回來了.ᐟ.ᐟ /
國際連鎖品牌中 #COMEBUY 全球首賣
限量嫩採的《小葉紅茶》重磅回歸
在地好茶就是要 #現萃 才好喝 (✪ω✪)
#小葉紅茶 $𝟱𝟬(𝗟)
一起品味頂級紅茶、享受質感生活
嚴選南投縣名間鄉嫩採的四季春重發酵製成
#小葉紅奶茶 $𝟳𝟬(𝗟)
擁有獨特果蜜香，茶湯溫潤、細緻高雅、不苦不澀！
滋味柔順、甘甜順口的小葉紅茶混入奶精粉
#小葉紅拿鐵 $𝟳𝟱(𝗟)
昇華香醇豐厚口感，奶茶控必喝！
順口回甘小葉紅茶加入香醇鮮奶
成為健康族群最愛的頂級鮮奶茶！
#季節限定 #四季春 #高品質 #紅茶 #限量嫩採
#無可取代的單杯現萃 #限來店購買 #售完為止
⧁ 加入官方𝗟𝗜𝗡𝗘點連結拿𝟵折券 ➙ https://comebuy.pse.is/74g326
—
⧁ 全台門市據點 ➙ https://lihi1.com/9IiXS
⧁ 門市菜單 ➙ https://lihi1.com/xbX73', '2025-11-06 00:00:00', 41);
INSERT INTO public.marketing_content VALUES (141, 7, 'FB', '[Text] 四季春', '\ 葉~~~~~~~~真的回來了.ᐟ.ᐟ /
國際連鎖品牌中 #COMEBUY 全球首賣
限量嫩採的《小葉紅茶》重磅回歸
在地好茶就是要 #現萃 才好喝 (✪ω✪)
#小葉紅茶 $𝟱𝟬(𝗟)
一起品味頂級紅茶、享受質感生活
嚴選南投縣名間鄉嫩採的四季春重發酵製成
#小葉紅奶茶 $𝟳𝟬(𝗟)
擁有獨特果蜜香，茶湯溫潤、細緻高雅、不苦不澀！
滋味柔順、甘甜順口的小葉紅茶混入奶精粉
#小葉紅拿鐵 $𝟳𝟱(𝗟)
昇華香醇豐厚口感，奶茶控必喝！
順口回甘小葉紅茶加入香醇鮮奶
成為健康族群最愛的頂級鮮奶茶！
#季節限定 #四季春 #高品質 #紅茶 #限量嫩採
#無可取代的單杯現萃 #限來店購買 #售完為止
⧁ 加入官方𝗟𝗜𝗡𝗘點連結拿𝟵折券 ➙ https://comebuy.pse.is/74g326
—
⧁ 全台門市據點 ➙ https://lihi1.com/9IiXS
⧁ 門市菜單 ➙ https://lihi1.com/xbX73', '2025-11-06 00:00:00', 41);
INSERT INTO public.marketing_content VALUES (143, 7, 'FB', '[Text] 玩火', '萬聖節最「火」裝扮出爐
南瓜人都來 #COMEBUY 報到啦
玩火不只好喝～還能當配件（誤
）
擁有熱帶水果風味的黃金茶湯
讓你成為派對裡最亮眼的焦點
今年萬聖節 ——
不喝茶就搗蛋 ლ(>д< ლ)
#萬聖節快樂 #無可取代的單杯現萃 #現萃驚艷
⧁ 全台門市據點 ➙ https://lihi1.com/9IiXS
—
⧁ 門市菜單 ➙ https://lihi1.com/xbX73', '2025-10-29 00:00:00', 19);
INSERT INTO public.marketing_content VALUES (144, 7, 'FB', '[Text] 玩火玩火奶茶', '中秋節不只要烤肉
更要 #玩火
一家烤肉萬家香
一杯 #現萃 超沁爽.ᐟ.ᐟ
嚴選甘甜煎茶與清香烏龍
混拼百香果、芒果等熱帶水果風味烘製
果香四溢中透著淡淡蘭花香(๑´ڡ`๑)
𝟭𝟬/𝟭𝟱前至全台 𝗖𝗢𝗠𝗘𝗕𝗨𝗬 門市
門市現場
限量活動
免費加入 #船井生醫 FIP100 纖維粉𝟭包（升級纖萃
）
現場消費【玩火/玩火奶茶】任一杯即可獲得...
再加碼送完整𝗣𝗘包裝𝟭包帶回家
（詳細活動說明 ➙ https://reurl.cc/yAVYpq ）
不管你是牛小排派還是香腸控
能完美收尾你的烤肉大餐ヽ(●´∀`●)ﾉ
這杯果香 × 清爽 × 纖維滿分
今年就讓 #COMEBUY 陪你「火」力全開！
#纖萃玩火 #纖萃玩火奶茶
#中秋節 #中秋烤肉配好茶
⧁ 詳細FIP100 纖維粉說明 ➙ https://www.funaicare.com/products/burner-
—
⧁ 全台門市據點 ➙ https://lihi1.com/9IiXS
bv15
⧁ 門市菜單 ➙ https://lihi1.com/xbX73
❝火❞了𝟮𝟬年的經典現萃', '2025-10-03 00:00:00', 44);
INSERT INTO public.marketing_content VALUES (145, 7, 'FB', '[Text] 纖萃玩火奶茶', '中秋節不只要烤肉
更要 #玩火
一家烤肉萬家香
一杯 #現萃 超沁爽.ᐟ.ᐟ
嚴選甘甜煎茶與清香烏龍
混拼百香果、芒果等熱帶水果風味烘製
果香四溢中透著淡淡蘭花香(๑´ڡ`๑)
𝟭𝟬/𝟭𝟱前至全台 𝗖𝗢𝗠𝗘𝗕𝗨𝗬 門市
門市現場
限量活動
免費加入 #船井生醫 FIP100 纖維粉𝟭包（升級纖萃
）
現場消費【玩火/玩火奶茶】任一杯即可獲得...
再加碼送完整𝗣𝗘包裝𝟭包帶回家
（詳細活動說明 ➙ https://reurl.cc/yAVYpq ）
不管你是牛小排派還是香腸控
能完美收尾你的烤肉大餐ヽ(●´∀`●)ﾉ
這杯果香 × 清爽 × 纖維滿分
今年就讓 #COMEBUY 陪你「火」力全開！
#纖萃玩火 #纖萃玩火奶茶
#中秋節 #中秋烤肉配好茶
⧁ 詳細FIP100 纖維粉說明 ➙ https://www.funaicare.com/products/burner-
—
⧁ 全台門市據點 ➙ https://lihi1.com/9IiXS
bv15
⧁ 門市菜單 ➙ https://lihi1.com/xbX73
❝火❞了𝟮𝟬年的經典現萃', '2025-10-03 00:00:00', 44);
INSERT INTO public.marketing_content VALUES (146, 7, 'FB', '[Text] 玩火奶茶', '中秋節不只要烤肉
更要 #玩火
一家烤肉萬家香
一杯 #現萃 超沁爽.ᐟ.ᐟ
嚴選甘甜煎茶與清香烏龍
混拼百香果、芒果等熱帶水果風味烘製
果香四溢中透著淡淡蘭花香(๑´ڡ`๑)
𝟭𝟬/𝟭𝟱前至全台 𝗖𝗢𝗠𝗘𝗕𝗨𝗬 門市
門市現場
限量活動
免費加入 #船井生醫 FIP100 纖維粉𝟭包（升級纖萃
）
現場消費【玩火/玩火奶茶】任一杯即可獲得...
再加碼送完整𝗣𝗘包裝𝟭包帶回家
（詳細活動說明 ➙ https://reurl.cc/yAVYpq ）
不管你是牛小排派還是香腸控
能完美收尾你的烤肉大餐ヽ(●´∀`●)ﾉ
這杯果香 × 清爽 × 纖維滿分
今年就讓 #COMEBUY 陪你「火」力全開！
#纖萃玩火 #纖萃玩火奶茶
#中秋節 #中秋烤肉配好茶
⧁ 詳細FIP100 纖維粉說明 ➙ https://www.funaicare.com/products/burner-
—
⧁ 全台門市據點 ➙ https://lihi1.com/9IiXS
bv15
⧁ 門市菜單 ➙ https://lihi1.com/xbX73
❝火❞了𝟮𝟬年的經典現萃', '2025-10-03 00:00:00', 44);
INSERT INTO public.marketing_content VALUES (147, 7, 'FB', '[Text] 玩火', '中秋節不只要烤肉
更要 #玩火
一家烤肉萬家香
一杯 #現萃 超沁爽.ᐟ.ᐟ
嚴選甘甜煎茶與清香烏龍
混拼百香果、芒果等熱帶水果風味烘製
果香四溢中透著淡淡蘭花香(๑´ڡ`๑)
𝟭𝟬/𝟭𝟱前至全台 𝗖𝗢𝗠𝗘𝗕𝗨𝗬 門市
門市現場
限量活動
免費加入 #船井生醫 FIP100 纖維粉𝟭包（升級纖萃
）
現場消費【玩火/玩火奶茶】任一杯即可獲得...
再加碼送完整𝗣𝗘包裝𝟭包帶回家
（詳細活動說明 ➙ https://reurl.cc/yAVYpq ）
不管你是牛小排派還是香腸控
能完美收尾你的烤肉大餐ヽ(●´∀`●)ﾉ
這杯果香 × 清爽 × 纖維滿分
今年就讓 #COMEBUY 陪你「火」力全開！
#纖萃玩火 #纖萃玩火奶茶
#中秋節 #中秋烤肉配好茶
⧁ 詳細FIP100 纖維粉說明 ➙ https://www.funaicare.com/products/burner-
—
⧁ 全台門市據點 ➙ https://lihi1.com/9IiXS
bv15
⧁ 門市菜單 ➙ https://lihi1.com/xbX73
❝火❞了𝟮𝟬年的經典現萃', '2025-10-03 00:00:00', 44);
INSERT INTO public.marketing_content VALUES (148, 7, 'FB', '[Text] 玩火奶茶', '沒時間飛
就喝這杯
外面找不到的獨特風味——
喝一口彷彿置身❝熱帶❞島嶼
#玩火 $𝟰𝟱(𝗟)
建議半糖以上最好喝
嚴選甘甜煎茶與產自春天高山上的清香烏龍茶
混拼百香果、芒果等熱帶水果風味烘製而成
#玩火奶茶 $𝟲𝟱(𝗟)
獨家黃金茶湯喝得到水果香氣與淡淡蘭花香！
嚴選甘甜煎茶與清香烏龍茶調製奶茶
帶有熱帶水果香氣與淡淡蘭花香
讓奶茶風味獨特又清爽不膩！
#無可取代的單杯現萃 就在 #COMEBUY
⧁ 加入官方𝗟𝗜𝗡𝗘點連結拿𝟵折券 ➙ https://comebuy.pse.is/74g326
—
⧁ 全台門市據點 ➙ https://lihi1.com/9IiXS
⧁ 門市菜單 ➙ https://lihi1.com/xbX73', '2025-09-19 00:00:00', 20);
INSERT INTO public.marketing_content VALUES (149, 7, 'FB', '[Text] 玩火', '沒時間飛
就喝這杯
外面找不到的獨特風味——
喝一口彷彿置身❝熱帶❞島嶼
#玩火 $𝟰𝟱(𝗟)
建議半糖以上最好喝
嚴選甘甜煎茶與產自春天高山上的清香烏龍茶
混拼百香果、芒果等熱帶水果風味烘製而成
#玩火奶茶 $𝟲𝟱(𝗟)
獨家黃金茶湯喝得到水果香氣與淡淡蘭花香！
嚴選甘甜煎茶與清香烏龍茶調製奶茶
帶有熱帶水果香氣與淡淡蘭花香
讓奶茶風味獨特又清爽不膩！
#無可取代的單杯現萃 就在 #COMEBUY
⧁ 加入官方𝗟𝗜𝗡𝗘點連結拿𝟵折券 ➙ https://comebuy.pse.is/74g326
—
⧁ 全台門市據點 ➙ https://lihi1.com/9IiXS
⧁ 門市菜單 ➙ https://lihi1.com/xbX73', '2025-09-19 00:00:00', 20);
INSERT INTO public.marketing_content VALUES (150, 8, 'FB', '[Text] 蘋果紅萱', '茶香遇上果香的溫柔調性，
是日常裡隨手可得的療癒感。
透亮的琥珀茶湯、伴隨自然柔和的蘋果香，
不論是在門市現泡、或是便利商店，
都希望你能在不同的生活片刻裡，
#龜記 #GUIJI #蘋果紅萱 #SevenEleven', '2025-11-21 00:00:00', 76);
INSERT INTO public.marketing_content VALUES (151, 8, 'FB', '[Text] 普洱咖啡奶茶', '普洱咖啡奶茶、普洱咖啡鮮乳
今日上市
呈現秋冬限定新品
碎銀普洱厚韻×義式濃醇咖啡
交織出溫暖成熟的獨特風味
↟.｡.:*･↟
季節限定不要錯過( ˶ˊᵕˋ)੭♡
本產品以 100% 純咖啡液製成，咖啡液中含有多酚類等活性成分，在儲存過程中
可能產生微量沉澱，屬於正常現象不影響品質，為天然純咖啡的特徵之一。
#龜記 #GUIJI #樂步 #lebrewlife #普洱 #咖啡 #普洱咖啡奶茶 #普洱咖啡鮮乳', '2025-11-01 00:00:00', 30);
INSERT INTO public.marketing_content VALUES (152, 8, 'FB', '[Text] 普洱', '普洱咖啡奶茶、普洱咖啡鮮乳
今日上市
呈現秋冬限定新品
碎銀普洱厚韻×義式濃醇咖啡
交織出溫暖成熟的獨特風味
↟.｡.:*･↟
季節限定不要錯過( ˶ˊᵕˋ)੭♡
本產品以 100% 純咖啡液製成，咖啡液中含有多酚類等活性成分，在儲存過程中
可能產生微量沉澱，屬於正常現象不影響品質，為天然純咖啡的特徵之一。
#龜記 #GUIJI #樂步 #lebrewlife #普洱 #咖啡 #普洱咖啡奶茶 #普洱咖啡鮮乳', '2025-11-01 00:00:00', 30);
INSERT INTO public.marketing_content VALUES (154, 8, 'FB', '[Text] 普洱咖啡奶茶', '龜記茗品×  樂步le brewlife
當茶遇上咖啡，碰撞出這個秋冬最獨特的香氣
龜記攜手不斷挑戰與創新的樂步 le brewlife，
雙品牌貫徹重視的「品質」與「生活感」，
打破手搖飲的傳統框架。
結合樂步的義式濃醇咖啡
融合順滑奶感，帶出濃郁溫暖的冬季限定特調。
驚喜又充滿細節與質感的風味，
完美展現兩個品牌的堅持與講究。
溫馨提醒：本產品以 100% 純咖啡液製成，咖啡液中含有多酚類等活性成分，在儲存
過程中可能產生微量沉澱，屬於正常現象不影響品質，為天然純咖啡的特徵之一。
#龜記 #GUIJI #樂步 #lebrewlife #普洱 #咖啡 #普洱咖啡奶茶 #普洱咖啡鮮乳', '2025-10-28 00:00:00', 99);
INSERT INTO public.marketing_content VALUES (157, 8, 'FB', '[Text] 蜂蜜花沫烏龍', '中秋烤肉聚會多
就是清爽的飲料該登場的時候
10/3 (五)~10/6（一）
中秋節限定活動，
購買兩杯蜂蜜花沫烏龍，就送一杯花沫烏龍
活動注意事項☆.｡.
限龜記門市現場+電話自取、龜記線上點自取享有
一般外送與外送平台皆不適用此活動
單筆消費可累贈（買2 送1、買4 送2，依此類推）
#龜記 #GUIJI #中秋 #烏龍 #花沫烏龍 #蜂蜜 #蜂蜜花沫烏龍', '2025-10-01 00:00:00', 53);
INSERT INTO public.marketing_content VALUES (158, 8, 'FB', '[Text] 花沫烏龍', '中秋烤肉聚會多
就是清爽的飲料該登場的時候
10/3 (五)~10/6（一）
中秋節限定活動，
購買兩杯蜂蜜花沫烏龍，就送一杯花沫烏龍
活動注意事項☆.｡.
限龜記門市現場+電話自取、龜記線上點自取享有
一般外送與外送平台皆不適用此活動
單筆消費可累贈（買2 送1、買4 送2，依此類推）
#龜記 #GUIJI #中秋 #烏龍 #花沫烏龍 #蜂蜜 #蜂蜜花沫烏龍', '2025-10-01 00:00:00', 53);
INSERT INTO public.marketing_content VALUES (160, 8, 'FB', '[Text] 三十三茶王', '荔枝茶王今日上市
-
荔枝果肉＋茶王茶湯＝完美組合
季節限定不要錯過٩꒰｡•◡•｡꒱۶
一起夏末的微風裡，品嚐酸甜滋味
⧁ 圖為示意參考，請以現場實物為準
-
#龜記 #GUIJI #新品 #荔枝 #三十三茶王 #荔枝茶王', '2025-09-15 00:00:00', 52);
INSERT INTO public.marketing_content VALUES (161, 1, 'FB', '[Text] 星桃樂翡翠', '召喚神龍的時刻到來！
龜記推出夏季聯名限定補氣飲品：『星桃樂翡翠』
加入功夫茶清爽芭樂果泥與龜記古早味楊桃蜜
層層果香堆疊，酸甜中帶茶香回甘
一口喝下如氣流直擊味蕾
還有聯名限定熱血周邊
從飲料杯身到保冷袋，從吸管塞到水壺提帶，
每一樣都值得粉絲們「集氣收藏」
活動期間｜𝟐𝟎𝟐𝟓/𝟎𝟕/𝟎𝟏 - 𝟐𝟎𝟐𝟓/𝟎𝟖/𝟑𝟏
限定活動第➊波：滿額贈禮
購買『星桃樂翡翠』 乙杯＋任一龜記飲品乙杯
即可獲得【七龍珠 大魔 ✕ 龜記 ✕ 功夫茶 保冷袋】乙個
數量有限，每人每筆限贈一次
電話預訂、外送及外送平台不適用
這個夏天，集氣開喝、召喚神龍，
＃龜記 #GUIJI #功夫茶 #聯名活動 #星桃樂翡翠 #楊桃 ＃芭樂 ＃期間限定企劃 #七
龍珠大魔', '2025-07-01 00:00:00', 120);
INSERT INTO public.marketing_content VALUES (162, 8, 'FB', '[Text] 紅柚翡翠', '龜蜜相揪過端午
限時優惠別錯過
- 
𝟓 / 𝟑𝟎 ( 五 ) ～ 𝟔 / 𝟏 ( 日 )
⋯紅柚翡翠 2 杯 100 元
⋯ 
粽子吃多了難免油膩，搭配清爽解膩的紅柚
絕對是最強儀式感組合
 
限時 3 天優惠，每單限購 3 組
 
⊱ 門市據點：https://lihi.cc/q8S7v 
⊱ 加入會員：https://lihi.cc/sDRhG 
⊱ 線上點餐：https://lihi.cc/xuJqa
- 
⧁ 龜記桃園機場店、臺大醫院店不參與此活動 
⧁ 龜記全台門市「現場購買」與「現場自取」適用
⧁ 不適用於龜記線上點餐/龜記線上點自取/Uber Eats/foodpanda/你訂 外送
平台 
⧁ 各行銷活動、折扣、優惠、龜蜜卡點數折抵不合併使用（環保杯折抵5 元不
在此限）  
#龜記 #GUIJI #紅柚翡翠 #端午節 #優惠 #手搖', '2025-05-29 00:00:00', 93);
INSERT INTO public.marketing_content VALUES (163, 8, 'FB', '[Text] 巨峰葡薈青', '巨峰葡薈青⋯𝟓/𝟏 上市.* ﾟ
魅力新品、炫風來襲！
限量販售
錯過不薈來
融合四季春青茶＋巨峰葡萄汁＋蘆薈 ˊ˗
⊱ 門市據點：https://lihi.cc/q8S7v
年度必試的細膩質感風味
⊱ 加入會員：https://lihi.cc/BKWoU
⊱ 線上點餐：https://lihi.cc/BKWoU
- 
⧁ 圖為示意參考，請以現場實物為準
⧁ 實際販售情況依各門店為主
完售不補貨
#龜記 #GUIJI #新品 #限量販售 #巨峰葡薈青', '2025-04-30 00:00:00', 63);
INSERT INTO public.marketing_content VALUES (164, 8, 'FB', '[Text] 三十三茶王', '冬天是想瘦身最有效的季節
（啪！
-
整理三支小清新飲品給大家⇣
想解膩又怕小肚肚累積脂肪 ˃ ˂ ？
花沫烏龍
很多人不知道～今年夏天超受歡迎的蜜桃烏龍
就是以花沫為茶底喔
味道很清
新、順口，有膩口食物需要搭配的話非常推薦！
蜂蜜綠茶／四季春
龜記使用蜜蜂工坊真蜂蜜
除了是天然糖漿外，蜂蜜還有潤喉、保護心血管等附加
價值，可以依照個人口味挑選茶底
三十三茶王
說到茶系列的熱銷單品
33 絕對榜上有名！老師傅獨家訂製的烘培法，口感回
甘、韻味豐富，重點是喝完不會心悸呀～（龜小編心中 TOP 1 
）
⊱ 門市據點：https://bit.ly/40G8McA
圖片奉上最新的熱量、咖啡因含量表呦
⊱ 加入會員：https://bit.ly/3O0e5vV
⊱ 線上點餐：https://bit.ly/3AwFvGB
#龜記 #GUIJI #推薦 #飲品推薦 #茶飲 #蜂蜜', '2024-12-03 00:00:00', 53);
INSERT INTO public.marketing_content VALUES (165, 8, 'FB', '[Text] 蜜桃烏龍', '冬天是想瘦身最有效的季節
（啪！
-
整理三支小清新飲品給大家⇣
想解膩又怕小肚肚累積脂肪 ˃ ˂ ？
花沫烏龍
很多人不知道～今年夏天超受歡迎的蜜桃烏龍
就是以花沫為茶底喔
味道很清
新、順口，有膩口食物需要搭配的話非常推薦！
蜂蜜綠茶／四季春
龜記使用蜜蜂工坊真蜂蜜
除了是天然糖漿外，蜂蜜還有潤喉、保護心血管等附加
價值，可以依照個人口味挑選茶底
三十三茶王
說到茶系列的熱銷單品
33 絕對榜上有名！老師傅獨家訂製的烘培法，口感回
甘、韻味豐富，重點是喝完不會心悸呀～（龜小編心中 TOP 1 
）
⊱ 門市據點：https://bit.ly/40G8McA
圖片奉上最新的熱量、咖啡因含量表呦
⊱ 加入會員：https://bit.ly/3O0e5vV
⊱ 線上點餐：https://bit.ly/3AwFvGB
#龜記 #GUIJI #推薦 #飲品推薦 #茶飲 #蜂蜜', '2024-12-03 00:00:00', 53);
INSERT INTO public.marketing_content VALUES (174, 8, 'FB', '[Text] 情人茶', '【時令鮮果首選～情人茶！】
阿嵐發現近期因應氣候關係，金桔常常請假～
為了嵐粉們的酸甜愛戀，真心推薦 #情人茶
鮮榨檸檬×獨家梅醬×茉莉綠茶 黃金組合，
酸得剛好，甜得迷人，清爽不膩，一喝就愛上
阿嵐私房喝法，今天就試試吧 (*´∀`)~
那種鮮酸甜蜜回甘的層次感，就是戀愛的味道！
甜度三分糖以上～戀愛心情百分百！
冰塊微冰或少冰～冰沁入魂包你愛！
偷偷宣傳當月詢問度破表的隱藏飲品 #多多青
養樂多×四季春青茶 酸甜控的你也一定會喜歡！
#50 嵐 #50 嵐中區 #好茶陪伴你的日常 #手搖 #飲料
#情人茶 #8 冰綠 #檸檬 #金桔 #梅醬', '2025-05-07 00:00:00', 92);
INSERT INTO public.marketing_content VALUES (166, 8, 'FB', '[Text] 蜂蜜綠茶', '冬天是想瘦身最有效的季節
（啪！
-
整理三支小清新飲品給大家⇣
想解膩又怕小肚肚累積脂肪 ˃ ˂ ？
花沫烏龍
很多人不知道～今年夏天超受歡迎的蜜桃烏龍
就是以花沫為茶底喔
味道很清
新、順口，有膩口食物需要搭配的話非常推薦！
蜂蜜綠茶／四季春
龜記使用蜜蜂工坊真蜂蜜
除了是天然糖漿外，蜂蜜還有潤喉、保護心血管等附加
價值，可以依照個人口味挑選茶底
三十三茶王
說到茶系列的熱銷單品
33 絕對榜上有名！老師傅獨家訂製的烘培法，口感回
甘、韻味豐富，重點是喝完不會心悸呀～（龜小編心中 TOP 1 
）
⊱ 門市據點：https://bit.ly/40G8McA
圖片奉上最新的熱量、咖啡因含量表呦
⊱ 加入會員：https://bit.ly/3O0e5vV
⊱ 線上點餐：https://bit.ly/3AwFvGB
#龜記 #GUIJI #推薦 #飲品推薦 #茶飲 #蜂蜜', '2024-12-03 00:00:00', 53);
INSERT INTO public.marketing_content VALUES (167, 8, 'FB', '[Text] 花沫烏龍', '冬天是想瘦身最有效的季節
（啪！
-
整理三支小清新飲品給大家⇣
想解膩又怕小肚肚累積脂肪 ˃ ˂ ？
花沫烏龍
很多人不知道～今年夏天超受歡迎的蜜桃烏龍
就是以花沫為茶底喔
味道很清
新、順口，有膩口食物需要搭配的話非常推薦！
蜂蜜綠茶／四季春
龜記使用蜜蜂工坊真蜂蜜
除了是天然糖漿外，蜂蜜還有潤喉、保護心血管等附加
價值，可以依照個人口味挑選茶底
三十三茶王
說到茶系列的熱銷單品
33 絕對榜上有名！老師傅獨家訂製的烘培法，口感回
甘、韻味豐富，重點是喝完不會心悸呀～（龜小編心中 TOP 1 
）
⊱ 門市據點：https://bit.ly/40G8McA
圖片奉上最新的熱量、咖啡因含量表呦
⊱ 加入會員：https://bit.ly/3O0e5vV
⊱ 線上點餐：https://bit.ly/3AwFvGB
#龜記 #GUIJI #推薦 #飲品推薦 #茶飲 #蜂蜜', '2024-12-03 00:00:00', 53);
INSERT INTO public.marketing_content VALUES (169, 8, 'FB', '[OCR] 花沫烏龍', '藍波萬啦！No.1 !!!!
-
昨晚真的創造了歷史性的一刻
謝謝你們締造「烏」與倫比的佳績
慶祝中華隊勇奪冠軍！
用細膩的醇粹與花香
感受「烏」與倫比的光榮
- 
⧁ 單筆限購一組
⧁ 限來店臨櫃現場購買，不適用各大外送平台、龜記線上點餐或電話自取
⧁ 活動品項加料需另付費，恕無法更換其他商品
⧁ 部分門店不參與：板橋環球店、新竹SOGO 店、南港中信店、汐止遠雄店、大
巨蛋店、臺大醫院店、台北車站店、統一時代店、南港CITYLINK 店
#龜記 #GUIJI #小人物大生活 #世界12 強棒球錦標賽 #中華隊 #冠軍 #台灣之
光
50 嵐', '2024-11-25 00:00:00', 200);
INSERT INTO public.marketing_content VALUES (170, 8, 'FB', '[Text] 梅綠', '「梅醬出任務，酸甜接力棒！
」 
#旺來系列臨時缺席，梅醬來HOLD 場囉 ^w^ 
門市QA 排行榜：50 嵐 #梅の綠，到底怎麼唸？
梅子綠？ 梅之綠？ 梅綠？ 梅什麼綠？ 那個綠？
 
不論怎麼唸，喝過就忍不住心心念念！
梅の綠：清爽系 
酸甜梅汁配上茉莉花香綠茶，先酸甜後茶香， 
多層風味口感，滿滿戀愛好滋味。
梅の紅：復古系 
香氣細緻的紅茶遇上梅汁，酸甜帶點回甘， 
一秒回到以前柑仔店配話梅的年代～
梅の青：淡雅系 
清香且淡雅的四季春青茶，加入酸甜梅汁， 
連員工都愛的私房搭配，喝得出層次又不會膩！
梅の烏：成熟系 
有焙火香氣的黃金烏龍搭配微酸解膩的梅汁， 
酸甜解膩、茶味相宜，大人味首選非他莫屬！
心動不如馬上行動，找到你的夏日專屬酸甜
 
#50 嵐 #50 嵐中區 #好茶陪伴你的日常 #手搖 #飲料
#梅の綠 #梅の紅 #梅の青 #梅の烏', '2025-05-28 00:00:00', 41);
INSERT INTO public.marketing_content VALUES (171, 8, 'FB', '[Text] 梅紅', '「梅醬出任務，酸甜接力棒！
」 
#旺來系列臨時缺席，梅醬來HOLD 場囉 ^w^ 
門市QA 排行榜：50 嵐 #梅の綠，到底怎麼唸？
梅子綠？ 梅之綠？ 梅綠？ 梅什麼綠？ 那個綠？
 
不論怎麼唸，喝過就忍不住心心念念！
梅の綠：清爽系 
酸甜梅汁配上茉莉花香綠茶，先酸甜後茶香， 
多層風味口感，滿滿戀愛好滋味。
梅の紅：復古系 
香氣細緻的紅茶遇上梅汁，酸甜帶點回甘， 
一秒回到以前柑仔店配話梅的年代～
梅の青：淡雅系 
清香且淡雅的四季春青茶，加入酸甜梅汁， 
連員工都愛的私房搭配，喝得出層次又不會膩！
梅の烏：成熟系 
有焙火香氣的黃金烏龍搭配微酸解膩的梅汁， 
酸甜解膩、茶味相宜，大人味首選非他莫屬！
心動不如馬上行動，找到你的夏日專屬酸甜
 
#50 嵐 #50 嵐中區 #好茶陪伴你的日常 #手搖 #飲料
#梅の綠 #梅の紅 #梅の青 #梅の烏', '2025-05-28 00:00:00', 41);
INSERT INTO public.marketing_content VALUES (172, 8, 'FB', '[Text] 梅青', '「梅醬出任務，酸甜接力棒！
」 
#旺來系列臨時缺席，梅醬來HOLD 場囉 ^w^ 
門市QA 排行榜：50 嵐 #梅の綠，到底怎麼唸？
梅子綠？ 梅之綠？ 梅綠？ 梅什麼綠？ 那個綠？
 
不論怎麼唸，喝過就忍不住心心念念！
梅の綠：清爽系 
酸甜梅汁配上茉莉花香綠茶，先酸甜後茶香， 
多層風味口感，滿滿戀愛好滋味。
梅の紅：復古系 
香氣細緻的紅茶遇上梅汁，酸甜帶點回甘， 
一秒回到以前柑仔店配話梅的年代～
梅の青：淡雅系 
清香且淡雅的四季春青茶，加入酸甜梅汁， 
連員工都愛的私房搭配，喝得出層次又不會膩！
梅の烏：成熟系 
有焙火香氣的黃金烏龍搭配微酸解膩的梅汁， 
酸甜解膩、茶味相宜，大人味首選非他莫屬！
心動不如馬上行動，找到你的夏日專屬酸甜
 
#50 嵐 #50 嵐中區 #好茶陪伴你的日常 #手搖 #飲料
#梅の綠 #梅の紅 #梅の青 #梅の烏', '2025-05-28 00:00:00', 41);
INSERT INTO public.marketing_content VALUES (173, 8, 'FB', '[Text] 多多青', '【時令鮮果首選～情人茶！】
阿嵐發現近期因應氣候關係，金桔常常請假～
為了嵐粉們的酸甜愛戀，真心推薦 #情人茶
鮮榨檸檬×獨家梅醬×茉莉綠茶 黃金組合，
酸得剛好，甜得迷人，清爽不膩，一喝就愛上
阿嵐私房喝法，今天就試試吧 (*´∀`)~
那種鮮酸甜蜜回甘的層次感，就是戀愛的味道！
甜度三分糖以上～戀愛心情百分百！
冰塊微冰或少冰～冰沁入魂包你愛！
偷偷宣傳當月詢問度破表的隱藏飲品 #多多青
養樂多×四季春青茶 酸甜控的你也一定會喜歡！
#50 嵐 #50 嵐中區 #好茶陪伴你的日常 #手搖 #飲料
#情人茶 #8 冰綠 #檸檬 #金桔 #梅醬', '2025-05-07 00:00:00', 92);
INSERT INTO public.marketing_content VALUES (175, 8, 'FB', '[Text] 金桔', '【時令鮮果首選～情人茶！】
阿嵐發現近期因應氣候關係，金桔常常請假～
為了嵐粉們的酸甜愛戀，真心推薦 #情人茶
鮮榨檸檬×獨家梅醬×茉莉綠茶 黃金組合，
酸得剛好，甜得迷人，清爽不膩，一喝就愛上
阿嵐私房喝法，今天就試試吧 (*´∀`)~
那種鮮酸甜蜜回甘的層次感，就是戀愛的味道！
甜度三分糖以上～戀愛心情百分百！
冰塊微冰或少冰～冰沁入魂包你愛！
偷偷宣傳當月詢問度破表的隱藏飲品 #多多青
養樂多×四季春青茶 酸甜控的你也一定會喜歡！
#50 嵐 #50 嵐中區 #好茶陪伴你的日常 #手搖 #飲料
#情人茶 #8 冰綠 #檸檬 #金桔 #梅醬', '2025-05-07 00:00:00', 92);
INSERT INTO public.marketing_content VALUES (176, 8, 'FB', '[Text] 荔枝烏龍', '號外號外 嵐冰友家族擴編中！
嵐氏冰淇淋三種口味～香草/芒果/荔枝
#你最喜歡哪個><
阿嵐大推 冰淇淋系列
①荔枝烏龍
使用細緻荔枝義式雪酪
搭配焙火香氣黃金烏龍
濃郁甘甜 層次再升級
②芒果青
濃郁芒果香甜鮮果雪酪
與四季春青茶完美交織
網友敲網 超經典回歸
③冰淇淋紅茶
綿密香濃的香草冰淇淋
加香醇陳韻阿薩姆紅茶
極品絕配 一口就上癮
#50 嵐 #中區50 嵐 #好茶陪伴你的日常 #手搖 #飲料 #新品 #嵐冰友 #荔枝烏龍 #芒
果青', '2024-08-05 00:00:00', 41);
INSERT INTO public.marketing_content VALUES (177, 8, 'FB', '[Text] 荔枝烏龍', '嵐粉們喝過了嗎？σ`∀´)σ
新品 #嵐冰友 強勢來襲！
必喝的3 個秘密！ #快來看看
全新飲品 #嵐冰友
1. 冰淇淋基底茶可更換～芒果青/綠/紅/烏，荔枝烏龍/綠/青/紅 #任你選
2. 配料自由加～珍珠、波霸、椰果或燕麥 #全免費
3. 杯身貼紙小秘密～荔枝、芒果、香草每個口味都不一樣
#荔枝烏龍 #芒果青 你喜歡哪個？
阿嵐兩個都超喜歡！
入口感受雪酪的沁心透涼，
再品嚐基底茶的質感回甘，
是夏天的一大救贖
#50 嵐 #中區50 嵐 #好茶陪伴你的日常 #手搖 #飲料
#新品 #嵐冰友 #荔枝烏龍 #芒果青
夏季主打 #綠茶專賣店 登場(*´∀`)~
 
十級嵐粉在哪裡～發現招牌的小秘密了嗎？', '2024-08-03 00:00:00', 50);
INSERT INTO public.marketing_content VALUES (178, 8, 'FB', '[Text] 芒果青', '嵐粉們喝過了嗎？σ`∀´)σ
新品 #嵐冰友 強勢來襲！
必喝的3 個秘密！ #快來看看
全新飲品 #嵐冰友
1. 冰淇淋基底茶可更換～芒果青/綠/紅/烏，荔枝烏龍/綠/青/紅 #任你選
2. 配料自由加～珍珠、波霸、椰果或燕麥 #全免費
3. 杯身貼紙小秘密～荔枝、芒果、香草每個口味都不一樣
#荔枝烏龍 #芒果青 你喜歡哪個？
阿嵐兩個都超喜歡！
入口感受雪酪的沁心透涼，
再品嚐基底茶的質感回甘，
是夏天的一大救贖
#50 嵐 #中區50 嵐 #好茶陪伴你的日常 #手搖 #飲料
#新品 #嵐冰友 #荔枝烏龍 #芒果青
夏季主打 #綠茶專賣店 登場(*´∀`)~
 
十級嵐粉在哪裡～發現招牌的小秘密了嗎？', '2024-08-03 00:00:00', 50);
INSERT INTO public.marketing_content VALUES (179, 8, 'FB', '[Text] 波霸綠茶拿鐵', '真正的 #招牌 #茉莉綠茶
 到來！ 
本次主視覺以超元氣的日漫風格 
強調我們滿滿的熱情與專業的搖茶技巧 
綠茶喝一下 清爽喝一夏！ 
三款經典 #綠茶系 飲品～ 必喝！
▷波霸綠茶拿鐵  
典雅奶香加綠茶 尾韻豐厚又清香 
Q 彈口感大滿足 微甜波霸一級棒 
▷冰淇淋綠茶
茉綠尬香草冰淇淋 清爽暢快透心涼 
多重層次超幸福 夏日必喝人氣款
▷多多綠茶 
經典多多配綠茶 微酸微甜超解膩 
炎熱夏日喝一口 完美療癒笑開懷
#50 嵐 #中區50 嵐 #好茶陪伴你的日常 #手搖 #飲料 #夏季主打 #綠茶專賣
店 #波霸綠茶拿鐵', '2024-05-31 00:00:00', 98);
INSERT INTO public.marketing_content VALUES (180, 8, 'FB', '[Text] 茉莉綠茶', '真正的 #招牌 #茉莉綠茶
 到來！ 
本次主視覺以超元氣的日漫風格 
強調我們滿滿的熱情與專業的搖茶技巧 
綠茶喝一下 清爽喝一夏！ 
三款經典 #綠茶系 飲品～ 必喝！
▷波霸綠茶拿鐵  
典雅奶香加綠茶 尾韻豐厚又清香 
Q 彈口感大滿足 微甜波霸一級棒 
▷冰淇淋綠茶
茉綠尬香草冰淇淋 清爽暢快透心涼 
多重層次超幸福 夏日必喝人氣款
▷多多綠茶 
經典多多配綠茶 微酸微甜超解膩 
炎熱夏日喝一口 完美療癒笑開懷
#50 嵐 #中區50 嵐 #好茶陪伴你的日常 #手搖 #飲料 #夏季主打 #綠茶專賣
店 #波霸綠茶拿鐵', '2024-05-31 00:00:00', 98);
INSERT INTO public.marketing_content VALUES (182, 8, 'FB', '[Text] 葡萄柚', '柚，是你～ ！你回來了♡ 
#葡萄柚系列 COME BACK！
少女紅橘色的經典葡萄柚
譜出如夏日戀歌般的滋味
屬於這個季節的限定飲品
是520 不可不喝酸甜滋味♡
季節限定
►鮮柚綠
►葡萄柚汁
►葡萄柚多多
#50 嵐 #50 嵐中區 #葡萄柚系列 #季節限定 #好茶陪伴你的日常', '2024-05-20 00:00:00', 95);
INSERT INTO public.marketing_content VALUES (183, 8, 'FB', '[Text] 珍波椰青茶', '珍波椰青茶升級小祕技d(`･∀･)b
什麼！竟然還可以這樣喝？！
布丁/燕麥/瑪奇朵 加上去超好喝♡ 
幸福指數大大大提升！
快相揪朋友一起來喝～
#50 嵐 #50 嵐中區 #好茶陪伴你的日常 #手搖 #飲料
#春季主打 #嵐a 青春 #珍波椰青茶', '2024-05-18 00:00:00', 62);
INSERT INTO public.marketing_content VALUES (184, 8, 'FB', '[Text] 珍波椰青茶', '「阿華田」120 歲生日快樂
嵐粉們喜歡在「阿華田」裡加哪些配料呢？
阿嵐最喜歡在裡面加滿滿的燕麥和珍珠了！！
喝完超有飽足感～營養滿點！
聽說阿華田歡慶抽獎活動誠意滿滿！
\\ 完整內容請參閱活動網站說明 //
https://www.ovaltine.com.tw/ovaltine_120celebration/
#50 嵐 #50 嵐中區 #好茶陪伴你的日常 #手搖 #飲料
#歡慶阿華田120 周年瑞士經典不斷電 #阿華田橘色潮食尚美味大探索
本月主打 #珍波椰青茶ヽ(●´∀`●)ﾉ', '2024-05-08 00:00:00', 157);
INSERT INTO public.marketing_content VALUES (186, 8, 'FB', '[Text] 珍珠奶青', '春秋戰國時代百家爭鳴，
現在奶茶也有四大門派擁護者
奶茶派、奶青派、烏龍奶派、奶綠派
各派系擁護者眾多～你屬於哪一派呢？
歡迎嵐粉們分享 #最愛奶類
阿嵐最近偏好 #珍珠奶青
獨特奶香味搭配四季青茶的滿口清香
再感受滑順的小珍珠，超級好喝～
#50 嵐 #50 嵐中區 #春季主打 #嵐a 青春 #珍珠奶青 #好茶陪伴你的日常 #手
搖 #飲料
Coco 都可', '2024-04-09 00:00:00', 71);
INSERT INTO public.marketing_content VALUES (185, 8, 'FB', '[Text-Rescued] 珍波椰青茶', '季主打嵐a 青春～必喝品項
#超值組合 滿滿配料珍波椰直接抵一餐
#清爽暢飲 經典四季春青茶清香又回甘
不說了！阿嵐要手刀去買一杯～
#50 嵐 #50 嵐中區 #好茶陪伴你的日常 #手搖 #飲料 #春季主打 #嵐a 青春 #
珍波椰青茶', '2024-05-06 00:00:00', 50);
INSERT INTO public.marketing_content VALUES (188, 8, 'FB', '[Text] 珍珠黑糖拿鐵', '嚼對很紓壓!手搖咖啡新登場!
珍珠黑糖拿鐵(14oz)是咖啡也是手搖!
Q 彈珍珠在黑糖拿鐵裡翻滾，越嚼越香越過癮!冷熱都超好喝
全台門市陸續開賣
先點再取 
maac.io/1HR0Q
#CoCo 都可 #珍珠黑糖拿鐵', '2026-02-06 00:00:00', 121);
INSERT INTO public.marketing_content VALUES (189, 8, 'FB', '[OCR] 雙果茶', '近期紅什麼
就紅這杯
明天來場莓好約會
美樂蒂最愛草莓
肯定要整組的啦～
𝟮/𝟰 
都可訂限定優惠
用美樂蒂聯名紙杯裝莓好雙果飲
夢幻可愛
莓好雙果茶(L)
憑券第二杯 #0 元
2 杯只要75 元
每個人有2 張券
點我領券 https://maac.io/1HR0Q
注意事項
𝟮/𝟰 𝟎𝟎:𝟎𝟎 開始領券，第2、4 杯可享折扣
限使用「CoCo 都可訂」線上點單，優惠不併用
限 𝟮/𝟰 當日使用，數量有限，售完為止
領券後，在確認明細時點選’’點我使用折價券’’帶入折扣
商場門市/部分門市不適用本活動
#好友日 #都可好友日 #CoCo 都可', '2026-02-03 00:00:00', 110);
INSERT INTO public.marketing_content VALUES (190, 8, 'FB', '[Text] 珍珠奶茶', '2 月開始的每一天都在開心倒數過年٩(๑> ₃ <)۶з
天天都是喝飲料的好日子 當然也要優惠喝 心情更加分
全區任選2 杯99
莓好雙果茶 草莓蔓越莓與紅茶的超幸福搭配
冬韻擂焙珍奶 天冷喝這杯最暖心
28 茉輕乳茶  21 歲輕檸烏龍 日焙珍珠奶茶
小湯圓奶茶(門市臨櫃限定)
全部任選、自由搭配！
全台門市臨櫃＆都可訂平台同步優惠
活動品項及販售依各門市公告為主
外送平台及部分門市不適用
#CoCo 都可 #2 杯99', '2026-02-03 00:00:00', 114);
INSERT INTO public.marketing_content VALUES (191, 8, 'FB', '[Text] 職人咖啡', '週二咖啡日又要到啦!
來杯西西里手搗檸檬美式
鮮檸檬現搗出檸檬特有的精油香氣
搭配職人金獎現磨咖啡
感受鮮果的清新 品味咖啡的香醇
隨心暢飲 加料更有勁
每週二限定
生椰職人拿鐵/職人美式/果咖美式 同價位買一送一
臨櫃 / 都可訂 同步開喝
準時開點
 https://maac.io/1HR0Q
活動品項
生椰職人拿鐵(14oz)（街邊) 原價$70
粉角生椰拿鐵(14oz)（街邊) 原價$80
職人美式(14oz)（街邊）原價$45
西西里手搗檸檬美式 /紅柚香檸美式(L)（街邊）原價$75
台灣柳丁美式( L) (街邊) 原價$85
活動優惠以原價計，優惠不併用
商場及部分門市不適用，詳情請洽現場公告
#CoCo 都可 #週二咖啡日 #買一送一 #職人咖啡 #CoCoCoffee', '2026-02-02 00:00:00', 33);
INSERT INTO public.marketing_content VALUES (193, 8, 'FB', '[OCR] 雙響炮', '全民喝百香雙響炮
第二杯10 元
𝟭/𝟮𝟴 
都可訂限定優惠
快找那個願意幫你出10 元的人 ~
百香雙響炮(L)
憑券第二杯 #10 元
2 杯80 元帶走
每個人有2 張券
點我領券 https://maac.io/1HR0Q
注意事項
𝟭/𝟮𝟴 𝟎𝟎:𝟎𝟎 開始領券，第2、4 杯可享折扣
限使用「CoCo 都可訂」線上點單，優惠不併用
限𝟭/𝟮𝟴 當日使用，數量有限，售完為止
領券後，在確認明細時點選’’點我使用折價券’’帶入折扣
商場門市/部分門市不適用本活動
#好友日 #都可好友日 #CoCo 都可', '2026-01-27 00:00:00', 185);
INSERT INTO public.marketing_content VALUES (194, 8, 'FB', '[OCR] 百香', '全民喝百香雙響炮
第二杯10 元
𝟭/𝟮𝟴 
都可訂限定優惠
快找那個願意幫你出10 元的人 ~
百香雙響炮(L)
憑券第二杯 #10 元
2 杯80 元帶走
每個人有2 張券
點我領券 https://maac.io/1HR0Q
注意事項
𝟭/𝟮𝟴 𝟎𝟎:𝟎𝟎 開始領券，第2、4 杯可享折扣
限使用「CoCo 都可訂」線上點單，優惠不併用
限𝟭/𝟮𝟴 當日使用，數量有限，售完為止
領券後，在確認明細時點選’’點我使用折價券’’帶入折扣
商場門市/部分門市不適用本活動
#好友日 #都可好友日 #CoCo 都可', '2026-01-27 00:00:00', 185);
INSERT INTO public.marketing_content VALUES (195, 8, 'FB', '[Text] 莓好雙果茶', 'My Melody 莓好限定!莓好雙果系列甜美開喝！
酸甜草莓 ✕ 鮮香蔓越莓
在紅茶與鮮奶的襯托下，開啟最療癒的莓果時刻～
不只「好喝」，更「喝得安心」！
採用尖端 HPP 冷高壓滅菌技術 製作
保留草莓與蔓越莓的營養、果香 ꙳⸌♡⸍꙳
同時以超高壓力鎖住新鮮、遠離細菌
讓每一口都是滿滿自然甜味與健康能量
莓好雙果茶
融合草莓、蔓越莓與紅茶香氣～
酸甜交織、沁涼爽口，超適合下午來一杯
莓好雙果牛乳
莓果的酸甜搭上濃醇鮮奶
柔滑香濃、無咖啡因，大人小孩都能喝！
酸甜莓果 × 健康科技
一起來喝下雙倍「莓」好的幸福！
1/26 開始購買任一大杯飲品還有美樂蒂聯名紙杯喔
#CoCo 都可 #莓好雙果系列 #莓好雙果茶 #莓好雙果牛乳 #HPP 冷高壓滅菌', '2026-01-24 00:00:00', 233);
INSERT INTO public.marketing_content VALUES (196, 8, 'FB', '[Text] 莓好雙果', 'My Melody 莓好限定!莓好雙果系列甜美開喝！
酸甜草莓 ✕ 鮮香蔓越莓
在紅茶與鮮奶的襯托下，開啟最療癒的莓果時刻～
不只「好喝」，更「喝得安心」！
採用尖端 HPP 冷高壓滅菌技術 製作
保留草莓與蔓越莓的營養、果香 ꙳⸌♡⸍꙳
同時以超高壓力鎖住新鮮、遠離細菌
讓每一口都是滿滿自然甜味與健康能量
莓好雙果茶
融合草莓、蔓越莓與紅茶香氣～
酸甜交織、沁涼爽口，超適合下午來一杯
莓好雙果牛乳
莓果的酸甜搭上濃醇鮮奶
柔滑香濃、無咖啡因，大人小孩都能喝！
酸甜莓果 × 健康科技
一起來喝下雙倍「莓」好的幸福！
1/26 開始購買任一大杯飲品還有美樂蒂聯名紙杯喔
#CoCo 都可 #莓好雙果系列 #莓好雙果茶 #莓好雙果牛乳 #HPP 冷高壓滅菌', '2026-01-24 00:00:00', 233);
INSERT INTO public.marketing_content VALUES (197, 8, 'FB', '[Deep-Mined] 冬韻擂焙珍奶', '不得不愛
天氣冷喝暖暖! 暖暖喝!
#冬日奶茶天花板 開喝
嚴選14 種營養穀物
𝟭/𝟮𝟭 
都可訂限定優惠
手工煮製日式鹿兒島焙奶茶
冬韻擂焙珍奶(L)
憑券第二杯 #0 元
2 杯70 元帶走
每個人有2 張券
點我領券 https://maac.io/1HR0Q
注意事項
𝟭/𝟮𝟭 𝟎𝟎:𝟎𝟎 開始領券，第2、4 杯可享折扣
限使用「CoCo 都可訂」線上點單，優惠不併用
限𝟭/𝟮𝟭當日使用，數量有限，售完為止
領券後，在確認明細時點選’’點我使用折價券’’帶入折扣
商場門市/部分門市不適用本活動
#好友日 #都可好友日 #CoCo 都可', '2026-01-20 00:00:00', 222);
INSERT INTO public.marketing_content VALUES (198, 8, 'FB', '[Text] 珍珠奶茶', '各位觀眾
周末不管你有什麼會
都不能忘了2 杯$99 優惠!
體感冷就喝冬韻擂焙珍奶溫的三分糖
體感熱就喝莓好雙果茶少冰半糖
是不是妥妥的周末戰備!!
2 杯99 必喝無悔
28 茉輕乳茶  日焙珍珠奶茶  21 歲輕檸烏龍  冬韻擂焙珍奶  莓好雙果茶
小湯圓奶茶（臨櫃限定）  任選自由配！
門市臨櫃＆都可訂平台同步優惠
活動品項及販售依各門市公告為主
非全門市活動，，請以門市現場公告為準
#CoCo 都可 #2 杯99 #尾牙 #周末', '2026-01-16 00:00:00', 182);
INSERT INTO public.marketing_content VALUES (199, 1, 'IG', '[Text] 黑霸烏龍奶', '＼迎接假期！／
限時 #買一送一 先開喝！
來杯「黑霸烏龍奶」提前進入𝐇𝐨𝐥𝐢𝐝𝐚𝐲 𝐌𝐨𝐝𝐞
年假即將來臨，忙碌中還是要懂得享受 ·͜·♡
給準備放假的你，一個剛好的理由
#限時優惠 𝟎𝟐.𝟎𝟗 - 𝟎𝟐.𝟏𝟑 ─── .✦.
聯名限定．#黑霸烏龍奶 限時買❶送❶！
烏龍奶茶暗藏火力，遇上波霸的甜蜜攻擊
猶如出拳前的蓄勢待發！一口引爆烈焰
假期來臨！就讓「黑霸烏龍奶」來開場！
．活動限來店；每人限購2 組。
．本優惠不得與其他優惠併用。
#電影 #功夫 #九把刀作品
#0213 全台盛大上映', '2026-02-02 00:00:00', 80);
INSERT INTO public.marketing_content VALUES (200, 1, 'IG', '[Text] 黑霸烏龍奶', '電影的狠勁，都在 #黑霸烏龍奶 內！
不張揚，卻很有立場 ────────.✦.
九把刀執導並改編自同名小說
最擅長的熱血情感與逆襲快感
揭開九把刀宇宙的華麗篇章 .ılı.lı.ıl
把故事裝進手裡的「黑霸烏龍奶」
燃起內心無限可能，登頂功夫之巔！
一馬當先、霸氣開春！𝟎𝟐.𝟏𝟑戲院見
#電影 #功夫 #九把刀作品
#0213 全台盛大上映
黑糖波霸秘煉𝟏𝟐𝟎分，層層吸收黑糖精華', '2026-01-21 00:00:00', 40);
INSERT INTO public.marketing_content VALUES (201, 1, 'IG', '[Text] 黑霸烏龍奶', '與烏龍奶茶正面交鋒！沉穩茶香隨奶香釋放~
焙香、奶香暗藏火力，濃烈不失細膩
九把刀最強奇幻動作電影《功夫》
配上用真功夫製作的「黑霸烏龍奶」
聯手來場充滿力量的手搖體驗！
𝟎𝟐.𝟏𝟑 - 𝟎𝟑.𝟎𝟖 ─.✦.───
享「黑霸烏龍奶」#現折10 元優惠 ◡̎
憑當月份《功夫》電影票根
𝟎𝟐.𝟎𝟗 - 𝟎𝟐.𝟏𝟑 ─.✦.───
購買「黑霸烏龍奶」即享 #買1 送1
．每張票根限折乙杯。買一送一限購2 組。
．活動限來店；不得與其他優惠併用。
#電影 #功夫 #九把刀作品
#0213 全台盛大上映
即將迎來新年第一天，好心情一起打包◡̎', '2026-01-16 00:00:00', 19);
INSERT INTO public.marketing_content VALUES (202, 1, 'IG', '[Text] 蜜桃胭脂紅茶', '𝟐𝟎𝟐𝟔.𝟎𝟏.𝟎𝟏 #元旦限定 —————
▹ ▸ 蜜桃胭脂紅茶〔買一送一〕.ᐟᐟ.
#蜜桃胭脂紅茶
𝐏𝐞𝐚𝐜𝐡 𝐁𝐥𝐚𝐜𝐤 𝐓𝐞𝐚
桃香與茶香完美並存的單品紅茶
淡淡香氣有如剛摘下的蜜桃，沿途留香
新的一年，一起舉杯歡慶
感受到茶香細膩，輕盈清爽～
．每人限購乙組。活動限來店
．優惠不得合併使用。數量有限售完為止
#元旦 #新年快樂 #HappyNewYear
＼聖誕節快樂！／𝐌𝐞𝐫𝐫𝐲 𝐂𝐡𝐫𝐢𝐬𝐭𝐦𝐚𝐬     
 
濃濃的聖誕氛圍，剛剛好就很溫暖！ 
用一杯柔順的拿鐵，還有一杯清爽的茶， 
將忙碌拋在腦後，把美好留給自己吧◡̎', '2025-12-31 00:00:00', 13);
INSERT INTO public.marketing_content VALUES (205, 1, 'IG', '[Text] 烏龍觀音拿鐵', '幫你找到最適合今日心情的組合 .ᐟᐟ.
𝟏𝟏.𝟎𝟏-𝟎𝟏.𝟏𝟏｜雙饗茶會  
𝐏𝐚𝐢𝐫 + 𝐒𝐡𝐚𝐫𝐞，各選一杯，享優惠價
𝐏𝐚𝐢𝐫 ｜原境茶選
隱山烏龍 ✧ 功夫茶王 
 𝐒𝐡𝐚𝐫𝐞｜醇厚拿鐵
岩葉紅茶拿鐵 ꕤ 烏龍觀音拿鐵 ꕤ 蜜桃胭脂拿鐵 
 
꒰ 隱山烏龍 × 烏龍觀音拿鐵 ꒱ 
最適合想要獨處、沉澱心情的你
沉穩安定的茶香，忙碌後優雅慢下腳步
最適合缺乏活力、急需朋友慰藉的你 
與好友暢聊、釋放壞情緒的最佳能量飲品
#KUNGFUTEA 功夫茶 #功夫茶 
#隱山烏龍 #雙饗茶會 #優惠活動', '2025-11-06 00:00:00', 5);
INSERT INTO public.marketing_content VALUES (206, 1, 'IG', '[Text] 岩葉紅茶拿鐵', '幫你找到最適合今日心情的組合 .ᐟᐟ.
𝟏𝟏.𝟎𝟏-𝟎𝟏.𝟏𝟏｜雙饗茶會  
𝐏𝐚𝐢𝐫 + 𝐒𝐡𝐚𝐫𝐞，各選一杯，享優惠價
𝐏𝐚𝐢𝐫 ｜原境茶選
隱山烏龍 ✧ 功夫茶王 
 𝐒𝐡𝐚𝐫𝐞｜醇厚拿鐵
岩葉紅茶拿鐵 ꕤ 烏龍觀音拿鐵 ꕤ 蜜桃胭脂拿鐵 
 
꒰ 隱山烏龍 × 烏龍觀音拿鐵 ꒱ 
最適合想要獨處、沉澱心情的你
沉穩安定的茶香，忙碌後優雅慢下腳步
最適合缺乏活力、急需朋友慰藉的你 
與好友暢聊、釋放壞情緒的最佳能量飲品
#KUNGFUTEA 功夫茶 #功夫茶 
#隱山烏龍 #雙饗茶會 #優惠活動', '2025-11-06 00:00:00', 5);
INSERT INTO public.marketing_content VALUES (207, 1, 'IG', '[Text] 蜜桃胭脂拿鐵', '幫你找到最適合今日心情的組合 .ᐟᐟ.
𝟏𝟏.𝟎𝟏-𝟎𝟏.𝟏𝟏｜雙饗茶會  
𝐏𝐚𝐢𝐫 + 𝐒𝐡𝐚𝐫𝐞，各選一杯，享優惠價
𝐏𝐚𝐢𝐫 ｜原境茶選
隱山烏龍 ✧ 功夫茶王 
 𝐒𝐡𝐚𝐫𝐞｜醇厚拿鐵
岩葉紅茶拿鐵 ꕤ 烏龍觀音拿鐵 ꕤ 蜜桃胭脂拿鐵 
 
꒰ 隱山烏龍 × 烏龍觀音拿鐵 ꒱ 
最適合想要獨處、沉澱心情的你
沉穩安定的茶香，忙碌後優雅慢下腳步
最適合缺乏活力、急需朋友慰藉的你 
與好友暢聊、釋放壞情緒的最佳能量飲品
#KUNGFUTEA 功夫茶 #功夫茶 
#隱山烏龍 #雙饗茶會 #優惠活動', '2025-11-06 00:00:00', 5);
INSERT INTO public.marketing_content VALUES (208, 1, 'IG', '[Text] 功夫茶王', '幫你找到最適合今日心情的組合 .ᐟᐟ.
𝟏𝟏.𝟎𝟏-𝟎𝟏.𝟏𝟏｜雙饗茶會  
𝐏𝐚𝐢𝐫 + 𝐒𝐡𝐚𝐫𝐞，各選一杯，享優惠價
𝐏𝐚𝐢𝐫 ｜原境茶選
隱山烏龍 ✧ 功夫茶王 
 𝐒𝐡𝐚𝐫𝐞｜醇厚拿鐵
岩葉紅茶拿鐵 ꕤ 烏龍觀音拿鐵 ꕤ 蜜桃胭脂拿鐵 
 
꒰ 隱山烏龍 × 烏龍觀音拿鐵 ꒱ 
最適合想要獨處、沉澱心情的你
沉穩安定的茶香，忙碌後優雅慢下腳步
最適合缺乏活力、急需朋友慰藉的你 
與好友暢聊、釋放壞情緒的最佳能量飲品
#KUNGFUTEA 功夫茶 #功夫茶 
#隱山烏龍 #雙饗茶會 #優惠活動', '2025-11-06 00:00:00', 5);
INSERT INTO public.marketing_content VALUES (203, 1, 'IG', '[需人工確認] 圖片限定或無飲品', '#雙饗茶會 ❭❭❭  𝐓𝐄𝐀+𝐋𝐀𝐓𝐓𝐄 享組合優惠  
讓冬天過得更溫暖，以茶相聚，歡慶聖誕！
．活動不得與其他優惠合併使用 
．功夫茶保有活動更改、終止及解釋權利
#KUNGFUTEA 功夫茶 #功夫茶 ＃雙饗茶會', '2025-12-24 00:00:00', 8);
INSERT INTO public.marketing_content VALUES (209, 1, 'IG', '[Text] 隱山烏龍', '幫你找到最適合今日心情的組合 .ᐟᐟ.
𝟏𝟏.𝟎𝟏-𝟎𝟏.𝟏𝟏｜雙饗茶會  
𝐏𝐚𝐢𝐫 + 𝐒𝐡𝐚𝐫𝐞，各選一杯，享優惠價
𝐏𝐚𝐢𝐫 ｜原境茶選
隱山烏龍 ✧ 功夫茶王 
 𝐒𝐡𝐚𝐫𝐞｜醇厚拿鐵
岩葉紅茶拿鐵 ꕤ 烏龍觀音拿鐵 ꕤ 蜜桃胭脂拿鐵 
 
꒰ 隱山烏龍 × 烏龍觀音拿鐵 ꒱ 
最適合想要獨處、沉澱心情的你
沉穩安定的茶香，忙碌後優雅慢下腳步
最適合缺乏活力、急需朋友慰藉的你 
與好友暢聊、釋放壞情緒的最佳能量飲品
#KUNGFUTEA 功夫茶 #功夫茶 
#隱山烏龍 #雙饗茶會 #優惠活動', '2025-11-06 00:00:00', 5);
INSERT INTO public.marketing_content VALUES (210, 1, 'IG', '[Text] 38奶霸', '𝑻𝒐𝒑 𝑷𝒊𝒄𝒌 ✧ 38 奶霸 ✧ 超有料
萬聖節就喝這杯，不喝就搗蛋 .ᐟ.ᐟ
最黑的夜空揉成焦糖圓球 𖣐 
點綴上晶瑩寶石、黑夜濃霧
喝一口，幸福感爆棚，超滿足 ෆ
𝓗𝓐𝓟𝓟𝓨  𝓗𝓐𝓛𝓛𝓞𝓦𝓔𝓔𝓝
꒦꒷꒦꒷꒦꒷꒦꒷꒦꒷꒦꒷꒦꒷꒦꒷꒦꒷꒦꒷꒦꒷꒦꒷
#KUNGFUTEA 功夫茶 #功夫茶 #萬聖節', '2025-10-30 00:00:00', 10);
INSERT INTO public.marketing_content VALUES (211, 1, 'IG', '[Text] 隱山烏龍', '連假出遊，熱到快融化
真想來杯沁涼解渴的飲料 .ᐟ ᐟ.
꒰ 隱山烏龍 ꒱ 𝓷𝓮𝔀
茶香四溢，順口不苦澀
冰涼清爽，一掃身體的燥熱 ❆
無糖限定，感受最純粹的茶香♡
隱山烏龍・沁涼上市
是你連假出遊的最佳夥伴 ✧˚.
#隱山烏龍 #無糖茶 #國慶日', '2025-10-09 00:00:00', 9);
INSERT INTO public.marketing_content VALUES (212, 1, 'IG', '[Text] 隱山烏龍', '＼買一送一 ✫ 中秋連假限定 .ᐟ.ᐟ／
中秋節快樂𓂃⟡.·𓂃團圓烤肉吃不停 .ᐟ.ᐟ 
吃美食別忘了來一杯清爽解膩的飲料
隱山烏龍 🥃 新上市 જ⁀➴♡
①無糖限定 ✧ 喝再多也不怕胖
②順口茶湯 ✧ 快速解膩又不苦澀
幽深茶韻，職人手作，保留純粹茶香
𝟭𝟬.𝟬𝟰～𝟭𝟬.𝟬𝟲  隱山烏龍 #買一送一
吃再多烤肉都不膩！ෆ˙ᵕ˙ෆ
隱山烏龍 𝐍𝐄𝐖  輕盈解渴好搭檔 ₊⊹
※單筆消費限購兩組，每日限量，售完為止
※活動限來店自取
#隱山烏龍 #無糖 #中秋節快樂', '2025-10-03 00:00:00', 7);
INSERT INTO public.marketing_content VALUES (213, 2, 'IG', '[Text] 柳橙翡翠青', '#柳橙翡翠青 #經典回歸
剛剛好，你也還在
剛剛好，我也沒變
我們一起等到——
柳橙最剛好的時刻
這不是提早，也不是將就
而是等到果香最飽滿、酸甜最平衡
才願意端出的那一杯
這份陽光下的鮮甜美好
是去年度季節限定 No.1 的回憶
也是今年，終於等到的完美風味
我們再一次，回味重遊
柳橙翡翠青
1/26（一）全台經典回歸上市
嚴選鮮甜柳橙
搭配沁涼爽口的翡翠青茶
在柳橙最佳成熟時刻榨取
完整保留果香層次與清爽茶韻
年度好評敲碗回歸 !
｜大茗官方網站｜https://www.damingtea.com.tw
#大茗本位製茶堂 #柳橙翡翠青經典回歸', '2026-01-23 00:00:00', 573);
INSERT INTO public.marketing_content VALUES (214, 2, 'IG', '[Text] 懷舊經典奶茶', '#
  
#啟動年末微醺儀式 #莓醉雙奏章幸福聯乘
#勤美誠品綠園道限定 #聯名酒精飲特調
草莓飲品喝不夠
要再來點Chill 的嗎
我們從上波爵士音樂節的茶酒特調再次昇華
這波莓醉的幸福耶誕禮，明日起限定開喝
DAMING X Teapsy 丨 莓醉雙奏章
12/24(三) - 12/31(三) 限時8 天
⭓ 莓醉玉露 / 4% vol. / ★★★★★ 
(玉露奶青/草莓果釀/原萃青茶茶酒)
細緻奶青交織甜蜜草莓果香
滿滿草莓奶酒的微醺清甜
⭓ 莓醺奶紅 / 4% vol. / ★★★★★
(懷舊經典奶茶/草莓果釀/原萃紅茶茶酒)
濃郁的古早味奶紅配上草莓甜酸
溫潤迷人～莓醉又回味的Chill
/ / / 
* 未滿18 歲禁止飲酒
* 喝酒不開車，安全有保障
大茗本位製茶堂丨勤美誠品綠園道店
地址：台中市西區公益路68 號B1
電話：04-2321-0823
｜大茗官方網站｜https://www.damingtea.com.tw
莓醉雙奏章 丨 限定聯名酒精飲特調
@daming_tea @teapsyco_official', '2025-12-23 00:00:00', 205);
INSERT INTO public.marketing_content VALUES (215, 2, 'IG', '[Text] 玉露奶青', '#
  
#啟動年末微醺儀式 #莓醉雙奏章幸福聯乘
#勤美誠品綠園道限定 #聯名酒精飲特調
草莓飲品喝不夠
要再來點Chill 的嗎
我們從上波爵士音樂節的茶酒特調再次昇華
這波莓醉的幸福耶誕禮，明日起限定開喝
DAMING X Teapsy 丨 莓醉雙奏章
12/24(三) - 12/31(三) 限時8 天
⭓ 莓醉玉露 / 4% vol. / ★★★★★ 
(玉露奶青/草莓果釀/原萃青茶茶酒)
細緻奶青交織甜蜜草莓果香
滿滿草莓奶酒的微醺清甜
⭓ 莓醺奶紅 / 4% vol. / ★★★★★
(懷舊經典奶茶/草莓果釀/原萃紅茶茶酒)
濃郁的古早味奶紅配上草莓甜酸
溫潤迷人～莓醉又回味的Chill
/ / / 
* 未滿18 歲禁止飲酒
* 喝酒不開車，安全有保障
大茗本位製茶堂丨勤美誠品綠園道店
地址：台中市西區公益路68 號B1
電話：04-2321-0823
｜大茗官方網站｜https://www.damingtea.com.tw
莓醉雙奏章 丨 限定聯名酒精飲特調
@daming_tea @teapsyco_official', '2025-12-23 00:00:00', 205);
INSERT INTO public.marketing_content VALUES (217, 2, 'IG', '[OCR] 翡翠莓香', '#莓光甜室
Sweet Berry Moments
12/10(三)全台新品上市
讓每一天，
都有一點柔軟的甜。
融進口裡，收在心裡
｜大茗官方網站｜https://www.damingtea.com.tw
#草莓要來了
 #就是下周
#大茗本位製茶堂', '2025-12-02 00:00:00', 164);
INSERT INTO public.marketing_content VALUES (218, 2, 'IG', '[Text] 芒果青', '#芒果青 #青熟感限定茗作
熱烈加開！熱烈加開！
這杯獻給你，用芒果的酸甜填滿日常的空隙。
喝過才知道，大茗的味道真的上癮
在地芒果細火慢熬出的天然熟果香，
喝過的都驚嘆
 限量開賣再擴大開催～～
手工芒果醬 ✕ 翡翠青茶
11/14(五)起 中區、彰化、嘉義、斗六門市限量開喝！
｜大茗官方網站｜https://www.damingtea.com.tw/
#芒果青 #指定區域門市開喝
#大茗本位製茶堂', '2025-11-11 00:00:00', 52);
INSERT INTO public.marketing_content VALUES (219, 2, 'IG', '[Text] 芫荽酪梨奶蓋', '這個萬聖節，不搞怪也能很有戲
芫荽與酪梨攜手施展綠色魔法，三款奶蓋茶限時登場，
每一口都是萬聖夜的神秘咒語——清香、焙香、還有一點暗夜的驚喜
萬聖限定・芫荽酪梨奶蓋系列
2025/10/31-11/2
綠茶｜清新登場
清爽綠茶遇上芫荽酪梨奶蓋，淡雅香氣裡帶點意外驚喜
蕎麥｜焙香現身
焙香蕎麥融合草本奶蓋的柔滑，香氣溫潤，喝起來很舒服
烏龍｜暗夜限定
炭焙茶香交織酪梨奶香，層次豐富又細膩
每日限量供應
限現場購買
可先來電門市詢問
｜大茗官方網站｜https://www.damingtea.com.tw/
#大茗新品上市 #萬聖節限定 #芫荽酪梨奶蓋
#大茗本位製茶堂', '2025-10-28 00:00:00', 1651);
INSERT INTO public.marketing_content VALUES (231, 3, 'IG', '[Text] 緋烏龍鮮奶', '身處湧動時代 復古卻成了新語言
偕茶師重新對焦
#緋烏龍系列 再次加載登場！
全新風味升級：首次加入緋烏龍、馥莓緋烏龍
在新與舊之間
注入靈魂播放昔日回憶
緋紅序曲已揭幕
邀你舉杯，共襄年末盛宴
> .collection - "𝓡ed Oolong Tea 緋烏龍系列"
.
[0]  緋烏龍........................M 35｜L 40
[1]  馥莓緋烏龍................M 50｜L 60
[2]  緋烏龍奶茶................M 50｜L 55
[3]  緋烏龍鮮奶................M 60｜L 70
[4]  芝士奶蓋緋烏龍........M 55｜L 65
STATUS: 全門市販售中
𝑪𝒉𝒂𝒑𝒕𝒆𝒓 𝟎𝟒｜芝士奶蓋緋烏龍  Cheese Milk Foam 𝓡ed Oolong Tea', '2025-12-17 00:00:00', 98);
INSERT INTO public.marketing_content VALUES (220, 2, 'IG', '[Text] 芒果青', '#芒果青 #青熟感限定茗作
#北區南區第二波指定門市開喝
熱烈加開！熱烈加開！
這杯獻給你，也許你心裡的洞能被填滿一點？
大茗你就愛了吧！哪次不愛
在地芒果細火慢熬出的天然熟果香
喝過的都驚嘆 第二波指定店限量販售開催～～
手工芒果醬 ✕ 翡翠青茶
10/23(四)起第二波區域門市限量開喝
指定販售門市
北區指定門市
台北公館 / 台北內湖 / 桃園藝文
新竹城隍 / 新竹金山 / 竹南博愛
中區指定門市
勤美模範 / 台中高工 / 台中水湳
逢甲西屯 / 逢甲福星 / 漢口青海
* 11/14(五)起中區全門市供應
南區指定門市
台南中正 / 台南中華
高雄至聖 / 高雄自強 / 高雄裕誠
高雄文化 / 高雄楠梓 / 高雄岡山
｜大茗官方網站｜https://www.damingtea.com.tw/
#芒果青 #第二波指定區域門市開喝
#大茗本位製茶堂', '2025-10-22 00:00:00', 63);
INSERT INTO public.marketing_content VALUES (222, 2, 'IG', '[Text] 珈琲粉粿蕎麥奶', 'DAMING | Happy Moon Festival
中秋烤肉聚餐，解膩神隊友必不可少
#玉露青茶 —— 清爽解膩、涼意滿滿
#熟成油切蕎麥 —— 助你油膩OUT、暢快加倍
想換換口味也可以點
#珈琲粉粿蕎麥奶 —— 一口濃郁烘焙香氣，一口滑順溫柔的老派浪漫。
#珍珠粉粿牛奶 ——珍珠＋粉粿＝雙重咬感爆擊！雙料大滿足
聚會來上一杯，中秋就更圓滿。
㊗️大家中秋節快樂
｜大茗官方網站｜https://www.damingtea.com.tw/
#大茗本位製茶堂 #中秋節快樂', '2025-10-05 00:00:00', 47);
INSERT INTO public.marketing_content VALUES (223, 2, 'IG', '[Text] 熟成油切蕎麥', 'DAMING | Happy Moon Festival
中秋烤肉聚餐，解膩神隊友必不可少
#玉露青茶 —— 清爽解膩、涼意滿滿
#熟成油切蕎麥 —— 助你油膩OUT、暢快加倍
想換換口味也可以點
#珈琲粉粿蕎麥奶 —— 一口濃郁烘焙香氣，一口滑順溫柔的老派浪漫。
#珍珠粉粿牛奶 ——珍珠＋粉粿＝雙重咬感爆擊！雙料大滿足
聚會來上一杯，中秋就更圓滿。
㊗️大家中秋節快樂
｜大茗官方網站｜https://www.damingtea.com.tw/
#大茗本位製茶堂 #中秋節快樂', '2025-10-05 00:00:00', 47);
INSERT INTO public.marketing_content VALUES (224, 2, 'IG', '[Text] 珍珠粉粿牛奶', 'DAMING | Happy Moon Festival
中秋烤肉聚餐，解膩神隊友必不可少
#玉露青茶 —— 清爽解膩、涼意滿滿
#熟成油切蕎麥 —— 助你油膩OUT、暢快加倍
想換換口味也可以點
#珈琲粉粿蕎麥奶 —— 一口濃郁烘焙香氣，一口滑順溫柔的老派浪漫。
#珍珠粉粿牛奶 ——珍珠＋粉粿＝雙重咬感爆擊！雙料大滿足
聚會來上一杯，中秋就更圓滿。
㊗️大家中秋節快樂
｜大茗官方網站｜https://www.damingtea.com.tw/
#大茗本位製茶堂 #中秋節快樂', '2025-10-05 00:00:00', 47);
INSERT INTO public.marketing_content VALUES (225, 2, 'IG', '[Text] 玉露青茶', 'DAMING | Happy Moon Festival
中秋烤肉聚餐，解膩神隊友必不可少
#玉露青茶 —— 清爽解膩、涼意滿滿
#熟成油切蕎麥 —— 助你油膩OUT、暢快加倍
想換換口味也可以點
#珈琲粉粿蕎麥奶 —— 一口濃郁烘焙香氣，一口滑順溫柔的老派浪漫。
#珍珠粉粿牛奶 ——珍珠＋粉粿＝雙重咬感爆擊！雙料大滿足
聚會來上一杯，中秋就更圓滿。
㊗️大家中秋節快樂
｜大茗官方網站｜https://www.damingtea.com.tw/
#大茗本位製茶堂 #中秋節快樂', '2025-10-05 00:00:00', 47);
INSERT INTO public.marketing_content VALUES (226, 2, 'IG', '[Text] 芒果青', '細火慢熬，以手作果醬入茶
#芒果青 #青熟感限定茗作
#台中首波指定門市上車囉
嚴選台灣在地芒果，手作慢熬釋放天然果香，
以黃金比例入茗翡翠青，果香與茶韻完美交織。
清爽回甘、果甜不膩
青熟感限定茗作 手工芒果醬✕翡翠茶
9/19(五)起指定區域首波限量開喝
指定販售門市
勤美模範 / 台中高工
台中水湳 / 逢甲西屯
逢甲福星 / 台中大雅
漢口青海 / 勤美誠品
嘉義民族
｜大茗官方網站｜https://www.damingtea.com.tw/
#大茗新品上市 #芒果青
#大茗本位製茶 #台中首波上市
v', '2025-09-17 00:00:00', 149);
INSERT INTO public.marketing_content VALUES (227, 2, 'IG', '[Text] 珈琲粉粿蕎麥奶', '#七夕
用一杯飲料，說盡我想對你說的情話
#珈琲粉粿蕎麥奶
牛郎織女一年見一次，
我要的是和你天天共享一杯老派的浪漫。
#珍珠粉粿牛奶
你是珍珠，我是粉粿，
我們加在一起就是最對味的愛情。
𝘁𝗮𝗴 你最想共享一杯的他/她 ♡
今年七夕，就用Ｑ彈的「 老派浪漫」告白，
#七夕 #七夕情人節 #老派靈魂新派味道
#大茗新品 #珈琲粉粿蕎麥奶 #珍珠粉粿牛奶
#大茗本位製茶堂 #新品上市', '2025-08-29 00:00:00', 57);
INSERT INTO public.marketing_content VALUES (228, 2, 'IG', '[Text] 珍珠粉粿牛奶', '#七夕
用一杯飲料，說盡我想對你說的情話
#珈琲粉粿蕎麥奶
牛郎織女一年見一次，
我要的是和你天天共享一杯老派的浪漫。
#珍珠粉粿牛奶
你是珍珠，我是粉粿，
我們加在一起就是最對味的愛情。
𝘁𝗮𝗴 你最想共享一杯的他/她 ♡
今年七夕，就用Ｑ彈的「 老派浪漫」告白，
#七夕 #七夕情人節 #老派靈魂新派味道
#大茗新品 #珈琲粉粿蕎麥奶 #珍珠粉粿牛奶
#大茗本位製茶堂 #新品上市', '2025-08-29 00:00:00', 57);
INSERT INTO public.marketing_content VALUES (229, 3, 'IG', '[Text] 芝士奶蓋緋烏龍', '身處湧動時代 復古卻成了新語言
偕茶師重新對焦
#緋烏龍系列 再次加載登場！
全新風味升級：首次加入緋烏龍、馥莓緋烏龍
在新與舊之間
注入靈魂播放昔日回憶
緋紅序曲已揭幕
邀你舉杯，共襄年末盛宴
> .collection - "𝓡ed Oolong Tea 緋烏龍系列"
.
[0]  緋烏龍........................M 35｜L 40
[1]  馥莓緋烏龍................M 50｜L 60
[2]  緋烏龍奶茶................M 50｜L 55
[3]  緋烏龍鮮奶................M 60｜L 70
[4]  芝士奶蓋緋烏龍........M 55｜L 65
STATUS: 全門市販售中
𝑪𝒉𝒂𝒑𝒕𝒆𝒓 𝟎𝟒｜芝士奶蓋緋烏龍  Cheese Milk Foam 𝓡ed Oolong Tea', '2025-12-17 00:00:00', 98);
INSERT INTO public.marketing_content VALUES (230, 3, 'IG', '[Text] 緋烏龍奶茶', '身處湧動時代 復古卻成了新語言
偕茶師重新對焦
#緋烏龍系列 再次加載登場！
全新風味升級：首次加入緋烏龍、馥莓緋烏龍
在新與舊之間
注入靈魂播放昔日回憶
緋紅序曲已揭幕
邀你舉杯，共襄年末盛宴
> .collection - "𝓡ed Oolong Tea 緋烏龍系列"
.
[0]  緋烏龍........................M 35｜L 40
[1]  馥莓緋烏龍................M 50｜L 60
[2]  緋烏龍奶茶................M 50｜L 55
[3]  緋烏龍鮮奶................M 60｜L 70
[4]  芝士奶蓋緋烏龍........M 55｜L 65
STATUS: 全門市販售中
𝑪𝒉𝒂𝒑𝒕𝒆𝒓 𝟎𝟒｜芝士奶蓋緋烏龍  Cheese Milk Foam 𝓡ed Oolong Tea', '2025-12-17 00:00:00', 98);
INSERT INTO public.marketing_content VALUES (281, 5, 'IG', '[Text] 茉綠茶凍拿鐵', '清心福全×變種吉娃娃 
連假超吉美食推薦
連假少不了的吃吃喝喝，「超吉」搭配超過癮！
吉凍套餐：脆皮吉排＆茉綠茶凍拿鐵，一口酥脆一口Q 嗲嗲的絕妙搭配（￣︶
￣）
#清心福全 #手搖飲料 #變種吉娃娃 #連假限定 #茉綠茶凍拿鐵', '2025-10-23 00:00:00', 333);
INSERT INTO public.marketing_content VALUES (232, 3, 'IG', '[Text] 馥莓緋烏龍', '身處湧動時代 復古卻成了新語言
偕茶師重新對焦
#緋烏龍系列 再次加載登場！
全新風味升級：首次加入緋烏龍、馥莓緋烏龍
在新與舊之間
注入靈魂播放昔日回憶
緋紅序曲已揭幕
邀你舉杯，共襄年末盛宴
> .collection - "𝓡ed Oolong Tea 緋烏龍系列"
.
[0]  緋烏龍........................M 35｜L 40
[1]  馥莓緋烏龍................M 50｜L 60
[2]  緋烏龍奶茶................M 50｜L 55
[3]  緋烏龍鮮奶................M 60｜L 70
[4]  芝士奶蓋緋烏龍........M 55｜L 65
STATUS: 全門市販售中
𝑪𝒉𝒂𝒑𝒕𝒆𝒓 𝟎𝟒｜芝士奶蓋緋烏龍  Cheese Milk Foam 𝓡ed Oolong Tea', '2025-12-17 00:00:00', 98);
INSERT INTO public.marketing_content VALUES (233, 3, 'IG', '[Text] 緋烏龍', '身處湧動時代 復古卻成了新語言
偕茶師重新對焦
#緋烏龍系列 再次加載登場！
全新風味升級：首次加入緋烏龍、馥莓緋烏龍
在新與舊之間
注入靈魂播放昔日回憶
緋紅序曲已揭幕
邀你舉杯，共襄年末盛宴
> .collection - "𝓡ed Oolong Tea 緋烏龍系列"
.
[0]  緋烏龍........................M 35｜L 40
[1]  馥莓緋烏龍................M 50｜L 60
[2]  緋烏龍奶茶................M 50｜L 55
[3]  緋烏龍鮮奶................M 60｜L 70
[4]  芝士奶蓋緋烏龍........M 55｜L 65
STATUS: 全門市販售中
𝑪𝒉𝒂𝒑𝒕𝒆𝒓 𝟎𝟒｜芝士奶蓋緋烏龍  Cheese Milk Foam 𝓡ed Oolong Tea', '2025-12-17 00:00:00', 98);
INSERT INTO public.marketing_content VALUES (234, 3, 'IG', '[Text] 緋烏龍鮮奶', '收音機嗡嗡作響
戴上耳機隔出一片自在zone
音符在空氣跳躍
鹹香芝士奶蓋
佐緋烏龍獨有熟果前調及蜜香喉韻
Volume up ! 𝓡eloading on 𝟏𝟐/𝟏𝟕 （﹙˓  ˒﹚）
滋味醇厚、回甘悠長
𝑪𝒉𝒂𝒑𝒕𝒆𝒓 𝟎𝟑｜緋烏龍鮮奶 𝓡ed Oolong Tea Latte', '2025-12-12 00:00:00', 109);
INSERT INTO public.marketing_content VALUES (235, 3, 'IG', '[Text] 緋烏龍', '收音機嗡嗡作響
戴上耳機隔出一片自在zone
音符在空氣跳躍
鹹香芝士奶蓋
佐緋烏龍獨有熟果前調及蜜香喉韻
Volume up ! 𝓡eloading on 𝟏𝟐/𝟏𝟕 （﹙˓  ˒﹚）
滋味醇厚、回甘悠長
𝑪𝒉𝒂𝒑𝒕𝒆𝒓 𝟎𝟑｜緋烏龍鮮奶 𝓡ed Oolong Tea Latte', '2025-12-12 00:00:00', 109);
INSERT INTO public.marketing_content VALUES (236, 3, 'IG', '[Text] 馥莓緋烏龍', '調整焦距，緋紅身影漸漸清晰
熟果基調揉合烏龍韻
奶香柔潤細膩
覆蓋舌尖
每口都是風味的細膩映像
帶著去年的悸動
Keep rolling ! 𝓡eloading on 𝟏𝟐/𝟏𝟕
回憶幀幀重現，逐格展開
𝑪𝒉𝒂𝒑𝒕𝒆𝒓 𝟎𝟐｜馥莓緋烏龍 Berrys 𝓡ed Oolong Tea', '2025-12-11 00:00:00', 89);
INSERT INTO public.marketing_content VALUES (237, 3, 'IG', '[Text] 緋烏龍', '調整焦距，緋紅身影漸漸清晰
熟果基調揉合烏龍韻
奶香柔潤細膩
覆蓋舌尖
每口都是風味的細膩映像
帶著去年的悸動
Keep rolling ! 𝓡eloading on 𝟏𝟐/𝟏𝟕
回憶幀幀重現，逐格展開
𝑪𝒉𝒂𝒑𝒕𝒆𝒓 𝟎𝟐｜馥莓緋烏龍 Berrys 𝓡ed Oolong Tea', '2025-12-11 00:00:00', 89);
INSERT INTO public.marketing_content VALUES (238, 3, 'IG', '[Text] 緋烏龍', '循電波傳遞酸甜訊號  • ılıılıılılıılıılı. 0
紫桑率先登場
緋烏龍沉靜其後，釋放熟果木質溫潤
再以覆盆子微酸收束
莓緋色澤
內斂卻蘊藏深意
Don’t hang up! 𝓡eloading on 𝟏𝟐/𝟏𝟕
以嫣紅映照明媚冬日與土地回甘
𝑪𝒉𝒂𝒑𝒕𝒆𝒓 𝟎𝟏｜緋烏龍 𝓡ed Oolong Tea', '2025-12-10 00:00:00', 90);
INSERT INTO public.marketing_content VALUES (239, 3, 'IG', '[Text] 緋烏龍', '#緋烏龍 ｛ 𝖿ē𝗂 𝗐𝗎𝗅ó𝗇𝗀｝ 選用台東紅烏龍，以夏秋茶葉為本結合紅茶加工特點，採重
指尖穿梭光影翩然敲打，緋紅色溫於膠卷顯影
發酵製成，果韻滋味明亮飽滿。
因水色呈現橙紅色澤而得名，一入口就能感受熟果及木質圓潤香氣，風味甘甜且喉韻
今年！原茶款首次加入，風味純粹卻足以撩動心弦 𝓡eloading on 𝟏𝟐/𝟏𝟕
悠長，紅韻入杯紅玉香、烏龍韻，香氣縈繞層次分明。', '2025-12-09 00:00:00', 71);
INSERT INTO public.marketing_content VALUES (241, 3, 'IG', '[Text-Rescued] 青檸甘蔗蕎麥綠寶', '月夕初見，跨越世代的相聚
在舉杯之間
分享澄黃如月的酸甜滋味
青檸甘蔗蕎麥綠寶 Lemon with Cane Green Rooibos Tea
甘蔗汁佐青檬，平衡中秋的豐盛味蕾
#無咖啡因 在月夜輕柔裡
𝗢𝗥𝗗𝗘𝗥   https://lihi.cc/QvWof/預約外送自取
大人孩童安心共飲', '2025-10-03 00:00:00', 131);
INSERT INTO public.marketing_content VALUES (243, 3, 'IG', '[需人工確認] 圖片限定或無飲品', '更迭沉潛，大地悄悄甦醒
陽光鋪展金光覆滿田野、碧綠金澄
化身不同花色地毯
✦ 
𝘎𝘳𝘦𝘦𝘯 𝘙𝘰𝘰𝘪𝘣𝘰𝘴 𝘛𝘦𝘢 𝘚𝘦𝘳𝘪𝘦𝘴 蕎麥綠寶系列
風味穀香淡雅、溫潤回甘
8/27 清爽上市', '2025-08-25 00:00:00', 157);
INSERT INTO public.marketing_content VALUES (246, 4, 'IG', '[需人工確認] 圖片限定或無飲品', '新的一年，願每一步都奔向更好的風景。
用一杯好茶，陪伴大家迎接嶄新的新年時刻。
限量設計，只為今年的相遇，
不只是喝茶，更是一份祝福、一份陪伴。
願馬年——
馬到成功 
茶香常在 
好運滿杯
#先喝道 #馬年限定杯 #新年喝好茶 #馬到成功 #陪你走過每一個新開始 #把世
界放在一杯茶中 #嚴選世界好茶 #TAOTAOTEA #精品茶 #ITQI 得獎茶 #手搖飲
#手搖推薦 #古典玫瑰園 #下午茶時間', '2026-02-10 00:00:00', 24);
INSERT INTO public.marketing_content VALUES (247, 4, 'IG', '[Text] 英式玫瑰特調茶', 'HAPPY FRIDAY｜𝟮/𝟭𝟯 情人節必喝  玫瑰限定    玫瑰水、英式玫瑰拿鐵 第二杯10 元
2/13 情人節限定｜玫瑰系必喝
懂茶的人，最懂怎麼說愛。
在玫瑰盛開的季節，
用一杯花香，替情人節加點溫柔的儀式感。
玫瑰水｜把浪漫喝進日常
使用 先喝道自製玫瑰露調製，無人工甜味劑、無防腐劑，
清透順口、輕柔不膩，細緻花香在舌尖停留，為日常增添浪漫。
英式玫瑰拿鐵｜專屬午後的溫柔告白
以斯里蘭卡莊園紅茶為基底，搭配米其林ITQI 2 星認證絕佳風味好茶英式玫瑰特調
茶，層層融入奶香與玫瑰香，溫潤柔和，完美午後茶時光必備。
快揪朋友一起喝，讓玫瑰香點亮你的週五！
𝟭.每人限購3 組
活動注意事項
𝟮.限現場/你訂自取 (優惠活動不合併使用)
𝟯.各門市數量有限，售完為止
#先喝道 #把世界放在一杯茶中 #嚴選世界好茶 #TAOTAOTEA #精品茶 #ITQI 得獎茶 #
手搖飲 #手搖推薦 #古典玫瑰園 #下午茶時間', '2026-02-08 00:00:00', 118);
INSERT INTO public.marketing_content VALUES (248, 4, 'IG', '[Text] 英式玫瑰拿鐵', 'HAPPY FRIDAY｜𝟮/𝟭𝟯 情人節必喝  玫瑰限定    玫瑰水、英式玫瑰拿鐵 第二杯10 元
2/13 情人節限定｜玫瑰系必喝
懂茶的人，最懂怎麼說愛。
在玫瑰盛開的季節，
用一杯花香，替情人節加點溫柔的儀式感。
玫瑰水｜把浪漫喝進日常
使用 先喝道自製玫瑰露調製，無人工甜味劑、無防腐劑，
清透順口、輕柔不膩，細緻花香在舌尖停留，為日常增添浪漫。
英式玫瑰拿鐵｜專屬午後的溫柔告白
以斯里蘭卡莊園紅茶為基底，搭配米其林ITQI 2 星認證絕佳風味好茶英式玫瑰特調
茶，層層融入奶香與玫瑰香，溫潤柔和，完美午後茶時光必備。
快揪朋友一起喝，讓玫瑰香點亮你的週五！
𝟭.每人限購3 組
活動注意事項
𝟮.限現場/你訂自取 (優惠活動不合併使用)
𝟯.各門市數量有限，售完為止
#先喝道 #把世界放在一杯茶中 #嚴選世界好茶 #TAOTAOTEA #精品茶 #ITQI 得獎茶 #
手搖飲 #手搖推薦 #古典玫瑰園 #下午茶時間', '2026-02-08 00:00:00', 118);
INSERT INTO public.marketing_content VALUES (249, 4, 'IG', '[Text] 玫瑰水', 'HAPPY FRIDAY｜𝟮/𝟭𝟯 情人節必喝  玫瑰限定    玫瑰水、英式玫瑰拿鐵 第二杯10 元
2/13 情人節限定｜玫瑰系必喝
懂茶的人，最懂怎麼說愛。
在玫瑰盛開的季節，
用一杯花香，替情人節加點溫柔的儀式感。
玫瑰水｜把浪漫喝進日常
使用 先喝道自製玫瑰露調製，無人工甜味劑、無防腐劑，
清透順口、輕柔不膩，細緻花香在舌尖停留，為日常增添浪漫。
英式玫瑰拿鐵｜專屬午後的溫柔告白
以斯里蘭卡莊園紅茶為基底，搭配米其林ITQI 2 星認證絕佳風味好茶英式玫瑰特調
茶，層層融入奶香與玫瑰香，溫潤柔和，完美午後茶時光必備。
快揪朋友一起喝，讓玫瑰香點亮你的週五！
𝟭.每人限購3 組
活動注意事項
𝟮.限現場/你訂自取 (優惠活動不合併使用)
𝟯.各門市數量有限，售完為止
#先喝道 #把世界放在一杯茶中 #嚴選世界好茶 #TAOTAOTEA #精品茶 #ITQI 得獎茶 #
手搖飲 #手搖推薦 #古典玫瑰園 #下午茶時間', '2026-02-08 00:00:00', 118);
INSERT INTO public.marketing_content VALUES (250, 4, 'IG', '[Text] 蜂蜜四季春茶', '有些茶，不需要多說，
一入口，就知道為什麼會被反覆點名。
四季春茶王
米其林級ITQI 最高3 星認證絕佳風味，第一口是清亮的茶湯，接著花香慢慢在口
中散開，尾韻回甘，是一杯會讓人默默一直喝下去的經典。
蜂蜜四季春茶
清新的四季春茶香先到，隨後蜂蜜的溫潤甜感，柔和不膩，口感圓順，每一口都輕
盈愉悅
好茶獻給懂喝的人，全台先喝道，隨時享受。
2/6 限定｜四季春茶王第二杯半價、蜂蜜四季春茶第二杯10 元
𝟭.每人限購3 組
活動注意事項
𝟮.限現場/你訂自取 (優惠活動不合併使用)
𝟯.各門市數量有限，售完為止
#先喝道#把世界放在一杯茶中#嚴選世界好茶#TAOTAOTEA#精品茶#ITQI 得獎茶#
手搖飲#手搖推薦#古典玫瑰園#下午茶時間', '2026-02-04 00:00:00', 7);
INSERT INTO public.marketing_content VALUES (251, 4, 'IG', '[Text] 四季春茶王', '有些茶，不需要多說，
一入口，就知道為什麼會被反覆點名。
四季春茶王
米其林級ITQI 最高3 星認證絕佳風味，第一口是清亮的茶湯，接著花香慢慢在口
中散開，尾韻回甘，是一杯會讓人默默一直喝下去的經典。
蜂蜜四季春茶
清新的四季春茶香先到，隨後蜂蜜的溫潤甜感，柔和不膩，口感圓順，每一口都輕
盈愉悅
好茶獻給懂喝的人，全台先喝道，隨時享受。
2/6 限定｜四季春茶王第二杯半價、蜂蜜四季春茶第二杯10 元
𝟭.每人限購3 組
活動注意事項
𝟮.限現場/你訂自取 (優惠活動不合併使用)
𝟯.各門市數量有限，售完為止
#先喝道#把世界放在一杯茶中#嚴選世界好茶#TAOTAOTEA#精品茶#ITQI 得獎茶#
手搖飲#手搖推薦#古典玫瑰園#下午茶時間', '2026-02-04 00:00:00', 7);
INSERT INTO public.marketing_content VALUES (252, 4, 'IG', '[Text] 蜂蜜四季春茶', 'HAPPY FRIDAY｜四季春系列 (ITQI 3 星得獎茶) 指定飲品優惠
懂喝茶的人都知道，
四季春的魅力，在那一口清爽花香與回甘之間。
先喝道-四季春茶王(ITQI 3 星得獎茶)
選用台灣優質茶葉，茶湯清透、口感輕盈，
自然花香在舌尖綻放，回甘乾淨不厚重，
是一杯每天都喝不膩的經典好茶。
蜂蜜四季春茶
以四季春為基底，加入香甜蜂蜜，
茶香依舊清爽，尾韻多了一抹溫潤甜感，清新柔和、順口耐喝。
2/6 限定｜四季春茶王第二杯半價、蜂蜜四季春茶第二杯10 元
𝟭.每人限購3 組
活動注意事項
𝟮.限現場/你訂自取 (優惠活動不合併使用)
𝟯.各門市數量有限，售完為止
#先喝道 #把世界放在一杯茶中 #嚴選世界好茶 #TAOTAOTEA #精品茶 #ITQI 得
獎茶 #手搖飲 #手搖推薦 #古典玫瑰園 #下午茶時間', '2026-02-01 00:00:00', 20);
INSERT INTO public.marketing_content VALUES (253, 4, 'IG', '[Text] 四季春茶王', 'HAPPY FRIDAY｜四季春系列 (ITQI 3 星得獎茶) 指定飲品優惠
懂喝茶的人都知道，
四季春的魅力，在那一口清爽花香與回甘之間。
先喝道-四季春茶王(ITQI 3 星得獎茶)
選用台灣優質茶葉，茶湯清透、口感輕盈，
自然花香在舌尖綻放，回甘乾淨不厚重，
是一杯每天都喝不膩的經典好茶。
蜂蜜四季春茶
以四季春為基底，加入香甜蜂蜜，
茶香依舊清爽，尾韻多了一抹溫潤甜感，清新柔和、順口耐喝。
2/6 限定｜四季春茶王第二杯半價、蜂蜜四季春茶第二杯10 元
𝟭.每人限購3 組
活動注意事項
𝟮.限現場/你訂自取 (優惠活動不合併使用)
𝟯.各門市數量有限，售完為止
#先喝道 #把世界放在一杯茶中 #嚴選世界好茶 #TAOTAOTEA #精品茶 #ITQI 得
獎茶 #手搖飲 #手搖推薦 #古典玫瑰園 #下午茶時間', '2026-02-01 00:00:00', 20);
INSERT INTO public.marketing_content VALUES (255, 4, 'IG', '[Text] 輕焙榖麥茶', '當世界太吵的時候，
不妨慢下來，
把世界放進一杯茶裡。
輕焙榖麥茶—— 
像是一封焙火寫給大地的情書。穀麥在低溫中慢慢甦醒，香氣不張揚，卻在杯中繾
綣不散；入口是溫柔的穀香與淡淡烘焙甜，讓心也跟著安靜下來。
榮獲
**2024 比利時布魯塞爾 iTQi 美食評鑑「最佳風味好茶」得獎茶款。
#先喝道 #把世界放在一杯茶中 #輕焙榖麥茶 #嚴選世界好茶 #iTQi 得獎茶 #英
式下午茶 #古典玫瑰園', '2026-01-29 00:00:00', 28);
INSERT INTO public.marketing_content VALUES (256, 4, 'IG', '[Text] 英式玫瑰拿鐵', '當午後的光線變得柔軟，就讓一杯花香，慢慢展開
玫瑰水
清透順口、輕柔不膩，細緻的玫瑰香氣，
在入口之間輕輕停留，芬芳綻放為日常增添浪漫。
英式玫瑰拿鐵
在溫潤茶香中，玫瑰悄然綻放，
與柔和奶香層層相融，完美的恰到好處。
週五讓這份剛剛好的玫瑰風味伴隨茶香陪你一起迎接浪漫午茶時光
1/30 限定｜玫瑰水第二杯半價、玫瑰拿鐵中杯(Ｍ)49 元第二杯半價
𝟭.每人限購3 組
活動注意事項
𝟮.限現場/你訂自取 (優惠活動不合併使用)
𝟯.各門市數量有限售完為止
#先喝道 #TAOTAOTEA #手搖飲 #好茶 #米其林 #四季春茶王 #台灣四大名茶 #嚴選世
界好茶 #英式下午茶 #英國茶 #台灣茶 #手搖推薦 #古典玫瑰園', '2026-01-28 00:00:00', 28);
INSERT INTO public.marketing_content VALUES (258, 4, 'IG', '[Text] 四季春茶王', '當午後的光線變得柔軟，就讓一杯花香，慢慢展開
玫瑰水
清透順口、輕柔不膩，細緻的玫瑰香氣，
在入口之間輕輕停留，芬芳綻放為日常增添浪漫。
英式玫瑰拿鐵
在溫潤茶香中，玫瑰悄然綻放，
與柔和奶香層層相融，完美的恰到好處。
週五讓這份剛剛好的玫瑰風味伴隨茶香陪你一起迎接浪漫午茶時光
1/30 限定｜玫瑰水第二杯半價、玫瑰拿鐵中杯(Ｍ)49 元第二杯半價
𝟭.每人限購3 組
活動注意事項
𝟮.限現場/你訂自取 (優惠活動不合併使用)
𝟯.各門市數量有限售完為止
#先喝道 #TAOTAOTEA #手搖飲 #好茶 #米其林 #四季春茶王 #台灣四大名茶 #嚴選世
界好茶 #英式下午茶 #英國茶 #台灣茶 #手搖推薦 #古典玫瑰園', '2026-01-28 00:00:00', 28);
INSERT INTO public.marketing_content VALUES (259, 4, 'IG', '[Text] 玫瑰水', '當午後的光線變得柔軟，就讓一杯花香，慢慢展開
玫瑰水
清透順口、輕柔不膩，細緻的玫瑰香氣，
在入口之間輕輕停留，芬芳綻放為日常增添浪漫。
英式玫瑰拿鐵
在溫潤茶香中，玫瑰悄然綻放，
與柔和奶香層層相融，完美的恰到好處。
週五讓這份剛剛好的玫瑰風味伴隨茶香陪你一起迎接浪漫午茶時光
1/30 限定｜玫瑰水第二杯半價、玫瑰拿鐵中杯(Ｍ)49 元第二杯半價
𝟭.每人限購3 組
活動注意事項
𝟮.限現場/你訂自取 (優惠活動不合併使用)
𝟯.各門市數量有限售完為止
#先喝道 #TAOTAOTEA #手搖飲 #好茶 #米其林 #四季春茶王 #台灣四大名茶 #嚴選世
界好茶 #英式下午茶 #英國茶 #台灣茶 #手搖推薦 #古典玫瑰園', '2026-01-28 00:00:00', 28);
INSERT INTO public.marketing_content VALUES (261, 4, 'IG', '[Text] 太妃蜜桃風味厚奶霜', '期間限定！消失的驚喜味道，1/17 日起限定回歸
還記得那口驚艷味蕾、帶有迷人香草氣息的「金杯烏瓦系列」嗎？
在無數粉絲的敲杯後，我們決定讓它期間門店限定復活了！
選用世界三大紅茶之一的斯里蘭卡烏瓦紅茶（Uva Tea）作為基底，來自知名烏瓦高
地。
以優雅的香草清香揭開序幕，隨後濃厚的麥芽香氣沉穩入喉，
尾韻透出甜美的柑橘風味，與細緻奶香交織，
層層堆疊出香醇濃郁、溫潤不膩的經典茶韻。
回歸日期：
1/17 (六) 起 ，全台18 間門市限定販售，數量有限，售完為止
販售門市：
台南新營、嘉義興業、台南民族、梧棲文化、台中嶺東、台中大甲、台南新市、台中
向心、新竹南大、台中潭子、沙鹿中山、龍井中央、林口長庚、北投石牌、桃園青
埔、中科永福、屏東廣東、仁武京吉
1/16 即將登場｜買太妃蜜桃風味厚奶霜送蜜桃風味茶一杯
#先喝道 #TAOTAOTEA #手搖飲 #好茶 #米其林 #金杯烏瓦 #世界三大紅茶 #嚴選世界
好茶 #英式下午茶 #英國茶 #台灣茶 #手搖推薦 #古典玫瑰園', '2026-01-14 00:00:00', 193);
INSERT INTO public.marketing_content VALUES (264, 4, 'IG', '[Text] 四季春茶王', '山嵐間的花香與回甘，是被米其林記住的味道
什麼樣的茶，能讓國際評審點頭認證？
從台灣優質茶園出發，茶湯清透、花香自然，
入口輕盈不苦澀，尾韻帶著乾淨回甘，越喝越順，
透過職人細緻的製茶工藝，把茶葉最純粹的風味完整留下。
也因為這份對風味的堅持，讓它獲得國際評審一致肯定，
榮獲食品界米其林 iTQi 三星認證。
這不只是一杯日常手搖飲，而是一杯被世界記住的 台灣好茶。
不用特地上山尋找，先喝道全台門市，就能喝到這杯嚴選世界好茶
四季春茶王
#先喝道 #TAOTAOTEA #手搖飲 #好茶 #米其林 #四季春茶王 #台灣四大名茶 #嚴選世
界好茶 #英式下午茶 #英國茶 #台灣茶 #手搖推薦 #古典玫瑰園', '2026-01-13 00:00:00', 12);
INSERT INTO public.marketing_content VALUES (265, 5, 'IG', '[Text] 烏龍綠茶', '【厚雪奶蓋系列 新品上市 #指定門市 試賣中】
口感綿密，像雪一樣輕柔的「厚雪奶蓋」
讓人忍不住一口接一口，快來清心點一杯！
厚雪‧烏龍奶蓋
甘醇的烏龍綠茶，頂層覆蓋「厚雪」奶蓋，入口濃郁卻如初雪般輕盈不膩。
厚雪‧頂級可可奶蓋
頂級可可與「厚雪」奶蓋完美結合。奶蓋的淡雅奶香融入香醇可可，口感飽滿厚
實。
厚雪‧ 紅心芭樂奶蓋
清香的紅心芭樂，頂端鋪滿一層「厚雪」奶蓋，每一口都能喝得到芭樂的香甜與柔
滑綿密的奶蓋。
只在指定門市才能喝到!!
販售門市供應，請參見：https://reurl.cc/2lV2za
清心福全據點搜尋：http://www.chingshin.tw/store.php', '2026-01-06 00:00:00', 421);
INSERT INTO public.marketing_content VALUES (266, 5, 'IG', '[Text] 頂級可可', '【厚雪奶蓋系列 新品上市 #指定門市 試賣中】
口感綿密，像雪一樣輕柔的「厚雪奶蓋」
讓人忍不住一口接一口，快來清心點一杯！
厚雪‧烏龍奶蓋
甘醇的烏龍綠茶，頂層覆蓋「厚雪」奶蓋，入口濃郁卻如初雪般輕盈不膩。
厚雪‧頂級可可奶蓋
頂級可可與「厚雪」奶蓋完美結合。奶蓋的淡雅奶香融入香醇可可，口感飽滿厚
實。
厚雪‧ 紅心芭樂奶蓋
清香的紅心芭樂，頂端鋪滿一層「厚雪」奶蓋，每一口都能喝得到芭樂的香甜與柔
滑綿密的奶蓋。
只在指定門市才能喝到!!
販售門市供應，請參見：https://reurl.cc/2lV2za
清心福全據點搜尋：http://www.chingshin.tw/store.php', '2026-01-06 00:00:00', 421);
INSERT INTO public.marketing_content VALUES (267, 5, 'IG', '[Text] 厚雪奶蓋', '【厚雪奶蓋系列 新品上市 #指定門市 試賣中】
口感綿密，像雪一樣輕柔的「厚雪奶蓋」
讓人忍不住一口接一口，快來清心點一杯！
厚雪‧烏龍奶蓋
甘醇的烏龍綠茶，頂層覆蓋「厚雪」奶蓋，入口濃郁卻如初雪般輕盈不膩。
厚雪‧頂級可可奶蓋
頂級可可與「厚雪」奶蓋完美結合。奶蓋的淡雅奶香融入香醇可可，口感飽滿厚
實。
厚雪‧ 紅心芭樂奶蓋
清香的紅心芭樂，頂端鋪滿一層「厚雪」奶蓋，每一口都能喝得到芭樂的香甜與柔
滑綿密的奶蓋。
只在指定門市才能喝到!!
販售門市供應，請參見：https://reurl.cc/2lV2za
清心福全據點搜尋：http://www.chingshin.tw/store.php', '2026-01-06 00:00:00', 421);
INSERT INTO public.marketing_content VALUES (268, 5, 'IG', '[Text] 錫蘭奶紅', '告別 2025・迎接嶄新的一年
清心福全陪你一起倒數，用熟悉的好味道迎接全新的開始
【跨年必喝】優惠活動
活動時間：12/31(三)～1/6(二)
優惠內容：大杯指定飲品「第二杯折價10 元」
「珍珠奶茶」、「粉圓奶茶」、「椰果奶茶」和「錫蘭奶紅」
活動注意事項：
1.本優惠不得與其他優惠併用。
2.僅適用於大杯指定飲品，且限來店自取。
3.不適用於外送平台、外送及線上點餐。
4.本公司保有解釋、修正與終止活動之權利。
#清心福全 #優惠活動 #新年快樂 #手搖飲料 #2026', '2025-12-29 00:00:00', 2571);
INSERT INTO public.marketing_content VALUES (269, 5, 'IG', '[Text] 椰果奶茶', '告別 2025・迎接嶄新的一年
清心福全陪你一起倒數，用熟悉的好味道迎接全新的開始
【跨年必喝】優惠活動
活動時間：12/31(三)～1/6(二)
優惠內容：大杯指定飲品「第二杯折價10 元」
「珍珠奶茶」、「粉圓奶茶」、「椰果奶茶」和「錫蘭奶紅」
活動注意事項：
1.本優惠不得與其他優惠併用。
2.僅適用於大杯指定飲品，且限來店自取。
3.不適用於外送平台、外送及線上點餐。
4.本公司保有解釋、修正與終止活動之權利。
#清心福全 #優惠活動 #新年快樂 #手搖飲料 #2026', '2025-12-29 00:00:00', 2571);
INSERT INTO public.marketing_content VALUES (270, 5, 'IG', '[Text] 珍珠奶茶', '告別 2025・迎接嶄新的一年
清心福全陪你一起倒數，用熟悉的好味道迎接全新的開始
【跨年必喝】優惠活動
活動時間：12/31(三)～1/6(二)
優惠內容：大杯指定飲品「第二杯折價10 元」
「珍珠奶茶」、「粉圓奶茶」、「椰果奶茶」和「錫蘭奶紅」
活動注意事項：
1.本優惠不得與其他優惠併用。
2.僅適用於大杯指定飲品，且限來店自取。
3.不適用於外送平台、外送及線上點餐。
4.本公司保有解釋、修正與終止活動之權利。
#清心福全 #優惠活動 #新年快樂 #手搖飲料 #2026', '2025-12-29 00:00:00', 2571);
INSERT INTO public.marketing_content VALUES (271, 5, 'IG', '[Text] 奶茶', '告別 2025・迎接嶄新的一年
清心福全陪你一起倒數，用熟悉的好味道迎接全新的開始
【跨年必喝】優惠活動
活動時間：12/31(三)～1/6(二)
優惠內容：大杯指定飲品「第二杯折價10 元」
「珍珠奶茶」、「粉圓奶茶」、「椰果奶茶」和「錫蘭奶紅」
活動注意事項：
1.本優惠不得與其他優惠併用。
2.僅適用於大杯指定飲品，且限來店自取。
3.不適用於外送平台、外送及線上點餐。
4.本公司保有解釋、修正與終止活動之權利。
#清心福全 #優惠活動 #新年快樂 #手搖飲料 #2026', '2025-12-29 00:00:00', 2571);
INSERT INTO public.marketing_content VALUES (272, 5, 'IG', '[Text] 白韻杏仁頂級可可', '冷氣團來襲，低溫拉警報，不想離開被窩就來杯能把冬天融化的「杏福滋味」吧！
冬季新品【白韻杏仁系列】純淨的白更韻涵典雅韻味，將純淨的幸福感留在唇齒間，
韻味無窮。
#白韻杏仁頂級可可 $80：創新口味，將東方傳統風味的「杏仁粉」溶入頂級可可，雙
重甜蜜滋味豪華升級。
#白韻杏仁奶 $65：以南杏研磨的「特級杏仁粉」，搭配醇正香濃的「嚴選奶精」，每一
口都是幸福細密的滑順口感。
#白韻杏仁鮮奶 $85：以南杏研磨的「特級杏仁粉」，搭配鮮潤的「崙背鮮乳」，杏仁香
與乳香完美結合，成就濃郁渾厚的極致口感。
找回杏福，暖暖過冬，一起拒絕“冷暴力”
更多資訊請鎖定 ：
官方網站連結：https://www.chingshin.tw/
Instagram 連結：https://pse.is/M9RBB
YouTube 連結：https://bit.ly/2rtxr5o
#清心福全 #手搖飲料 #新品登場 #冬季飲品 #暖暖過冬', '2025-12-15 00:00:00', 4353);
INSERT INTO public.marketing_content VALUES (273, 5, 'IG', '[Text] 白韻杏仁鮮奶', '冷氣團來襲，低溫拉警報，不想離開被窩就來杯能把冬天融化的「杏福滋味」吧！
冬季新品【白韻杏仁系列】純淨的白更韻涵典雅韻味，將純淨的幸福感留在唇齒間，
韻味無窮。
#白韻杏仁頂級可可 $80：創新口味，將東方傳統風味的「杏仁粉」溶入頂級可可，雙
重甜蜜滋味豪華升級。
#白韻杏仁奶 $65：以南杏研磨的「特級杏仁粉」，搭配醇正香濃的「嚴選奶精」，每一
口都是幸福細密的滑順口感。
#白韻杏仁鮮奶 $85：以南杏研磨的「特級杏仁粉」，搭配鮮潤的「崙背鮮乳」，杏仁香
與乳香完美結合，成就濃郁渾厚的極致口感。
找回杏福，暖暖過冬，一起拒絕“冷暴力”
更多資訊請鎖定 ：
官方網站連結：https://www.chingshin.tw/
Instagram 連結：https://pse.is/M9RBB
YouTube 連結：https://bit.ly/2rtxr5o
#清心福全 #手搖飲料 #新品登場 #冬季飲品 #暖暖過冬', '2025-12-15 00:00:00', 4353);
INSERT INTO public.marketing_content VALUES (274, 5, 'IG', '[Text] 白韻杏仁奶', '冷氣團來襲，低溫拉警報，不想離開被窩就來杯能把冬天融化的「杏福滋味」吧！
冬季新品【白韻杏仁系列】純淨的白更韻涵典雅韻味，將純淨的幸福感留在唇齒間，
韻味無窮。
#白韻杏仁頂級可可 $80：創新口味，將東方傳統風味的「杏仁粉」溶入頂級可可，雙
重甜蜜滋味豪華升級。
#白韻杏仁奶 $65：以南杏研磨的「特級杏仁粉」，搭配醇正香濃的「嚴選奶精」，每一
口都是幸福細密的滑順口感。
#白韻杏仁鮮奶 $85：以南杏研磨的「特級杏仁粉」，搭配鮮潤的「崙背鮮乳」，杏仁香
與乳香完美結合，成就濃郁渾厚的極致口感。
找回杏福，暖暖過冬，一起拒絕“冷暴力”
更多資訊請鎖定 ：
官方網站連結：https://www.chingshin.tw/
Instagram 連結：https://pse.is/M9RBB
YouTube 連結：https://bit.ly/2rtxr5o
#清心福全 #手搖飲料 #新品登場 #冬季飲品 #暖暖過冬', '2025-12-15 00:00:00', 4353);
INSERT INTO public.marketing_content VALUES (275, 5, 'IG', '[Text] 頂級可可', '冷氣團來襲，低溫拉警報，不想離開被窩就來杯能把冬天融化的「杏福滋味」吧！
冬季新品【白韻杏仁系列】純淨的白更韻涵典雅韻味，將純淨的幸福感留在唇齒間，
韻味無窮。
#白韻杏仁頂級可可 $80：創新口味，將東方傳統風味的「杏仁粉」溶入頂級可可，雙
重甜蜜滋味豪華升級。
#白韻杏仁奶 $65：以南杏研磨的「特級杏仁粉」，搭配醇正香濃的「嚴選奶精」，每一
口都是幸福細密的滑順口感。
#白韻杏仁鮮奶 $85：以南杏研磨的「特級杏仁粉」，搭配鮮潤的「崙背鮮乳」，杏仁香
與乳香完美結合，成就濃郁渾厚的極致口感。
找回杏福，暖暖過冬，一起拒絕“冷暴力”
更多資訊請鎖定 ：
官方網站連結：https://www.chingshin.tw/
Instagram 連結：https://pse.is/M9RBB
YouTube 連結：https://bit.ly/2rtxr5o
#清心福全 #手搖飲料 #新品登場 #冬季飲品 #暖暖過冬', '2025-12-15 00:00:00', 4353);
INSERT INTO public.marketing_content VALUES (276, 5, 'IG', '[Text] 白韻杏仁頂級可可', '別讓冷空氣覆蓋了你的好精神，冬季新品上市，品嘗杏福滋味～
冬季新品【白韻杏仁系列】純淨的白更韻涵典雅韻味，將純淨的幸福感留在唇齒
間，韻味無窮。
#白韻杏仁奶 $65：以南杏研磨的「特級杏仁粉」，搭配醇正香濃的「嚴選奶
精」，每一口都是幸福細密的滑順口感。
#白韻杏仁頂級可可 $80：創新口味，將東方傳統風味的「杏仁粉」溶入頂級可
可，雙重甜蜜滋味豪華升級。
同步推薦【經典冬季不敗飲品】 #珍珠琥珀黑糖鮮奶 #芝麻奶茶 #桂圓鮮奶茶
找回杏福，暖暖過冬，一起拒絕“冷暴力”
更多資訊請鎖定 ：
官方網站連結：https://www.chingshin.tw/
Instagram 連結：https://pse.is/M9RBB
YouTube 連結：https://bit.ly/2rtxr5o
#清心福全 #手搖飲料 #新品登場 #冬季飲品 #暖暖過冬', '2025-11-18 00:00:00', 3830);
INSERT INTO public.marketing_content VALUES (277, 5, 'IG', '[Text] 珍珠琥珀黑糖鮮奶', '別讓冷空氣覆蓋了你的好精神，冬季新品上市，品嘗杏福滋味～
冬季新品【白韻杏仁系列】純淨的白更韻涵典雅韻味，將純淨的幸福感留在唇齒
間，韻味無窮。
#白韻杏仁奶 $65：以南杏研磨的「特級杏仁粉」，搭配醇正香濃的「嚴選奶
精」，每一口都是幸福細密的滑順口感。
#白韻杏仁頂級可可 $80：創新口味，將東方傳統風味的「杏仁粉」溶入頂級可
可，雙重甜蜜滋味豪華升級。
同步推薦【經典冬季不敗飲品】 #珍珠琥珀黑糖鮮奶 #芝麻奶茶 #桂圓鮮奶茶
找回杏福，暖暖過冬，一起拒絕“冷暴力”
更多資訊請鎖定 ：
官方網站連結：https://www.chingshin.tw/
Instagram 連結：https://pse.is/M9RBB
YouTube 連結：https://bit.ly/2rtxr5o
#清心福全 #手搖飲料 #新品登場 #冬季飲品 #暖暖過冬', '2025-11-18 00:00:00', 3830);
INSERT INTO public.marketing_content VALUES (278, 5, 'IG', '[Text] 白韻杏仁奶', '別讓冷空氣覆蓋了你的好精神，冬季新品上市，品嘗杏福滋味～
冬季新品【白韻杏仁系列】純淨的白更韻涵典雅韻味，將純淨的幸福感留在唇齒
間，韻味無窮。
#白韻杏仁奶 $65：以南杏研磨的「特級杏仁粉」，搭配醇正香濃的「嚴選奶
精」，每一口都是幸福細密的滑順口感。
#白韻杏仁頂級可可 $80：創新口味，將東方傳統風味的「杏仁粉」溶入頂級可
可，雙重甜蜜滋味豪華升級。
同步推薦【經典冬季不敗飲品】 #珍珠琥珀黑糖鮮奶 #芝麻奶茶 #桂圓鮮奶茶
找回杏福，暖暖過冬，一起拒絕“冷暴力”
更多資訊請鎖定 ：
官方網站連結：https://www.chingshin.tw/
Instagram 連結：https://pse.is/M9RBB
YouTube 連結：https://bit.ly/2rtxr5o
#清心福全 #手搖飲料 #新品登場 #冬季飲品 #暖暖過冬', '2025-11-18 00:00:00', 3830);
INSERT INTO public.marketing_content VALUES (279, 5, 'IG', '[Text] 桂圓鮮奶茶', '別讓冷空氣覆蓋了你的好精神，冬季新品上市，品嘗杏福滋味～
冬季新品【白韻杏仁系列】純淨的白更韻涵典雅韻味，將純淨的幸福感留在唇齒
間，韻味無窮。
#白韻杏仁奶 $65：以南杏研磨的「特級杏仁粉」，搭配醇正香濃的「嚴選奶
精」，每一口都是幸福細密的滑順口感。
#白韻杏仁頂級可可 $80：創新口味，將東方傳統風味的「杏仁粉」溶入頂級可
可，雙重甜蜜滋味豪華升級。
同步推薦【經典冬季不敗飲品】 #珍珠琥珀黑糖鮮奶 #芝麻奶茶 #桂圓鮮奶茶
找回杏福，暖暖過冬，一起拒絕“冷暴力”
更多資訊請鎖定 ：
官方網站連結：https://www.chingshin.tw/
Instagram 連結：https://pse.is/M9RBB
YouTube 連結：https://bit.ly/2rtxr5o
#清心福全 #手搖飲料 #新品登場 #冬季飲品 #暖暖過冬', '2025-11-18 00:00:00', 3830);
INSERT INTO public.marketing_content VALUES (280, 5, 'IG', '[Text] 芝麻奶茶', '別讓冷空氣覆蓋了你的好精神，冬季新品上市，品嘗杏福滋味～
冬季新品【白韻杏仁系列】純淨的白更韻涵典雅韻味，將純淨的幸福感留在唇齒
間，韻味無窮。
#白韻杏仁奶 $65：以南杏研磨的「特級杏仁粉」，搭配醇正香濃的「嚴選奶
精」，每一口都是幸福細密的滑順口感。
#白韻杏仁頂級可可 $80：創新口味，將東方傳統風味的「杏仁粉」溶入頂級可
可，雙重甜蜜滋味豪華升級。
同步推薦【經典冬季不敗飲品】 #珍珠琥珀黑糖鮮奶 #芝麻奶茶 #桂圓鮮奶茶
找回杏福，暖暖過冬，一起拒絕“冷暴力”
更多資訊請鎖定 ：
官方網站連結：https://www.chingshin.tw/
Instagram 連結：https://pse.is/M9RBB
YouTube 連結：https://bit.ly/2rtxr5o
#清心福全 #手搖飲料 #新品登場 #冬季飲品 #暖暖過冬', '2025-11-18 00:00:00', 3830);
INSERT INTO public.marketing_content VALUES (282, 5, 'IG', '[Text] 荔枝蘋果醋', '#雙十節快樂 十月連假第二彈
又是一個三天連假，千萬別把好時光蹉跎掉了，
來杯清心福全的 #荔枝蘋果醋 慶祝連假萬睡。
更多變種吉娃娃資訊請鎖定 ：
官方網站連結：https://www.chingshin.tw/
Instagram 連結：https://pse.is/M9RBB
YouTube 連結：https://bit.ly/2rtxr5o
#變種吉娃娃 #清心福全 #手搖飲料 #小狗 #聯名活動', '2025-10-09 00:00:00', 433);
INSERT INTO public.marketing_content VALUES (283, 5, 'IG', '[Text] 蘋果醋', '#雙十節快樂 十月連假第二彈
又是一個三天連假，千萬別把好時光蹉跎掉了，
來杯清心福全的 #荔枝蘋果醋 慶祝連假萬睡。
更多變種吉娃娃資訊請鎖定 ：
官方網站連結：https://www.chingshin.tw/
Instagram 連結：https://pse.is/M9RBB
YouTube 連結：https://bit.ly/2rtxr5o
#變種吉娃娃 #清心福全 #手搖飲料 #小狗 #聯名活動', '2025-10-09 00:00:00', 433);
INSERT INTO public.marketing_content VALUES (284, 5, 'IG', '[Text] 珍珠琥珀黑糖鮮奶', '謝謝老師的用心教誨，在特別的日子裡加碼作業，
來杯
大人的滋味 #咖啡凍奶茶，苦甜苦甜才是人生。 
更多變種吉娃娃資訊請鎖定 ： 
官方網站連結：https://www.chingshin.tw/ 
Instagram 連結：https://pse.is/M9RBB 
YouTube 連結：https://bit.ly/2rtxr5o
#變種吉娃娃 #清心福全 #手搖飲料 #小狗 #聯名活動
來杯甜甜的，讀書就不會那麼辛苦了 ₊˚⊹♡ 
#珍珠琥珀黑糖鮮奶 黑糖香氣滿滿～Q 彈珍珠咬一口就超幸福', '2025-09-26 00:00:00', 216);
INSERT INTO public.marketing_content VALUES (285, 5, 'IG', '[Text] 咖啡凍奶茶', '謝謝老師的用心教誨，在特別的日子裡加碼作業，
來杯
大人的滋味 #咖啡凍奶茶，苦甜苦甜才是人生。 
更多變種吉娃娃資訊請鎖定 ： 
官方網站連結：https://www.chingshin.tw/ 
Instagram 連結：https://pse.is/M9RBB 
YouTube 連結：https://bit.ly/2rtxr5o
#變種吉娃娃 #清心福全 #手搖飲料 #小狗 #聯名活動
來杯甜甜的，讀書就不會那麼辛苦了 ₊˚⊹♡ 
#珍珠琥珀黑糖鮮奶 黑糖香氣滿滿～Q 彈珍珠咬一口就超幸福', '2025-09-26 00:00:00', 216);
INSERT INTO public.marketing_content VALUES (286, 5, 'IG', '[Text] 奶茶', '謝謝老師的用心教誨，在特別的日子裡加碼作業，
來杯
大人的滋味 #咖啡凍奶茶，苦甜苦甜才是人生。 
更多變種吉娃娃資訊請鎖定 ： 
官方網站連結：https://www.chingshin.tw/ 
Instagram 連結：https://pse.is/M9RBB 
YouTube 連結：https://bit.ly/2rtxr5o
#變種吉娃娃 #清心福全 #手搖飲料 #小狗 #聯名活動
來杯甜甜的，讀書就不會那麼辛苦了 ₊˚⊹♡ 
#珍珠琥珀黑糖鮮奶 黑糖香氣滿滿～Q 彈珍珠咬一口就超幸福', '2025-09-26 00:00:00', 216);
INSERT INTO public.marketing_content VALUES (287, 5, 'IG', '[Text] 珍珠蜂蜜鮮奶普洱', '#隱藏版 (珍珠蜂蜜鮮奶普洱) 甜而不膩～給你滿滿好心情
讓清心飲料＆變種吉娃娃陪你收穫好成績！！
#變種吉娃娃 #清心福全 #聯名活動 #手搖飲料 #小狗勾療癒陪伴', '2025-09-23 00:00:00', 279);
INSERT INTO public.marketing_content VALUES (288, 5, 'IG', '[Text] 蜜桃凍紅茶', '這個夏天超吉喜歡喝涼涼的飲料～～
香甜清爽的 #柳橙綠、 甜Q 爽口的 #蜜桃凍紅茶、 酸甜活力的 #紅心芭樂優
持續關注⇩⇩⇩
多，快來清心一口喝下你的新學期元氣，讓開學大吉大利！
官方網站連結：https://www.chingshin.tw/
Instagram 連結：https://pse.is/M9RBB
YouTube 連結：https://bit.ly/2rtxr5o
#變種吉娃娃 #清心福全 #聯名活動 #手搖飲料 #可愛的小狗勾', '2025-08-19 00:00:00', 408);
INSERT INTO public.marketing_content VALUES (289, 5, 'IG', '[Text] 柳橙綠', '這個夏天超吉喜歡喝涼涼的飲料～～
香甜清爽的 #柳橙綠、 甜Q 爽口的 #蜜桃凍紅茶、 酸甜活力的 #紅心芭樂優
持續關注⇩⇩⇩
多，快來清心一口喝下你的新學期元氣，讓開學大吉大利！
官方網站連結：https://www.chingshin.tw/
Instagram 連結：https://pse.is/M9RBB
YouTube 連結：https://bit.ly/2rtxr5o
#變種吉娃娃 #清心福全 #聯名活動 #手搖飲料 #可愛的小狗勾', '2025-08-19 00:00:00', 408);
INSERT INTO public.marketing_content VALUES (290, 5, 'IG', '[Text] 粉戀莓莓', '520 「莓」你不行的戀愛滋味
#粉戀莓莓 像是她微笑時的甜
#情人茶 像戀愛一樣清爽又讓人心動
清心福全×三麗鷗男團 給你表白的勇氣
今天不來一杯怎麼行？讓我們在清心一起心動！
小編今天只幫你助攻到這～剩下的，就靠你自己加油啦
更多資訊 ：
官方網站連結：https://www.chingshin.tw/
Instagram: https://reurl.cc/67Rn3Z 
YouTube 連結：https://bit.ly/2rtxr5o
#清心福全 #手搖飲料 #三麗鷗男團 #飲料推薦 #520 莓你不行', '2025-05-20 00:00:00', 374);
INSERT INTO public.marketing_content VALUES (291, 5, 'IG', '[Text] 情人茶', '520 「莓」你不行的戀愛滋味
#粉戀莓莓 像是她微笑時的甜
#情人茶 像戀愛一樣清爽又讓人心動
清心福全×三麗鷗男團 給你表白的勇氣
今天不來一杯怎麼行？讓我們在清心一起心動！
小編今天只幫你助攻到這～剩下的，就靠你自己加油啦
更多資訊 ：
官方網站連結：https://www.chingshin.tw/
Instagram: https://reurl.cc/67Rn3Z 
YouTube 連結：https://bit.ly/2rtxr5o
#清心福全 #手搖飲料 #三麗鷗男團 #飲料推薦 #520 莓你不行', '2025-05-20 00:00:00', 374);
INSERT INTO public.marketing_content VALUES (292, 6, 'IG', '[Text] 香芋仙草綠茶拿鐵', '涼涼的天適合暖暖的那一杯
法芙娜可可鮮奶｜𝟭𝟬𝟬%法芙娜可可粉，入口滑順
冬天，就該給自己一杯迷客夏的暖心系熱飲
珍珠紅茶拿鐵｜𝗤 彈香甜，冬天熱熱喝更對味
靜岡焙焙鮮奶｜焙香濃郁，暖到心坎裡~
香芋仙草綠茶拿鐵｜芋頭 x 仙草凍 x 綠茶，暖甜飽足感滿滿
現在買𝟮杯還能抽𝗶𝗣𝗵𝗼𝗻𝗲 𝟭𝟳等豪禮
暖暖喝，好運暖暖暖~起來
現場門市限定：熱門指定單茶&茶拿鐵組合價只要$𝟳𝟵(南)／$𝟴𝟵(北)
迷點自取限定：滿𝟮杯即贈「愛茶的牛」指定飲品電子兌換券乙張
現在下單給自己一個暖心飲品 https://reurl.cc/R9GaXZ
活動詳見官網  https://reurl.cc/gnyg7X
#迷客夏 #milksha #為了你嚴選每一杯
#雀蘋中選週週抽 #iPhone 抽獎
#雙週門市驚喜第二彈 #迷點自取買二送一', '2026-01-23 00:00:00', 82);
INSERT INTO public.marketing_content VALUES (293, 6, 'IG', '[Text] 法芙娜可可鮮奶', '涼涼的天適合暖暖的那一杯
法芙娜可可鮮奶｜𝟭𝟬𝟬%法芙娜可可粉，入口滑順
冬天，就該給自己一杯迷客夏的暖心系熱飲
珍珠紅茶拿鐵｜𝗤 彈香甜，冬天熱熱喝更對味
靜岡焙焙鮮奶｜焙香濃郁，暖到心坎裡~
香芋仙草綠茶拿鐵｜芋頭 x 仙草凍 x 綠茶，暖甜飽足感滿滿
現在買𝟮杯還能抽𝗶𝗣𝗵𝗼𝗻𝗲 𝟭𝟳等豪禮
暖暖喝，好運暖暖暖~起來
現場門市限定：熱門指定單茶&茶拿鐵組合價只要$𝟳𝟵(南)／$𝟴𝟵(北)
迷點自取限定：滿𝟮杯即贈「愛茶的牛」指定飲品電子兌換券乙張
現在下單給自己一個暖心飲品 https://reurl.cc/R9GaXZ
活動詳見官網  https://reurl.cc/gnyg7X
#迷客夏 #milksha #為了你嚴選每一杯
#雀蘋中選週週抽 #iPhone 抽獎
#雙週門市驚喜第二彈 #迷點自取買二送一', '2026-01-23 00:00:00', 82);
INSERT INTO public.marketing_content VALUES (325, 7, 'IG', '[Text] 沖繩黑糖奶茶', '跨年夜一定要來點「咀嚼系幸福」(〃∀〃)
今年最後一杯＆新年第一杯——
#COMEBUY #沖繩黑糖奶茶
雙𝗤𝟭號（珍珠＋粉條）
—— 甜度僅靠黑糖
半糖以上最有味 ♡
𝗤彈、軟糯、焦香、濃奶一次登場
比煙火還療癒的口感衝擊就在這刻炸開
跨年的願望不一定要很偉大：
喝到好喝的
心情甜一點
明年更順一點
迎向 𝟮𝟬𝟮𝟲，讓暖甜先替你開個好頭吧～
這杯就能全包辦 (๑˃ᴗ˂) و♡
#跨年 #新年必喝 #雙Q 咀嚼控集合
#黑糖不另外加糖 #半糖以上最有味
𝗠𝗲𝗿𝗿𝘆 𝗖𝗵𝗿𝗶𝘀𝘁𝗺𝗮𝘀 
 
聖誕快樂呀大家 (ﾉ>▽<)ﾉ', '2025-12-31 00:00:00', 20);
INSERT INTO public.marketing_content VALUES (294, 6, 'IG', '[Text] 靜岡焙焙鮮奶', '涼涼的天適合暖暖的那一杯
法芙娜可可鮮奶｜𝟭𝟬𝟬%法芙娜可可粉，入口滑順
冬天，就該給自己一杯迷客夏的暖心系熱飲
珍珠紅茶拿鐵｜𝗤 彈香甜，冬天熱熱喝更對味
靜岡焙焙鮮奶｜焙香濃郁，暖到心坎裡~
香芋仙草綠茶拿鐵｜芋頭 x 仙草凍 x 綠茶，暖甜飽足感滿滿
現在買𝟮杯還能抽𝗶𝗣𝗵𝗼𝗻𝗲 𝟭𝟳等豪禮
暖暖喝，好運暖暖暖~起來
現場門市限定：熱門指定單茶&茶拿鐵組合價只要$𝟳𝟵(南)／$𝟴𝟵(北)
迷點自取限定：滿𝟮杯即贈「愛茶的牛」指定飲品電子兌換券乙張
現在下單給自己一個暖心飲品 https://reurl.cc/R9GaXZ
活動詳見官網  https://reurl.cc/gnyg7X
#迷客夏 #milksha #為了你嚴選每一杯
#雀蘋中選週週抽 #iPhone 抽獎
#雙週門市驚喜第二彈 #迷點自取買二送一', '2026-01-23 00:00:00', 82);
INSERT INTO public.marketing_content VALUES (295, 6, 'IG', '[Text] 茉莉原淬綠茶', '𝟭月份雙週限定驚喜 𝗽𝗮𝗿𝘁 𝟮
你的迷客夏新春大禮包第二彈來襲
𝟭/𝟮𝟭 (三)~𝟮/𝟯(二)
<門市現場購買> 𝗔＋𝗕限定好康
𝗔 區 醇濃鮮奶茶(𝗟) ＋ 𝗕 區 愛茶的牛
組合價 $𝟳𝟵(南)／$𝟴𝟵(北)
一次喝到 濃郁奶香 × 清爽茶韻
鮮奶控＆茶控都滿足的雙杯組合
醇濃鮮奶茶/愛茶的牛適用茶底：
大正醇香紅茶/英倫伯爵紅茶/茉莉原淬綠茶/原片初露青茶/琥珀高峰烏龍
新年好康連連~雙倍幸福一次喝
查詢鄰近門市享好康 https://reurl.cc/7Kr7bQ
活動詳情請見官網 https://reurl.cc/EbaKAn
#迷客夏 #milksha #為了你嚴選每一杯 #雙週門市驚喜第二彈', '2026-01-20 00:00:00', 166);
INSERT INTO public.marketing_content VALUES (296, 6, 'IG', '[Text] 茉香綠茶拿鐵', '𝟭月份雙週限定驚喜
第一彈
你的迷客夏新春大禮包已送達
即日起~𝟭/𝟮𝟬(二)
<門市現場購買>任𝟮杯全系列飲品
即可享
加購$𝟯𝟵茶拿鐵(𝗠)𝟭杯
𝟯𝟵元就能享受迷人的奶香茶韻
活動加購茶拿鐵適用品項：
大正紅茶拿鐵/伯爵紅茶拿鐵/茉香綠茶拿鐵/原片青茶拿鐵/琥珀烏龍拿鐵
新年好康連連，別錯過這一杯
立即前往鄰近門市享優惠 https://reurl.cc/7Kr7bQ
活動詳情請見官網 https://reurl.cc/EbaKAn
#迷客夏 #milksha #為了你嚴選每一杯 #雙週門市驚喜第一彈
迎接 𝟮𝟬𝟮𝟲 倒數計時！誰陪你跨年?!
 
在煙火綻放的那一刻，', '2026-01-09 00:00:00', 78);
INSERT INTO public.marketing_content VALUES (297, 6, 'IG', '[OCR] 淌央單茶', '手裡拿的是哪一杯最愛的迷客夏？  
快在下方用「表情符號」投出你的最愛 
看看哪一派粉絲軍團最強大！
醇濃茶拿鐵派：迷客夏人氣必喝，最對味！ 
清爽單茶派：解膩神助攻，清爽回甘
特調果香派：果香明亮，層次迷人 
香醇鮮奶派：濃郁順口，暖心首選 
現在就預約你的跨年小夥伴！
https://miniapp.line.me/1657225662-ARnXEvKb 
#迷客夏 #milksha #為了你嚴選每一杯 #2025 年度TOP10 #年度推薦 
#2026 新年快樂
回顧𝟮𝟬𝟮𝟱年，大家最愛的迷客夏飲料有哪些?!(下集)', '2025-12-31 00:00:00', 96);
INSERT INTO public.marketing_content VALUES (298, 6, 'IG', '[Text] 珍珠大正紅茶拿鐵', '快看你的迷客夏必喝有沒有上榜！
𝗧𝗢𝗣𝟭 #珍珠大正紅茶拿鐵
拿起你最愛的那杯，一起看年度旁行榜
 https://milksha.nidin.shop/
融合錫蘭 × 阿薩姆紅茶的多層次茶香
𝗤 彈香甜、冬天必喝
加上醇濃綠光鮮奶與蜜漬白玉珍珠
𝗧𝗢𝗣𝟮 #輕纖蕎麥茶
無咖啡因首選
蕎麥穀香濃而不澀，溫潤順口、自然回甘
獨家製程，讓香氣更純粹
𝗧𝗢𝗣𝟯 #伯爵紅茶拿鐵
給想減少咖啡因的小迷人
釋放獨特佛手柑優雅果香
完美調和綠光鮮奶
𝗧𝗢𝗣𝟰 #原片初露青茶
口感醇厚柔順無人不愛
單茶控的清爽心頭好
選用台灣原片青茶
𝗧𝗢𝗣𝟱 #芋頭鮮奶
滋味淡雅清香、圓潤清甜
持續擔綱迷客夏「鎮店之寶」寶座
選用高雄一號芋頭精心製作
保留精華中段，手工壓製成綿密芋泥
搭配綠光鮮奶，每口都有濃濃芋頭香氣和顆粒
#迷客夏 #milksha #為了你嚴選每一杯 #2025 年度TOP10 #年度推薦
回顧𝟮𝟬𝟮𝟱年，大家最愛的迷客夏飲料有哪些?!(上集)', '2025-12-21 00:00:00', 64);
INSERT INTO public.marketing_content VALUES (299, 6, 'IG', '[Text] 伯爵紅茶拿鐵', '快看你的迷客夏必喝有沒有上榜！
𝗧𝗢𝗣𝟭 #珍珠大正紅茶拿鐵
拿起你最愛的那杯，一起看年度旁行榜
 https://milksha.nidin.shop/
融合錫蘭 × 阿薩姆紅茶的多層次茶香
𝗤 彈香甜、冬天必喝
加上醇濃綠光鮮奶與蜜漬白玉珍珠
𝗧𝗢𝗣𝟮 #輕纖蕎麥茶
無咖啡因首選
蕎麥穀香濃而不澀，溫潤順口、自然回甘
獨家製程，讓香氣更純粹
𝗧𝗢𝗣𝟯 #伯爵紅茶拿鐵
給想減少咖啡因的小迷人
釋放獨特佛手柑優雅果香
完美調和綠光鮮奶
𝗧𝗢𝗣𝟰 #原片初露青茶
口感醇厚柔順無人不愛
單茶控的清爽心頭好
選用台灣原片青茶
𝗧𝗢𝗣𝟱 #芋頭鮮奶
滋味淡雅清香、圓潤清甜
持續擔綱迷客夏「鎮店之寶」寶座
選用高雄一號芋頭精心製作
保留精華中段，手工壓製成綿密芋泥
搭配綠光鮮奶，每口都有濃濃芋頭香氣和顆粒
#迷客夏 #milksha #為了你嚴選每一杯 #2025 年度TOP10 #年度推薦
回顧𝟮𝟬𝟮𝟱年，大家最愛的迷客夏飲料有哪些?!(上集)', '2025-12-21 00:00:00', 64);
INSERT INTO public.marketing_content VALUES (300, 6, 'IG', '[Text] 原片初露青茶', '快看你的迷客夏必喝有沒有上榜！
𝗧𝗢𝗣𝟭 #珍珠大正紅茶拿鐵
拿起你最愛的那杯，一起看年度旁行榜
 https://milksha.nidin.shop/
融合錫蘭 × 阿薩姆紅茶的多層次茶香
𝗤 彈香甜、冬天必喝
加上醇濃綠光鮮奶與蜜漬白玉珍珠
𝗧𝗢𝗣𝟮 #輕纖蕎麥茶
無咖啡因首選
蕎麥穀香濃而不澀，溫潤順口、自然回甘
獨家製程，讓香氣更純粹
𝗧𝗢𝗣𝟯 #伯爵紅茶拿鐵
給想減少咖啡因的小迷人
釋放獨特佛手柑優雅果香
完美調和綠光鮮奶
𝗧𝗢𝗣𝟰 #原片初露青茶
口感醇厚柔順無人不愛
單茶控的清爽心頭好
選用台灣原片青茶
𝗧𝗢𝗣𝟱 #芋頭鮮奶
滋味淡雅清香、圓潤清甜
持續擔綱迷客夏「鎮店之寶」寶座
選用高雄一號芋頭精心製作
保留精華中段，手工壓製成綿密芋泥
搭配綠光鮮奶，每口都有濃濃芋頭香氣和顆粒
#迷客夏 #milksha #為了你嚴選每一杯 #2025 年度TOP10 #年度推薦
回顧𝟮𝟬𝟮𝟱年，大家最愛的迷客夏飲料有哪些?!(上集)', '2025-12-21 00:00:00', 64);
INSERT INTO public.marketing_content VALUES (301, 6, 'IG', '[Text] 輕纖蕎麥茶', '快看你的迷客夏必喝有沒有上榜！
𝗧𝗢𝗣𝟭 #珍珠大正紅茶拿鐵
拿起你最愛的那杯，一起看年度旁行榜
 https://milksha.nidin.shop/
融合錫蘭 × 阿薩姆紅茶的多層次茶香
𝗤 彈香甜、冬天必喝
加上醇濃綠光鮮奶與蜜漬白玉珍珠
𝗧𝗢𝗣𝟮 #輕纖蕎麥茶
無咖啡因首選
蕎麥穀香濃而不澀，溫潤順口、自然回甘
獨家製程，讓香氣更純粹
𝗧𝗢𝗣𝟯 #伯爵紅茶拿鐵
給想減少咖啡因的小迷人
釋放獨特佛手柑優雅果香
完美調和綠光鮮奶
𝗧𝗢𝗣𝟰 #原片初露青茶
口感醇厚柔順無人不愛
單茶控的清爽心頭好
選用台灣原片青茶
𝗧𝗢𝗣𝟱 #芋頭鮮奶
滋味淡雅清香、圓潤清甜
持續擔綱迷客夏「鎮店之寶」寶座
選用高雄一號芋頭精心製作
保留精華中段，手工壓製成綿密芋泥
搭配綠光鮮奶，每口都有濃濃芋頭香氣和顆粒
#迷客夏 #milksha #為了你嚴選每一杯 #2025 年度TOP10 #年度推薦
回顧𝟮𝟬𝟮𝟱年，大家最愛的迷客夏飲料有哪些?!(上集)', '2025-12-21 00:00:00', 64);
INSERT INTO public.marketing_content VALUES (302, 6, 'IG', '[Text] 芋頭鮮奶', '快看你的迷客夏必喝有沒有上榜！
𝗧𝗢𝗣𝟭 #珍珠大正紅茶拿鐵
拿起你最愛的那杯，一起看年度旁行榜
 https://milksha.nidin.shop/
融合錫蘭 × 阿薩姆紅茶的多層次茶香
𝗤 彈香甜、冬天必喝
加上醇濃綠光鮮奶與蜜漬白玉珍珠
𝗧𝗢𝗣𝟮 #輕纖蕎麥茶
無咖啡因首選
蕎麥穀香濃而不澀，溫潤順口、自然回甘
獨家製程，讓香氣更純粹
𝗧𝗢𝗣𝟯 #伯爵紅茶拿鐵
給想減少咖啡因的小迷人
釋放獨特佛手柑優雅果香
完美調和綠光鮮奶
𝗧𝗢𝗣𝟰 #原片初露青茶
口感醇厚柔順無人不愛
單茶控的清爽心頭好
選用台灣原片青茶
𝗧𝗢𝗣𝟱 #芋頭鮮奶
滋味淡雅清香、圓潤清甜
持續擔綱迷客夏「鎮店之寶」寶座
選用高雄一號芋頭精心製作
保留精華中段，手工壓製成綿密芋泥
搭配綠光鮮奶，每口都有濃濃芋頭香氣和顆粒
#迷客夏 #milksha #為了你嚴選每一杯 #2025 年度TOP10 #年度推薦
回顧𝟮𝟬𝟮𝟱年，大家最愛的迷客夏飲料有哪些?!(上集)', '2025-12-21 00:00:00', 64);
INSERT INTO public.marketing_content VALUES (303, 6, 'IG', '[Text] 法芙娜可可鮮奶', '快看你的迷客夏必喝有沒有上榜！
𝗧𝗢𝗣𝟲 #手炒黑糖鮮奶
拿起你最愛的那杯，一起看年度排行榜  https://milksha.nidin.shop/
門市手工炒製的黑糖，清甜焦香不膩口
𝗧𝗢𝗣𝟳 #柳丁綠茶
搭配綠光鮮奶，醇香可口
𝟭𝟬𝟬%柳丁原汁融合茉莉原淬綠茶
迷客夏經典不敗清爽滋味
𝗧𝗢𝗣𝟴 #琥珀高峰烏龍
清新花香襯托柑橘果香，喝得到柳丁果肉
榮獲𝟮𝟬𝟮𝟯 𝗜𝗧𝗜風味絕佳二星獎章
獨特烤焙工藝，於嗅覺評分項目獲最高肯定
𝗧𝗢𝗣𝟵 #靜岡焙焙鮮奶
琥珀色烏龍茶湯，炭焙香氣回甘留香
冬日療癒，「焙」感幸福
採用嚴選靜岡直送茶葉
獨特烘烤香氣搭配濃醇的綠光鮮奶
𝗧𝗢𝗣𝟭𝟬 #法芙娜可可鮮奶
口感醇厚滑順，完美融合焙茶＆奶香
𝗧𝗵𝗿𝗲𝗮𝗱𝘀爆紅回歸款
𝟭𝟬𝟬%法芙娜純可可粉 × 綠光鮮奶
可可香氣細緻濃香，入口滑順有層次
微糖熱飲必點
#迷客夏 #milksha #為了你嚴選每一杯 #2025 年度TOP10 #年度推薦', '2025-12-20 00:00:00', 93);
INSERT INTO public.marketing_content VALUES (304, 6, 'IG', '[Text] 茉莉原淬綠茶', '快看你的迷客夏必喝有沒有上榜！
𝗧𝗢𝗣𝟲 #手炒黑糖鮮奶
拿起你最愛的那杯，一起看年度排行榜  https://milksha.nidin.shop/
門市手工炒製的黑糖，清甜焦香不膩口
𝗧𝗢𝗣𝟳 #柳丁綠茶
搭配綠光鮮奶，醇香可口
𝟭𝟬𝟬%柳丁原汁融合茉莉原淬綠茶
迷客夏經典不敗清爽滋味
𝗧𝗢𝗣𝟴 #琥珀高峰烏龍
清新花香襯托柑橘果香，喝得到柳丁果肉
榮獲𝟮𝟬𝟮𝟯 𝗜𝗧𝗜風味絕佳二星獎章
獨特烤焙工藝，於嗅覺評分項目獲最高肯定
𝗧𝗢𝗣𝟵 #靜岡焙焙鮮奶
琥珀色烏龍茶湯，炭焙香氣回甘留香
冬日療癒，「焙」感幸福
採用嚴選靜岡直送茶葉
獨特烘烤香氣搭配濃醇的綠光鮮奶
𝗧𝗢𝗣𝟭𝟬 #法芙娜可可鮮奶
口感醇厚滑順，完美融合焙茶＆奶香
𝗧𝗵𝗿𝗲𝗮𝗱𝘀爆紅回歸款
𝟭𝟬𝟬%法芙娜純可可粉 × 綠光鮮奶
可可香氣細緻濃香，入口滑順有層次
微糖熱飲必點
#迷客夏 #milksha #為了你嚴選每一杯 #2025 年度TOP10 #年度推薦', '2025-12-20 00:00:00', 93);
INSERT INTO public.marketing_content VALUES (305, 6, 'IG', '[Text] 靜岡焙焙鮮奶', '快看你的迷客夏必喝有沒有上榜！
𝗧𝗢𝗣𝟲 #手炒黑糖鮮奶
拿起你最愛的那杯，一起看年度排行榜  https://milksha.nidin.shop/
門市手工炒製的黑糖，清甜焦香不膩口
𝗧𝗢𝗣𝟳 #柳丁綠茶
搭配綠光鮮奶，醇香可口
𝟭𝟬𝟬%柳丁原汁融合茉莉原淬綠茶
迷客夏經典不敗清爽滋味
𝗧𝗢𝗣𝟴 #琥珀高峰烏龍
清新花香襯托柑橘果香，喝得到柳丁果肉
榮獲𝟮𝟬𝟮𝟯 𝗜𝗧𝗜風味絕佳二星獎章
獨特烤焙工藝，於嗅覺評分項目獲最高肯定
𝗧𝗢𝗣𝟵 #靜岡焙焙鮮奶
琥珀色烏龍茶湯，炭焙香氣回甘留香
冬日療癒，「焙」感幸福
採用嚴選靜岡直送茶葉
獨特烘烤香氣搭配濃醇的綠光鮮奶
𝗧𝗢𝗣𝟭𝟬 #法芙娜可可鮮奶
口感醇厚滑順，完美融合焙茶＆奶香
𝗧𝗵𝗿𝗲𝗮𝗱𝘀爆紅回歸款
𝟭𝟬𝟬%法芙娜純可可粉 × 綠光鮮奶
可可香氣細緻濃香，入口滑順有層次
微糖熱飲必點
#迷客夏 #milksha #為了你嚴選每一杯 #2025 年度TOP10 #年度推薦', '2025-12-20 00:00:00', 93);
INSERT INTO public.marketing_content VALUES (306, 6, 'IG', '[Text] 琥珀高峰烏龍', '快看你的迷客夏必喝有沒有上榜！
𝗧𝗢𝗣𝟲 #手炒黑糖鮮奶
拿起你最愛的那杯，一起看年度排行榜  https://milksha.nidin.shop/
門市手工炒製的黑糖，清甜焦香不膩口
𝗧𝗢𝗣𝟳 #柳丁綠茶
搭配綠光鮮奶，醇香可口
𝟭𝟬𝟬%柳丁原汁融合茉莉原淬綠茶
迷客夏經典不敗清爽滋味
𝗧𝗢𝗣𝟴 #琥珀高峰烏龍
清新花香襯托柑橘果香，喝得到柳丁果肉
榮獲𝟮𝟬𝟮𝟯 𝗜𝗧𝗜風味絕佳二星獎章
獨特烤焙工藝，於嗅覺評分項目獲最高肯定
𝗧𝗢𝗣𝟵 #靜岡焙焙鮮奶
琥珀色烏龍茶湯，炭焙香氣回甘留香
冬日療癒，「焙」感幸福
採用嚴選靜岡直送茶葉
獨特烘烤香氣搭配濃醇的綠光鮮奶
𝗧𝗢𝗣𝟭𝟬 #法芙娜可可鮮奶
口感醇厚滑順，完美融合焙茶＆奶香
𝗧𝗵𝗿𝗲𝗮𝗱𝘀爆紅回歸款
𝟭𝟬𝟬%法芙娜純可可粉 × 綠光鮮奶
可可香氣細緻濃香，入口滑順有層次
微糖熱飲必點
#迷客夏 #milksha #為了你嚴選每一杯 #2025 年度TOP10 #年度推薦', '2025-12-20 00:00:00', 93);
INSERT INTO public.marketing_content VALUES (307, 6, 'IG', '[Text] 手炒黑糖鮮奶', '快看你的迷客夏必喝有沒有上榜！
𝗧𝗢𝗣𝟲 #手炒黑糖鮮奶
拿起你最愛的那杯，一起看年度排行榜  https://milksha.nidin.shop/
門市手工炒製的黑糖，清甜焦香不膩口
𝗧𝗢𝗣𝟳 #柳丁綠茶
搭配綠光鮮奶，醇香可口
𝟭𝟬𝟬%柳丁原汁融合茉莉原淬綠茶
迷客夏經典不敗清爽滋味
𝗧𝗢𝗣𝟴 #琥珀高峰烏龍
清新花香襯托柑橘果香，喝得到柳丁果肉
榮獲𝟮𝟬𝟮𝟯 𝗜𝗧𝗜風味絕佳二星獎章
獨特烤焙工藝，於嗅覺評分項目獲最高肯定
𝗧𝗢𝗣𝟵 #靜岡焙焙鮮奶
琥珀色烏龍茶湯，炭焙香氣回甘留香
冬日療癒，「焙」感幸福
採用嚴選靜岡直送茶葉
獨特烘烤香氣搭配濃醇的綠光鮮奶
𝗧𝗢𝗣𝟭𝟬 #法芙娜可可鮮奶
口感醇厚滑順，完美融合焙茶＆奶香
𝗧𝗵𝗿𝗲𝗮𝗱𝘀爆紅回歸款
𝟭𝟬𝟬%法芙娜純可可粉 × 綠光鮮奶
可可香氣細緻濃香，入口滑順有層次
微糖熱飲必點
#迷客夏 #milksha #為了你嚴選每一杯 #2025 年度TOP10 #年度推薦', '2025-12-20 00:00:00', 93);
INSERT INTO public.marketing_content VALUES (308, 6, 'IG', '[Text] 靜岡焙焙鮮奶', '𝟭𝟮/𝟮𝟰、𝟭𝟮/𝟮𝟱
\齁齁齁~~聖誕加「焙」幸福已抵達
/
門市現場購買 #𝟮杯靜岡焙焙鮮奶 (𝗠) 
只要 $𝟵𝟵
溫暖加焙、幸福加倍
現在就 @想一起喝迷客夏的小寶焙
一起過暖暖聖誕節
活動詳情請見官網
https://reurl.cc/xKWqKV
#迷客夏 #milksha #為了你嚴選每一杯 #靜岡焙焙鮮奶 #聖誕節快樂
𝟮𝟬𝟮𝟱 冬日暖心熱飲，你喝過哪些了呢？', '2025-12-19 00:00:00', 153);
INSERT INTO public.marketing_content VALUES (309, 6, 'IG', '[Text] 香芋仙草綠茶拿鐵', '一起收藏最療癒的冬季 𝗧𝗢𝗣 清單！
𝗧𝗢𝗣𝟭 #靜岡焙焙鮮奶
冬日療癒，「焙」感幸福
嚴選自靜岡的特選製茶名家，焙香濃郁
𝗧𝗢𝗣𝟮 #珍珠大正紅茶拿鐵
搭配綠光鮮奶，滑順醇厚、暖心必喝
大正紅茶融合錫蘭 × 阿薩姆紅茶的多層次茶香
𝗤 彈香甜、冬天必喝
加上醇濃綠光鮮奶與蜜漬白玉珍珠
𝗧𝗢𝗣𝟯 #法芙娜可可鮮奶
選用可可屆愛馬仕的𝟭𝟬𝟬%頂級法芙娜純可可粉
網友敲碗~重磅回歸刮起法芙娜可可旋風
高雅的苦甜香氣搭配滑順濃香的綠光鮮奶
入口時可可香氣層次明顯
𝗧𝗢𝗣𝟰 #琥珀烏龍拿鐵
推薦微糖熱飲最美味
炭焙香氣 × 綠光鮮奶
𝗧𝗢𝗣𝟱 #香芋仙草綠茶拿鐵
柔順口感、層次豐富的冬日暖意
延續榮獲 𝗔.𝗔. 純粹品味三星獎的芋頭鮮奶口碑
創新結合綠茶與嫩仙草凍
𝗧𝗢𝗣𝟲 #白甘蔗青茶
仙草甘味與滑順奶香蔓延口中
選用台灣𝟭𝟬𝟬%白甘蔗原汁
搭配清新青茶，滋味圓潤清甜
最療癒的冬季，需要最暖心的熱飲  https://milksha.nidin.shop/
#迷客夏 #milksha #為了你嚴選每一杯 #2025 冬日暖心推薦 #冬日必喝', '2025-12-10 00:00:00', 143);
INSERT INTO public.marketing_content VALUES (310, 6, 'IG', '[Text] 珍珠大正紅茶拿鐵', '一起收藏最療癒的冬季 𝗧𝗢𝗣 清單！
𝗧𝗢𝗣𝟭 #靜岡焙焙鮮奶
冬日療癒，「焙」感幸福
嚴選自靜岡的特選製茶名家，焙香濃郁
𝗧𝗢𝗣𝟮 #珍珠大正紅茶拿鐵
搭配綠光鮮奶，滑順醇厚、暖心必喝
大正紅茶融合錫蘭 × 阿薩姆紅茶的多層次茶香
𝗤 彈香甜、冬天必喝
加上醇濃綠光鮮奶與蜜漬白玉珍珠
𝗧𝗢𝗣𝟯 #法芙娜可可鮮奶
選用可可屆愛馬仕的𝟭𝟬𝟬%頂級法芙娜純可可粉
網友敲碗~重磅回歸刮起法芙娜可可旋風
高雅的苦甜香氣搭配滑順濃香的綠光鮮奶
入口時可可香氣層次明顯
𝗧𝗢𝗣𝟰 #琥珀烏龍拿鐵
推薦微糖熱飲最美味
炭焙香氣 × 綠光鮮奶
𝗧𝗢𝗣𝟱 #香芋仙草綠茶拿鐵
柔順口感、層次豐富的冬日暖意
延續榮獲 𝗔.𝗔. 純粹品味三星獎的芋頭鮮奶口碑
創新結合綠茶與嫩仙草凍
𝗧𝗢𝗣𝟲 #白甘蔗青茶
仙草甘味與滑順奶香蔓延口中
選用台灣𝟭𝟬𝟬%白甘蔗原汁
搭配清新青茶，滋味圓潤清甜
最療癒的冬季，需要最暖心的熱飲  https://milksha.nidin.shop/
#迷客夏 #milksha #為了你嚴選每一杯 #2025 冬日暖心推薦 #冬日必喝', '2025-12-10 00:00:00', 143);
INSERT INTO public.marketing_content VALUES (311, 6, 'IG', '[Text] 法芙娜可可鮮奶', '一起收藏最療癒的冬季 𝗧𝗢𝗣 清單！
𝗧𝗢𝗣𝟭 #靜岡焙焙鮮奶
冬日療癒，「焙」感幸福
嚴選自靜岡的特選製茶名家，焙香濃郁
𝗧𝗢𝗣𝟮 #珍珠大正紅茶拿鐵
搭配綠光鮮奶，滑順醇厚、暖心必喝
大正紅茶融合錫蘭 × 阿薩姆紅茶的多層次茶香
𝗤 彈香甜、冬天必喝
加上醇濃綠光鮮奶與蜜漬白玉珍珠
𝗧𝗢𝗣𝟯 #法芙娜可可鮮奶
選用可可屆愛馬仕的𝟭𝟬𝟬%頂級法芙娜純可可粉
網友敲碗~重磅回歸刮起法芙娜可可旋風
高雅的苦甜香氣搭配滑順濃香的綠光鮮奶
入口時可可香氣層次明顯
𝗧𝗢𝗣𝟰 #琥珀烏龍拿鐵
推薦微糖熱飲最美味
炭焙香氣 × 綠光鮮奶
𝗧𝗢𝗣𝟱 #香芋仙草綠茶拿鐵
柔順口感、層次豐富的冬日暖意
延續榮獲 𝗔.𝗔. 純粹品味三星獎的芋頭鮮奶口碑
創新結合綠茶與嫩仙草凍
𝗧𝗢𝗣𝟲 #白甘蔗青茶
仙草甘味與滑順奶香蔓延口中
選用台灣𝟭𝟬𝟬%白甘蔗原汁
搭配清新青茶，滋味圓潤清甜
最療癒的冬季，需要最暖心的熱飲  https://milksha.nidin.shop/
#迷客夏 #milksha #為了你嚴選每一杯 #2025 冬日暖心推薦 #冬日必喝', '2025-12-10 00:00:00', 143);
INSERT INTO public.marketing_content VALUES (312, 6, 'IG', '[Text] 靜岡焙焙鮮奶', '一起收藏最療癒的冬季 𝗧𝗢𝗣 清單！
𝗧𝗢𝗣𝟭 #靜岡焙焙鮮奶
冬日療癒，「焙」感幸福
嚴選自靜岡的特選製茶名家，焙香濃郁
𝗧𝗢𝗣𝟮 #珍珠大正紅茶拿鐵
搭配綠光鮮奶，滑順醇厚、暖心必喝
大正紅茶融合錫蘭 × 阿薩姆紅茶的多層次茶香
𝗤 彈香甜、冬天必喝
加上醇濃綠光鮮奶與蜜漬白玉珍珠
𝗧𝗢𝗣𝟯 #法芙娜可可鮮奶
選用可可屆愛馬仕的𝟭𝟬𝟬%頂級法芙娜純可可粉
網友敲碗~重磅回歸刮起法芙娜可可旋風
高雅的苦甜香氣搭配滑順濃香的綠光鮮奶
入口時可可香氣層次明顯
𝗧𝗢𝗣𝟰 #琥珀烏龍拿鐵
推薦微糖熱飲最美味
炭焙香氣 × 綠光鮮奶
𝗧𝗢𝗣𝟱 #香芋仙草綠茶拿鐵
柔順口感、層次豐富的冬日暖意
延續榮獲 𝗔.𝗔. 純粹品味三星獎的芋頭鮮奶口碑
創新結合綠茶與嫩仙草凍
𝗧𝗢𝗣𝟲 #白甘蔗青茶
仙草甘味與滑順奶香蔓延口中
選用台灣𝟭𝟬𝟬%白甘蔗原汁
搭配清新青茶，滋味圓潤清甜
最療癒的冬季，需要最暖心的熱飲  https://milksha.nidin.shop/
#迷客夏 #milksha #為了你嚴選每一杯 #2025 冬日暖心推薦 #冬日必喝', '2025-12-10 00:00:00', 143);
INSERT INTO public.marketing_content VALUES (313, 6, 'IG', '[Text] 琥珀烏龍拿鐵', '一起收藏最療癒的冬季 𝗧𝗢𝗣 清單！
𝗧𝗢𝗣𝟭 #靜岡焙焙鮮奶
冬日療癒，「焙」感幸福
嚴選自靜岡的特選製茶名家，焙香濃郁
𝗧𝗢𝗣𝟮 #珍珠大正紅茶拿鐵
搭配綠光鮮奶，滑順醇厚、暖心必喝
大正紅茶融合錫蘭 × 阿薩姆紅茶的多層次茶香
𝗤 彈香甜、冬天必喝
加上醇濃綠光鮮奶與蜜漬白玉珍珠
𝗧𝗢𝗣𝟯 #法芙娜可可鮮奶
選用可可屆愛馬仕的𝟭𝟬𝟬%頂級法芙娜純可可粉
網友敲碗~重磅回歸刮起法芙娜可可旋風
高雅的苦甜香氣搭配滑順濃香的綠光鮮奶
入口時可可香氣層次明顯
𝗧𝗢𝗣𝟰 #琥珀烏龍拿鐵
推薦微糖熱飲最美味
炭焙香氣 × 綠光鮮奶
𝗧𝗢𝗣𝟱 #香芋仙草綠茶拿鐵
柔順口感、層次豐富的冬日暖意
延續榮獲 𝗔.𝗔. 純粹品味三星獎的芋頭鮮奶口碑
創新結合綠茶與嫩仙草凍
𝗧𝗢𝗣𝟲 #白甘蔗青茶
仙草甘味與滑順奶香蔓延口中
選用台灣𝟭𝟬𝟬%白甘蔗原汁
搭配清新青茶，滋味圓潤清甜
最療癒的冬季，需要最暖心的熱飲  https://milksha.nidin.shop/
#迷客夏 #milksha #為了你嚴選每一杯 #2025 冬日暖心推薦 #冬日必喝', '2025-12-10 00:00:00', 143);
INSERT INTO public.marketing_content VALUES (314, 6, 'IG', '[Text] 靜岡焙焙烏龍拿鐵', '大家敲破碗的 #冬季限定 人氣飲品回歸啦！
靜岡焙焙鮮奶、靜岡焙焙烏龍拿鐵 濃郁登場
嚴選靜岡製茶名家精工研磨，細緻茶粉完整釋放焙香茶韻
#靜岡焙焙鮮奶 迷編最推薦
靜岡焙茶烤焙香氣 × 綠光鮮奶的醇厚滑順
一口享受高品質的飲茶體驗
榮獲𝗜𝗧𝗜風味絕佳二星獎章的 #琥珀高峰烏龍茶 x #綠光鮮奶
#靜岡焙焙烏龍拿鐵
炭焙茶香交織濃郁奶香，清爽甘醇不膩口
同場加映
法國 𝗩𝗮𝗹𝗿𝗵𝗼𝗻𝗮 頂級純可可 × 綠光鮮奶
#法芙娜可可鮮奶 重磅歸隊！
苦甜香氣細緻升級，滑順濃郁更迷人
回味「焙」感溫暖的懷抱 ➜ https://milksha.nidin.shop/ 
#迷客夏 #milksha #為了你嚴選每一杯 #濃焙茶 #重磅回歸', '2025-11-13 00:00:00', 146);
INSERT INTO public.marketing_content VALUES (384, 8, 'IG', '[Text] 珍珠奶青', '春秋戰國時代百家爭鳴，
現在奶茶也有四大門派擁護者
奶茶派、奶青派、烏龍奶派、奶綠派
各派系擁護者眾多～你屬於哪一派呢？
歡迎嵐粉們分享 #最愛奶類
阿嵐最近偏好 #珍珠奶青
獨特奶香味搭配四季青茶的滿口清香
再感受滑順的小珍珠，超級好喝～
#50 嵐 #50 嵐中區 #春季主打 #嵐a 青春 #珍珠奶青 #好茶陪伴你的日常 #手
搖 #飲料
Coco 都可', '2024-04-09 00:00:00', 8509);
INSERT INTO public.marketing_content VALUES (315, 6, 'IG', '[Text] 法芙娜可可鮮奶', '大家敲破碗的 #冬季限定 人氣飲品回歸啦！
靜岡焙焙鮮奶、靜岡焙焙烏龍拿鐵 濃郁登場
嚴選靜岡製茶名家精工研磨，細緻茶粉完整釋放焙香茶韻
#靜岡焙焙鮮奶 迷編最推薦
靜岡焙茶烤焙香氣 × 綠光鮮奶的醇厚滑順
一口享受高品質的飲茶體驗
榮獲𝗜𝗧𝗜風味絕佳二星獎章的 #琥珀高峰烏龍茶 x #綠光鮮奶
#靜岡焙焙烏龍拿鐵
炭焙茶香交織濃郁奶香，清爽甘醇不膩口
同場加映
法國 𝗩𝗮𝗹𝗿𝗵𝗼𝗻𝗮 頂級純可可 × 綠光鮮奶
#法芙娜可可鮮奶 重磅歸隊！
苦甜香氣細緻升級，滑順濃郁更迷人
回味「焙」感溫暖的懷抱 ➜ https://milksha.nidin.shop/ 
#迷客夏 #milksha #為了你嚴選每一杯 #濃焙茶 #重磅回歸', '2025-11-13 00:00:00', 146);
INSERT INTO public.marketing_content VALUES (316, 6, 'IG', '[Text] 琥珀高峰烏龍茶', '大家敲破碗的 #冬季限定 人氣飲品回歸啦！
靜岡焙焙鮮奶、靜岡焙焙烏龍拿鐵 濃郁登場
嚴選靜岡製茶名家精工研磨，細緻茶粉完整釋放焙香茶韻
#靜岡焙焙鮮奶 迷編最推薦
靜岡焙茶烤焙香氣 × 綠光鮮奶的醇厚滑順
一口享受高品質的飲茶體驗
榮獲𝗜𝗧𝗜風味絕佳二星獎章的 #琥珀高峰烏龍茶 x #綠光鮮奶
#靜岡焙焙烏龍拿鐵
炭焙茶香交織濃郁奶香，清爽甘醇不膩口
同場加映
法國 𝗩𝗮𝗹𝗿𝗵𝗼𝗻𝗮 頂級純可可 × 綠光鮮奶
#法芙娜可可鮮奶 重磅歸隊！
苦甜香氣細緻升級，滑順濃郁更迷人
回味「焙」感溫暖的懷抱 ➜ https://milksha.nidin.shop/ 
#迷客夏 #milksha #為了你嚴選每一杯 #濃焙茶 #重磅回歸', '2025-11-13 00:00:00', 146);
INSERT INTO public.marketing_content VALUES (317, 6, 'IG', '[Text] 靜岡焙焙鮮奶', '大家敲破碗的 #冬季限定 人氣飲品回歸啦！
靜岡焙焙鮮奶、靜岡焙焙烏龍拿鐵 濃郁登場
嚴選靜岡製茶名家精工研磨，細緻茶粉完整釋放焙香茶韻
#靜岡焙焙鮮奶 迷編最推薦
靜岡焙茶烤焙香氣 × 綠光鮮奶的醇厚滑順
一口享受高品質的飲茶體驗
榮獲𝗜𝗧𝗜風味絕佳二星獎章的 #琥珀高峰烏龍茶 x #綠光鮮奶
#靜岡焙焙烏龍拿鐵
炭焙茶香交織濃郁奶香，清爽甘醇不膩口
同場加映
法國 𝗩𝗮𝗹𝗿𝗵𝗼𝗻𝗮 頂級純可可 × 綠光鮮奶
#法芙娜可可鮮奶 重磅歸隊！
苦甜香氣細緻升級，滑順濃郁更迷人
回味「焙」感溫暖的懷抱 ➜ https://milksha.nidin.shop/ 
#迷客夏 #milksha #為了你嚴選每一杯 #濃焙茶 #重磅回歸', '2025-11-13 00:00:00', 146);
INSERT INTO public.marketing_content VALUES (318, 6, 'IG', '[Text] 綠光鮮奶', '大家敲破碗的 #冬季限定 人氣飲品回歸啦！
靜岡焙焙鮮奶、靜岡焙焙烏龍拿鐵 濃郁登場
嚴選靜岡製茶名家精工研磨，細緻茶粉完整釋放焙香茶韻
#靜岡焙焙鮮奶 迷編最推薦
靜岡焙茶烤焙香氣 × 綠光鮮奶的醇厚滑順
一口享受高品質的飲茶體驗
榮獲𝗜𝗧𝗜風味絕佳二星獎章的 #琥珀高峰烏龍茶 x #綠光鮮奶
#靜岡焙焙烏龍拿鐵
炭焙茶香交織濃郁奶香，清爽甘醇不膩口
同場加映
法國 𝗩𝗮𝗹𝗿𝗵𝗼𝗻𝗮 頂級純可可 × 綠光鮮奶
#法芙娜可可鮮奶 重磅歸隊！
苦甜香氣細緻升級，滑順濃郁更迷人
回味「焙」感溫暖的懷抱 ➜ https://milksha.nidin.shop/ 
#迷客夏 #milksha #為了你嚴選每一杯 #濃焙茶 #重磅回歸', '2025-11-13 00:00:00', 146);
INSERT INTO public.marketing_content VALUES (319, 6, 'IG', '[Text] 娜杯桂香拿鐵', '\首款花香基調 —「桂香茶境」𝟭𝟭/𝟱 桂香四溢/
花香與茶香的邂逅
#娜杯桂香拿鐵
花香、茶香、奶香交織出圓潤細滑的優雅風味
#桂香青檸粉粿
搭配𝗤彈粉粿，一口沁香爽感
桂花香氣融合青茶與檸檬微酸
#桂香原片青
嚴選台灣原片青茶結合金桂甜韻
清爽甘醇如微風拂過花園
#桂香輕蕎麥
蕎麥穀香交織桂花柔香
溫潤回甘、無咖啡因的療癒系飲品
迷客夏首款花香系𝗤彈粉粿登場.ᐟ
#桂香粉粿
每一口都散發柔香餘韻，搭配各式茶飲都超加分
立即沉浸在桂香茶境中
https://reurl.cc/pKd0mx 
#迷客夏 #milksha #喝一口繼續走 #桂香茶境', '2025-11-04 00:00:00', 111);
INSERT INTO public.marketing_content VALUES (320, 6, 'IG', '[Text] 桂香原片青', '\首款花香基調 —「桂香茶境」𝟭𝟭/𝟱 桂香四溢/
花香與茶香的邂逅
#娜杯桂香拿鐵
花香、茶香、奶香交織出圓潤細滑的優雅風味
#桂香青檸粉粿
搭配𝗤彈粉粿，一口沁香爽感
桂花香氣融合青茶與檸檬微酸
#桂香原片青
嚴選台灣原片青茶結合金桂甜韻
清爽甘醇如微風拂過花園
#桂香輕蕎麥
蕎麥穀香交織桂花柔香
溫潤回甘、無咖啡因的療癒系飲品
迷客夏首款花香系𝗤彈粉粿登場.ᐟ
#桂香粉粿
每一口都散發柔香餘韻，搭配各式茶飲都超加分
立即沉浸在桂香茶境中
https://reurl.cc/pKd0mx 
#迷客夏 #milksha #喝一口繼續走 #桂香茶境', '2025-11-04 00:00:00', 111);
INSERT INTO public.marketing_content VALUES (321, 6, 'IG', '[Text] 桂香輕蕎麥', '\首款花香基調 —「桂香茶境」𝟭𝟭/𝟱 桂香四溢/
花香與茶香的邂逅
#娜杯桂香拿鐵
花香、茶香、奶香交織出圓潤細滑的優雅風味
#桂香青檸粉粿
搭配𝗤彈粉粿，一口沁香爽感
桂花香氣融合青茶與檸檬微酸
#桂香原片青
嚴選台灣原片青茶結合金桂甜韻
清爽甘醇如微風拂過花園
#桂香輕蕎麥
蕎麥穀香交織桂花柔香
溫潤回甘、無咖啡因的療癒系飲品
迷客夏首款花香系𝗤彈粉粿登場.ᐟ
#桂香粉粿
每一口都散發柔香餘韻，搭配各式茶飲都超加分
立即沉浸在桂香茶境中
https://reurl.cc/pKd0mx 
#迷客夏 #milksha #喝一口繼續走 #桂香茶境', '2025-11-04 00:00:00', 111);
INSERT INTO public.marketing_content VALUES (326, 7, 'IG', '[Text] 雙Q', '跨年夜一定要來點「咀嚼系幸福」(〃∀〃)
今年最後一杯＆新年第一杯——
#COMEBUY #沖繩黑糖奶茶
雙𝗤𝟭號（珍珠＋粉條）
—— 甜度僅靠黑糖
半糖以上最有味 ♡
𝗤彈、軟糯、焦香、濃奶一次登場
比煙火還療癒的口感衝擊就在這刻炸開
跨年的願望不一定要很偉大：
喝到好喝的
心情甜一點
明年更順一點
迎向 𝟮𝟬𝟮𝟲，讓暖甜先替你開個好頭吧～
這杯就能全包辦 (๑˃ᴗ˂) و♡
#跨年 #新年必喝 #雙Q 咀嚼控集合
#黑糖不另外加糖 #半糖以上最有味
𝗠𝗲𝗿𝗿𝘆 𝗖𝗵𝗿𝗶𝘀𝘁𝗺𝗮𝘀 
 
聖誕快樂呀大家 (ﾉ>▽<)ﾉ', '2025-12-31 00:00:00', 20);
INSERT INTO public.marketing_content VALUES (327, 7, 'IG', '[Text] 沖繩黑糖奶茶', '今天就讓一杯暖甜的 #沖繩黑糖系列
陪你一起度過最閃亮的節日吧～
透過完美比例與台灣黑糖蔗香融合
焦香 × 奶香 × 茶香 層層堆疊
喝一口直接：天啊也太幸福了吧 (๑´ڡ`๑)
和最重要的朋友在這一天相聚
一杯暖暖黑糖飲＝完美儀式感 ♡ 
#沖繩黑糖奶茶 #沖繩黑糖奶綠
#黑糖紅茶拿鐵 #黑糖港式厚奶
#聖誕節快樂 #暖心必喝 #無可取代的單杯現萃', '2025-12-25 00:00:00', 15);
INSERT INTO public.marketing_content VALUES (328, 7, 'IG', '[Text] 黑糖港式厚奶', '今天就讓一杯暖甜的 #沖繩黑糖系列
陪你一起度過最閃亮的節日吧～
透過完美比例與台灣黑糖蔗香融合
焦香 × 奶香 × 茶香 層層堆疊
喝一口直接：天啊也太幸福了吧 (๑´ڡ`๑)
和最重要的朋友在這一天相聚
一杯暖暖黑糖飲＝完美儀式感 ♡ 
#沖繩黑糖奶茶 #沖繩黑糖奶綠
#黑糖紅茶拿鐵 #黑糖港式厚奶
#聖誕節快樂 #暖心必喝 #無可取代的單杯現萃', '2025-12-25 00:00:00', 15);
INSERT INTO public.marketing_content VALUES (329, 7, 'IG', '[Text] 黑糖紅茶拿鐵', '今天就讓一杯暖甜的 #沖繩黑糖系列
陪你一起度過最閃亮的節日吧～
透過完美比例與台灣黑糖蔗香融合
焦香 × 奶香 × 茶香 層層堆疊
喝一口直接：天啊也太幸福了吧 (๑´ڡ`๑)
和最重要的朋友在這一天相聚
一杯暖暖黑糖飲＝完美儀式感 ♡ 
#沖繩黑糖奶茶 #沖繩黑糖奶綠
#黑糖紅茶拿鐵 #黑糖港式厚奶
#聖誕節快樂 #暖心必喝 #無可取代的單杯現萃', '2025-12-25 00:00:00', 15);
INSERT INTO public.marketing_content VALUES (330, 7, 'IG', '[Text] 沖繩黑糖奶綠', '今天就讓一杯暖甜的 #沖繩黑糖系列
陪你一起度過最閃亮的節日吧～
透過完美比例與台灣黑糖蔗香融合
焦香 × 奶香 × 茶香 層層堆疊
喝一口直接：天啊也太幸福了吧 (๑´ڡ`๑)
和最重要的朋友在這一天相聚
一杯暖暖黑糖飲＝完美儀式感 ♡ 
#沖繩黑糖奶茶 #沖繩黑糖奶綠
#黑糖紅茶拿鐵 #黑糖港式厚奶
#聖誕節快樂 #暖心必喝 #無可取代的單杯現萃', '2025-12-25 00:00:00', 15);
INSERT INTO public.marketing_content VALUES (331, 7, 'IG', '[Text] 港式厚奶', '今天就讓一杯暖甜的 #沖繩黑糖系列
陪你一起度過最閃亮的節日吧～
透過完美比例與台灣黑糖蔗香融合
焦香 × 奶香 × 茶香 層層堆疊
喝一口直接：天啊也太幸福了吧 (๑´ڡ`๑)
和最重要的朋友在這一天相聚
一杯暖暖黑糖飲＝完美儀式感 ♡ 
#沖繩黑糖奶茶 #沖繩黑糖奶綠
#黑糖紅茶拿鐵 #黑糖港式厚奶
#聖誕節快樂 #暖心必喝 #無可取代的單杯現萃', '2025-12-25 00:00:00', 15);
INSERT INTO public.marketing_content VALUES (332, 7, 'IG', '[Text] 沖繩黑糖奶茶', '\\ 期盼の新品來了 //
熬煮香氣升級的【沖繩黑糖系列】全新上市
喝一口就知道——這次真的很可以 (*´∀`)ﾉ
融合台灣黑糖蔗香，堆疊出馥郁焦糖香氣
#沖繩黑糖奶茶 $𝟲𝟬(𝗟)
台灣黑糖 × 沖繩黑糖，融入錫蘭紅茶與醇厚奶香，
#沖繩黑糖奶綠 $𝟲𝟬(𝗟)
馥郁焦糖香交織甜潤奶茶，香濃不膩、飽滿順口！
雙黑糖結合醺香綠茶與奶香，
#黑糖紅茶拿鐵 $𝟳𝟱(𝗟)
散發焦糖香氣，茶感清爽、奶韻柔和的完美平衡！
現泡烏瓦紅茶＋鮮乳，茶香濃厚香醇；
#黑糖港式厚奶 $𝟴𝟬(𝗠)
雙黑糖提味，焦香迷人卻不膩口，是鮮奶茶愛好者首選！
現泡錫蘭紅茶混淡奶打造港式厚實口感，
搭配雙黑糖提升焦甜層次，濃郁茶香與滑順奶韻一次到位！
#新品上市 #沖繩融合台灣黑糖 #馥郁焦糖香
#無可取代的單杯現萃 #半糖以上風味最佳 #暖心登場
⧁ 加入官方𝗟𝗜𝗡𝗘點連結拿𝟵折券 ➙ https://comebuy.pse.is/74g326
—
⧁ 全台門市據點 ➙ https://lihi1.com/9IiXS
⧁ 門市菜單 ➙ https://lihi1.com/xbX73', '2025-12-19 00:00:00', 26);
INSERT INTO public.marketing_content VALUES (333, 7, 'IG', '[Text] 黑糖港式厚奶', '\\ 期盼の新品來了 //
熬煮香氣升級的【沖繩黑糖系列】全新上市
喝一口就知道——這次真的很可以 (*´∀`)ﾉ
融合台灣黑糖蔗香，堆疊出馥郁焦糖香氣
#沖繩黑糖奶茶 $𝟲𝟬(𝗟)
台灣黑糖 × 沖繩黑糖，融入錫蘭紅茶與醇厚奶香，
#沖繩黑糖奶綠 $𝟲𝟬(𝗟)
馥郁焦糖香交織甜潤奶茶，香濃不膩、飽滿順口！
雙黑糖結合醺香綠茶與奶香，
#黑糖紅茶拿鐵 $𝟳𝟱(𝗟)
散發焦糖香氣，茶感清爽、奶韻柔和的完美平衡！
現泡烏瓦紅茶＋鮮乳，茶香濃厚香醇；
#黑糖港式厚奶 $𝟴𝟬(𝗠)
雙黑糖提味，焦香迷人卻不膩口，是鮮奶茶愛好者首選！
現泡錫蘭紅茶混淡奶打造港式厚實口感，
搭配雙黑糖提升焦甜層次，濃郁茶香與滑順奶韻一次到位！
#新品上市 #沖繩融合台灣黑糖 #馥郁焦糖香
#無可取代的單杯現萃 #半糖以上風味最佳 #暖心登場
⧁ 加入官方𝗟𝗜𝗡𝗘點連結拿𝟵折券 ➙ https://comebuy.pse.is/74g326
—
⧁ 全台門市據點 ➙ https://lihi1.com/9IiXS
⧁ 門市菜單 ➙ https://lihi1.com/xbX73', '2025-12-19 00:00:00', 26);
INSERT INTO public.marketing_content VALUES (334, 7, 'IG', '[Text] 黑糖紅茶拿鐵', '\\ 期盼の新品來了 //
熬煮香氣升級的【沖繩黑糖系列】全新上市
喝一口就知道——這次真的很可以 (*´∀`)ﾉ
融合台灣黑糖蔗香，堆疊出馥郁焦糖香氣
#沖繩黑糖奶茶 $𝟲𝟬(𝗟)
台灣黑糖 × 沖繩黑糖，融入錫蘭紅茶與醇厚奶香，
#沖繩黑糖奶綠 $𝟲𝟬(𝗟)
馥郁焦糖香交織甜潤奶茶，香濃不膩、飽滿順口！
雙黑糖結合醺香綠茶與奶香，
#黑糖紅茶拿鐵 $𝟳𝟱(𝗟)
散發焦糖香氣，茶感清爽、奶韻柔和的完美平衡！
現泡烏瓦紅茶＋鮮乳，茶香濃厚香醇；
#黑糖港式厚奶 $𝟴𝟬(𝗠)
雙黑糖提味，焦香迷人卻不膩口，是鮮奶茶愛好者首選！
現泡錫蘭紅茶混淡奶打造港式厚實口感，
搭配雙黑糖提升焦甜層次，濃郁茶香與滑順奶韻一次到位！
#新品上市 #沖繩融合台灣黑糖 #馥郁焦糖香
#無可取代的單杯現萃 #半糖以上風味最佳 #暖心登場
⧁ 加入官方𝗟𝗜𝗡𝗘點連結拿𝟵折券 ➙ https://comebuy.pse.is/74g326
—
⧁ 全台門市據點 ➙ https://lihi1.com/9IiXS
⧁ 門市菜單 ➙ https://lihi1.com/xbX73', '2025-12-19 00:00:00', 26);
INSERT INTO public.marketing_content VALUES (352, 8, 'IG', '[Text] 普洱咖啡奶茶', '龜記茗品×  樂步le brewlife
當茶遇上咖啡，碰撞出這個秋冬最獨特的香氣
龜記攜手不斷挑戰與創新的樂步 le brewlife，
雙品牌貫徹重視的「品質」與「生活感」，
打破手搖飲的傳統框架。
結合樂步的義式濃醇咖啡
融合順滑奶感，帶出濃郁溫暖的冬季限定特調。
驚喜又充滿細節與質感的風味，
完美展現兩個品牌的堅持與講究。
溫馨提醒：本產品以 100% 純咖啡液製成，咖啡液中含有多酚類等活性成分，在儲存
過程中可能產生微量沉澱，屬於正常現象不影響品質，為天然純咖啡的特徵之一。
#龜記 #GUIJI #樂步 #lebrewlife #普洱 #咖啡 #普洱咖啡奶茶 #普洱咖啡鮮乳', '2025-10-28 00:00:00', 110);
INSERT INTO public.marketing_content VALUES (335, 7, 'IG', '[Text] 沖繩黑糖奶綠', '\\ 期盼の新品來了 //
熬煮香氣升級的【沖繩黑糖系列】全新上市
喝一口就知道——這次真的很可以 (*´∀`)ﾉ
融合台灣黑糖蔗香，堆疊出馥郁焦糖香氣
#沖繩黑糖奶茶 $𝟲𝟬(𝗟)
台灣黑糖 × 沖繩黑糖，融入錫蘭紅茶與醇厚奶香，
#沖繩黑糖奶綠 $𝟲𝟬(𝗟)
馥郁焦糖香交織甜潤奶茶，香濃不膩、飽滿順口！
雙黑糖結合醺香綠茶與奶香，
#黑糖紅茶拿鐵 $𝟳𝟱(𝗟)
散發焦糖香氣，茶感清爽、奶韻柔和的完美平衡！
現泡烏瓦紅茶＋鮮乳，茶香濃厚香醇；
#黑糖港式厚奶 $𝟴𝟬(𝗠)
雙黑糖提味，焦香迷人卻不膩口，是鮮奶茶愛好者首選！
現泡錫蘭紅茶混淡奶打造港式厚實口感，
搭配雙黑糖提升焦甜層次，濃郁茶香與滑順奶韻一次到位！
#新品上市 #沖繩融合台灣黑糖 #馥郁焦糖香
#無可取代的單杯現萃 #半糖以上風味最佳 #暖心登場
⧁ 加入官方𝗟𝗜𝗡𝗘點連結拿𝟵折券 ➙ https://comebuy.pse.is/74g326
—
⧁ 全台門市據點 ➙ https://lihi1.com/9IiXS
⧁ 門市菜單 ➙ https://lihi1.com/xbX73', '2025-12-19 00:00:00', 26);
INSERT INTO public.marketing_content VALUES (337, 7, 'IG', '[Text] 小葉紅拿鐵', '\ 葉~~~~~~~~真的回來了.ᐟ.ᐟ /
國際連鎖品牌中 #COMEBUY 全球首賣
限量嫩採的《小葉紅茶》重磅回歸
在地好茶就是要 #現萃 才好喝 (✪ω✪)
#小葉紅茶 $𝟱𝟬(𝗟)
一起品味頂級紅茶、享受質感生活
嚴選南投縣名間鄉嫩採的四季春重發酵製成
#小葉紅奶茶 $𝟳𝟬(𝗟)
擁有獨特果蜜香，茶湯溫潤、細緻高雅、不苦不澀！
滋味柔順、甘甜順口的小葉紅茶混入奶精粉
#小葉紅拿鐵 $𝟳𝟱(𝗟)
昇華香醇豐厚口感，奶茶控必喝！
順口回甘小葉紅茶加入香醇鮮奶
成為健康族群最愛的頂級鮮奶茶！
#季節限定 #四季春 #高品質 #紅茶 #限量嫩採
#無可取代的單杯現萃 #限來店購買 #售完為止
⧁ 加入官方𝗟𝗜𝗡𝗘點連結拿𝟵折券 ➙ https://comebuy.pse.is/74g326
—
⧁ 全台門市據點 ➙ https://lihi1.com/9IiXS
⧁ 門市菜單 ➙ https://lihi1.com/xbX73', '2025-11-06 00:00:00', 28);
INSERT INTO public.marketing_content VALUES (338, 7, 'IG', '[Text] 小葉紅奶茶', '\ 葉~~~~~~~~真的回來了.ᐟ.ᐟ /
國際連鎖品牌中 #COMEBUY 全球首賣
限量嫩採的《小葉紅茶》重磅回歸
在地好茶就是要 #現萃 才好喝 (✪ω✪)
#小葉紅茶 $𝟱𝟬(𝗟)
一起品味頂級紅茶、享受質感生活
嚴選南投縣名間鄉嫩採的四季春重發酵製成
#小葉紅奶茶 $𝟳𝟬(𝗟)
擁有獨特果蜜香，茶湯溫潤、細緻高雅、不苦不澀！
滋味柔順、甘甜順口的小葉紅茶混入奶精粉
#小葉紅拿鐵 $𝟳𝟱(𝗟)
昇華香醇豐厚口感，奶茶控必喝！
順口回甘小葉紅茶加入香醇鮮奶
成為健康族群最愛的頂級鮮奶茶！
#季節限定 #四季春 #高品質 #紅茶 #限量嫩採
#無可取代的單杯現萃 #限來店購買 #售完為止
⧁ 加入官方𝗟𝗜𝗡𝗘點連結拿𝟵折券 ➙ https://comebuy.pse.is/74g326
—
⧁ 全台門市據點 ➙ https://lihi1.com/9IiXS
⧁ 門市菜單 ➙ https://lihi1.com/xbX73', '2025-11-06 00:00:00', 28);
INSERT INTO public.marketing_content VALUES (339, 7, 'IG', '[Text] 小葉紅茶', '\ 葉~~~~~~~~真的回來了.ᐟ.ᐟ /
國際連鎖品牌中 #COMEBUY 全球首賣
限量嫩採的《小葉紅茶》重磅回歸
在地好茶就是要 #現萃 才好喝 (✪ω✪)
#小葉紅茶 $𝟱𝟬(𝗟)
一起品味頂級紅茶、享受質感生活
嚴選南投縣名間鄉嫩採的四季春重發酵製成
#小葉紅奶茶 $𝟳𝟬(𝗟)
擁有獨特果蜜香，茶湯溫潤、細緻高雅、不苦不澀！
滋味柔順、甘甜順口的小葉紅茶混入奶精粉
#小葉紅拿鐵 $𝟳𝟱(𝗟)
昇華香醇豐厚口感，奶茶控必喝！
順口回甘小葉紅茶加入香醇鮮奶
成為健康族群最愛的頂級鮮奶茶！
#季節限定 #四季春 #高品質 #紅茶 #限量嫩採
#無可取代的單杯現萃 #限來店購買 #售完為止
⧁ 加入官方𝗟𝗜𝗡𝗘點連結拿𝟵折券 ➙ https://comebuy.pse.is/74g326
—
⧁ 全台門市據點 ➙ https://lihi1.com/9IiXS
⧁ 門市菜單 ➙ https://lihi1.com/xbX73', '2025-11-06 00:00:00', 28);
INSERT INTO public.marketing_content VALUES (340, 7, 'IG', '[Text] 四季春', '\ 葉~~~~~~~~真的回來了.ᐟ.ᐟ /
國際連鎖品牌中 #COMEBUY 全球首賣
限量嫩採的《小葉紅茶》重磅回歸
在地好茶就是要 #現萃 才好喝 (✪ω✪)
#小葉紅茶 $𝟱𝟬(𝗟)
一起品味頂級紅茶、享受質感生活
嚴選南投縣名間鄉嫩採的四季春重發酵製成
#小葉紅奶茶 $𝟳𝟬(𝗟)
擁有獨特果蜜香，茶湯溫潤、細緻高雅、不苦不澀！
滋味柔順、甘甜順口的小葉紅茶混入奶精粉
#小葉紅拿鐵 $𝟳𝟱(𝗟)
昇華香醇豐厚口感，奶茶控必喝！
順口回甘小葉紅茶加入香醇鮮奶
成為健康族群最愛的頂級鮮奶茶！
#季節限定 #四季春 #高品質 #紅茶 #限量嫩採
#無可取代的單杯現萃 #限來店購買 #售完為止
⧁ 加入官方𝗟𝗜𝗡𝗘點連結拿𝟵折券 ➙ https://comebuy.pse.is/74g326
—
⧁ 全台門市據點 ➙ https://lihi1.com/9IiXS
⧁ 門市菜單 ➙ https://lihi1.com/xbX73', '2025-11-06 00:00:00', 28);
INSERT INTO public.marketing_content VALUES (342, 7, 'IG', '[Text] 玩火', '萬聖節最「火」裝扮出爐
南瓜人都來 #COMEBUY 報到啦
玩火不只好喝～還能當配件（誤
）
擁有熱帶水果風味的黃金茶湯
讓你成為派對裡最亮眼的焦點
今年萬聖節 ——
不喝茶就搗蛋 ლ(>д< ლ)
#萬聖節快樂 #無可取代的單杯現萃 #現萃驚艷
⧁ 全台門市據點 ➙ https://lihi1.com/9IiXS
—
⧁ 門市菜單 ➙ https://lihi1.com/xbX73', '2025-10-29 00:00:00', 10);
INSERT INTO public.marketing_content VALUES (343, 7, 'IG', '[Text] 玩火玩火奶茶', '中秋節不只要烤肉
更要 #玩火
一家烤肉萬家香
一杯 #現萃 超沁爽.ᐟ.ᐟ
嚴選甘甜煎茶與清香烏龍
混拼百香果、芒果等熱帶水果風味烘製
果香四溢中透著淡淡蘭花香(๑´ڡ`๑)
𝟭𝟬/𝟭𝟱前至全台 𝗖𝗢𝗠𝗘𝗕𝗨𝗬 門市
門市現場
限量活動
免費加入 #船井生醫 FIP100 纖維粉𝟭包（升級纖萃
）
現場消費【玩火/玩火奶茶】任一杯即可獲得...
再加碼送完整𝗣𝗘包裝𝟭包帶回家
（詳細活動說明 ➙ https://reurl.cc/yAVYpq ）
不管你是牛小排派還是香腸控
能完美收尾你的烤肉大餐ヽ(●´∀`●)ﾉ
這杯果香 × 清爽 × 纖維滿分
今年就讓 #COMEBUY 陪你「火」力全開！
#纖萃玩火 #纖萃玩火奶茶
#中秋節 #中秋烤肉配好茶
⧁ 詳細FIP100 纖維粉說明 ➙ https://www.funaicare.com/products/burner-
—
⧁ 全台門市據點 ➙ https://lihi1.com/9IiXS
bv15
⧁ 門市菜單 ➙ https://lihi1.com/xbX73
❝火❞了𝟮𝟬年的經典現萃', '2025-10-03 00:00:00', 31);
INSERT INTO public.marketing_content VALUES (344, 7, 'IG', '[Text] 纖萃玩火奶茶', '中秋節不只要烤肉
更要 #玩火
一家烤肉萬家香
一杯 #現萃 超沁爽.ᐟ.ᐟ
嚴選甘甜煎茶與清香烏龍
混拼百香果、芒果等熱帶水果風味烘製
果香四溢中透著淡淡蘭花香(๑´ڡ`๑)
𝟭𝟬/𝟭𝟱前至全台 𝗖𝗢𝗠𝗘𝗕𝗨𝗬 門市
門市現場
限量活動
免費加入 #船井生醫 FIP100 纖維粉𝟭包（升級纖萃
）
現場消費【玩火/玩火奶茶】任一杯即可獲得...
再加碼送完整𝗣𝗘包裝𝟭包帶回家
（詳細活動說明 ➙ https://reurl.cc/yAVYpq ）
不管你是牛小排派還是香腸控
能完美收尾你的烤肉大餐ヽ(●´∀`●)ﾉ
這杯果香 × 清爽 × 纖維滿分
今年就讓 #COMEBUY 陪你「火」力全開！
#纖萃玩火 #纖萃玩火奶茶
#中秋節 #中秋烤肉配好茶
⧁ 詳細FIP100 纖維粉說明 ➙ https://www.funaicare.com/products/burner-
—
⧁ 全台門市據點 ➙ https://lihi1.com/9IiXS
bv15
⧁ 門市菜單 ➙ https://lihi1.com/xbX73
❝火❞了𝟮𝟬年的經典現萃', '2025-10-03 00:00:00', 31);
INSERT INTO public.marketing_content VALUES (345, 7, 'IG', '[Text] 玩火奶茶', '中秋節不只要烤肉
更要 #玩火
一家烤肉萬家香
一杯 #現萃 超沁爽.ᐟ.ᐟ
嚴選甘甜煎茶與清香烏龍
混拼百香果、芒果等熱帶水果風味烘製
果香四溢中透著淡淡蘭花香(๑´ڡ`๑)
𝟭𝟬/𝟭𝟱前至全台 𝗖𝗢𝗠𝗘𝗕𝗨𝗬 門市
門市現場
限量活動
免費加入 #船井生醫 FIP100 纖維粉𝟭包（升級纖萃
）
現場消費【玩火/玩火奶茶】任一杯即可獲得...
再加碼送完整𝗣𝗘包裝𝟭包帶回家
（詳細活動說明 ➙ https://reurl.cc/yAVYpq ）
不管你是牛小排派還是香腸控
能完美收尾你的烤肉大餐ヽ(●´∀`●)ﾉ
這杯果香 × 清爽 × 纖維滿分
今年就讓 #COMEBUY 陪你「火」力全開！
#纖萃玩火 #纖萃玩火奶茶
#中秋節 #中秋烤肉配好茶
⧁ 詳細FIP100 纖維粉說明 ➙ https://www.funaicare.com/products/burner-
—
⧁ 全台門市據點 ➙ https://lihi1.com/9IiXS
bv15
⧁ 門市菜單 ➙ https://lihi1.com/xbX73
❝火❞了𝟮𝟬年的經典現萃', '2025-10-03 00:00:00', 31);
INSERT INTO public.marketing_content VALUES (346, 7, 'IG', '[Text] 玩火', '中秋節不只要烤肉
更要 #玩火
一家烤肉萬家香
一杯 #現萃 超沁爽.ᐟ.ᐟ
嚴選甘甜煎茶與清香烏龍
混拼百香果、芒果等熱帶水果風味烘製
果香四溢中透著淡淡蘭花香(๑´ڡ`๑)
𝟭𝟬/𝟭𝟱前至全台 𝗖𝗢𝗠𝗘𝗕𝗨𝗬 門市
門市現場
限量活動
免費加入 #船井生醫 FIP100 纖維粉𝟭包（升級纖萃
）
現場消費【玩火/玩火奶茶】任一杯即可獲得...
再加碼送完整𝗣𝗘包裝𝟭包帶回家
（詳細活動說明 ➙ https://reurl.cc/yAVYpq ）
不管你是牛小排派還是香腸控
能完美收尾你的烤肉大餐ヽ(●´∀`●)ﾉ
這杯果香 × 清爽 × 纖維滿分
今年就讓 #COMEBUY 陪你「火」力全開！
#纖萃玩火 #纖萃玩火奶茶
#中秋節 #中秋烤肉配好茶
⧁ 詳細FIP100 纖維粉說明 ➙ https://www.funaicare.com/products/burner-
—
⧁ 全台門市據點 ➙ https://lihi1.com/9IiXS
bv15
⧁ 門市菜單 ➙ https://lihi1.com/xbX73
❝火❞了𝟮𝟬年的經典現萃', '2025-10-03 00:00:00', 31);
INSERT INTO public.marketing_content VALUES (347, 7, 'IG', '[Text] 玩火奶茶', '沒時間飛
就喝這杯
外面找不到的獨特風味——
喝一口彷彿置身❝熱帶❞島嶼
#玩火 $𝟰𝟱(𝗟)
建議半糖以上最好喝
嚴選甘甜煎茶與產自春天高山上的清香烏龍茶
混拼百香果、芒果等熱帶水果風味烘製而成
#玩火奶茶 $𝟲𝟱(𝗟)
獨家黃金茶湯喝得到水果香氣與淡淡蘭花香！
嚴選甘甜煎茶與清香烏龍茶調製奶茶
帶有熱帶水果香氣與淡淡蘭花香
讓奶茶風味獨特又清爽不膩！
#無可取代的單杯現萃 就在 #COMEBUY
⧁ 加入官方𝗟𝗜𝗡𝗘點連結拿𝟵折券 ➙ https://comebuy.pse.is/74g326
—
⧁ 全台門市據點 ➙ https://lihi1.com/9IiXS
⧁ 門市菜單 ➙ https://lihi1.com/xbX73', '2025-09-19 00:00:00', 21);
INSERT INTO public.marketing_content VALUES (348, 7, 'IG', '[Text] 玩火', '沒時間飛
就喝這杯
外面找不到的獨特風味——
喝一口彷彿置身❝熱帶❞島嶼
#玩火 $𝟰𝟱(𝗟)
建議半糖以上最好喝
嚴選甘甜煎茶與產自春天高山上的清香烏龍茶
混拼百香果、芒果等熱帶水果風味烘製而成
#玩火奶茶 $𝟲𝟱(𝗟)
獨家黃金茶湯喝得到水果香氣與淡淡蘭花香！
嚴選甘甜煎茶與清香烏龍茶調製奶茶
帶有熱帶水果香氣與淡淡蘭花香
讓奶茶風味獨特又清爽不膩！
#無可取代的單杯現萃 就在 #COMEBUY
⧁ 加入官方𝗟𝗜𝗡𝗘點連結拿𝟵折券 ➙ https://comebuy.pse.is/74g326
—
⧁ 全台門市據點 ➙ https://lihi1.com/9IiXS
⧁ 門市菜單 ➙ https://lihi1.com/xbX73', '2025-09-19 00:00:00', 21);
INSERT INTO public.marketing_content VALUES (349, 8, 'IG', '[Text] 普洱咖啡奶茶', '普洱咖啡奶茶、普洱咖啡鮮乳
今日上市
呈現秋冬限定新品
碎銀普洱厚韻×義式濃醇咖啡
交織出溫暖成熟的獨特風味
季節限定不要錯過( ˶ˊᵕˋ)੭♡ 
↟.｡.:*･↟
本產品以 100% 純咖啡液製成，咖啡液中含有多酚類等活性成分，在儲存過程中
可能產生微量沉澱，屬於正常現象不影響品質，為天然純咖啡的特徵之一。
#龜記 #GUIJI #樂步 #lebrewlife #普洱 #咖啡 #普洱咖啡奶茶 #普洱咖啡鮮乳', '2025-11-01 00:00:00', 54);
INSERT INTO public.marketing_content VALUES (350, 8, 'IG', '[Text] 普洱', '普洱咖啡奶茶、普洱咖啡鮮乳
今日上市
呈現秋冬限定新品
碎銀普洱厚韻×義式濃醇咖啡
交織出溫暖成熟的獨特風味
季節限定不要錯過( ˶ˊᵕˋ)੭♡ 
↟.｡.:*･↟
本產品以 100% 純咖啡液製成，咖啡液中含有多酚類等活性成分，在儲存過程中
可能產生微量沉澱，屬於正常現象不影響品質，為天然純咖啡的特徵之一。
#龜記 #GUIJI #樂步 #lebrewlife #普洱 #咖啡 #普洱咖啡奶茶 #普洱咖啡鮮乳', '2025-11-01 00:00:00', 54);
INSERT INTO public.marketing_content VALUES (353, 8, 'IG', '[Text] 普洱', '龜記茗品×  樂步le brewlife
當茶遇上咖啡，碰撞出這個秋冬最獨特的香氣
龜記攜手不斷挑戰與創新的樂步 le brewlife，
雙品牌貫徹重視的「品質」與「生活感」，
打破手搖飲的傳統框架。
結合樂步的義式濃醇咖啡
融合順滑奶感，帶出濃郁溫暖的冬季限定特調。
驚喜又充滿細節與質感的風味，
完美展現兩個品牌的堅持與講究。
溫馨提醒：本產品以 100% 純咖啡液製成，咖啡液中含有多酚類等活性成分，在儲存
過程中可能產生微量沉澱，屬於正常現象不影響品質，為天然純咖啡的特徵之一。
#龜記 #GUIJI #樂步 #lebrewlife #普洱 #咖啡 #普洱咖啡奶茶 #普洱咖啡鮮乳', '2025-10-28 00:00:00', 110);
INSERT INTO public.marketing_content VALUES (355, 8, 'IG', '[Text] 蜂蜜花沫烏龍', '中秋烤肉聚會多
就是清爽的飲料該登場的時候
10/3 (五)~10/6（一）
中秋節限定活動，
購買兩杯蜂蜜花沫烏龍，就送一杯花沫烏龍
活動注意事項☆.｡.
限龜記門市現場+電話自取、龜記線上點自取享有
一般外送與外送平台皆不適用此活動
單筆消費可累贈（買2 送1、買4 送2，依此類推）
#龜記 #GUIJI #中秋 #烏龍 #花沫烏龍 #蜂蜜 #蜂蜜花沫烏龍', '2025-10-01 00:00:00', 55);
INSERT INTO public.marketing_content VALUES (356, 8, 'IG', '[Text] 花沫烏龍', '中秋烤肉聚會多
就是清爽的飲料該登場的時候
10/3 (五)~10/6（一）
中秋節限定活動，
購買兩杯蜂蜜花沫烏龍，就送一杯花沫烏龍
活動注意事項☆.｡.
限龜記門市現場+電話自取、龜記線上點自取享有
一般外送與外送平台皆不適用此活動
單筆消費可累贈（買2 送1、買4 送2，依此類推）
#龜記 #GUIJI #中秋 #烏龍 #花沫烏龍 #蜂蜜 #蜂蜜花沫烏龍', '2025-10-01 00:00:00', 55);
INSERT INTO public.marketing_content VALUES (358, 8, 'IG', '[Text] 三十三茶王', '荔枝茶王今日上市
-
荔枝果肉＋茶王茶湯＝完美組合
季節限定不要錯過٩꒰｡•◡•｡꒱۶
一起夏末的微風裡，品嚐酸甜滋味
⧁ 圖為示意參考，請以現場實物為準
-
#龜記 #GUIJI #新品 #荔枝 #三十三茶王 #荔枝茶王', '2025-09-15 00:00:00', 51);
INSERT INTO public.marketing_content VALUES (359, 1, 'IG', '[Text] 星桃樂翡翠', '召喚神龍的時刻到來！
龜記推出夏季聯名限定補氣飲品：『星桃樂翡翠』
加入功夫茶清爽芭樂果泥與龜記古早味楊桃蜜
層層果香堆疊，酸甜中帶茶香回甘
一口喝下如氣流直擊味蕾
還有聯名限定熱血周邊
從飲料杯身到保冷袋，從吸管塞到水壺提帶，
每一樣都值得粉絲們「集氣收藏」
活動期間｜𝟐𝟎𝟐𝟓/𝟎𝟕/𝟎𝟏 - 𝟐𝟎𝟐𝟓/𝟎𝟖/𝟑𝟏
限定活動第➊波：滿額贈禮
購買『星桃樂翡翠』 乙杯＋任一龜記飲品乙杯
即可獲得【七龍珠 大魔 ✕ 龜記 ✕ 功夫茶 保冷袋】乙個
數量有限，每人每筆限贈一次
電話預訂、外送及外送平台不適用
這個夏天，集氣開喝、召喚神龍，
＃龜記 #GUIJI #功夫茶 #聯名活動 #星桃樂翡翠 #楊桃 ＃芭樂 ＃期間限定企劃 #七
龍珠大魔', '2025-07-01 00:00:00', 96);
INSERT INTO public.marketing_content VALUES (360, 8, 'IG', '[Text] 紅柚翡翠', '龜蜜相揪過端午
限時優惠別錯過
- 
𝟓 / 𝟑𝟎 ( 五 ) ～ 𝟔 / 𝟏 ( 日 )
⋯紅柚翡翠 2 杯 100 元
⋯ 
粽子吃多了難免油膩，搭配清爽解膩的紅柚
絕對是最強儀式感組合
 
限時 3 天優惠，每單限購 3 組
 
⊱ 門市據點：https://lihi.cc/q8S7v 
⊱ 加入會員：https://lihi.cc/sDRhG 
⊱ 線上點餐：https://lihi.cc/xuJqa
- 
⧁ 龜記桃園機場店、臺大醫院店不參與此活動 
⧁ 龜記全台門市「現場購買」與「現場自取」適用
⧁ 不適用於龜記線上點餐/龜記線上點自取/Uber Eats/foodpanda/你訂 外送
平台 
⧁ 各行銷活動、折扣、優惠、龜蜜卡點數折抵不合併使用（環保杯折抵5 元不
在此限）  
#龜記 #GUIJI #紅柚翡翠 #端午節 #優惠 #手搖', '2025-05-29 00:00:00', 93);
INSERT INTO public.marketing_content VALUES (361, 8, 'IG', '[Text] 巨峰葡薈青', '巨峰葡薈青⋯𝟓/𝟏 上市.* ﾟ
魅力新品、炫風來襲！
限量販售
錯過不薈來
融合四季春青茶＋巨峰葡萄汁＋蘆薈 ˊ˗
⊱ 門市據點：https://lihi.cc/q8S7v
年度必試的細膩質感風味
⊱ 加入會員：https://lihi.cc/BKWoU
⊱ 線上點餐：https://lihi.cc/BKWoU
- 
⧁ 圖為示意參考，請以現場實物為準
⧁ 實際販售情況依各門店為主
完售不補貨
#龜記 #GUIJI #新品 #限量販售 #巨峰葡薈青', '2025-04-30 00:00:00', 793);
INSERT INTO public.marketing_content VALUES (362, 8, 'IG', '[Text] 三十三茶王', '冬天是想瘦身最有效的季節
（啪！
-
整理三支小清新飲品給大家⇣
想解膩又怕小肚肚累積脂肪 ˃ ˂ ？
花沫烏龍
很多人不知道～今年夏天超受歡迎的蜜桃烏龍
就是以花沫為茶底喔
味道很清
新、順口，有膩口食物需要搭配的話非常推薦！
蜂蜜綠茶／四季春
龜記使用蜜蜂工坊真蜂蜜
除了是天然糖漿外，蜂蜜還有潤喉、保護心血管等附加
價值，可以依照個人口味挑選茶底
三十三茶王
說到茶系列的熱銷單品
33 絕對榜上有名！老師傅獨家訂製的烘培法，口感回
甘、韻味豐富，重點是喝完不會心悸呀～（龜小編心中 TOP 1 
）
⊱ 門市據點：https://bit.ly/40G8McA
圖片奉上最新的熱量、咖啡因含量表呦
⊱ 加入會員：https://bit.ly/3O0e5vV
⊱ 線上點餐：https://bit.ly/3AwFvGB
#龜記 #GUIJI #推薦 #飲品推薦 #茶飲 #蜂蜜', '2024-12-03 00:00:00', 53);
INSERT INTO public.marketing_content VALUES (363, 8, 'IG', '[Text] 蜜桃烏龍', '冬天是想瘦身最有效的季節
（啪！
-
整理三支小清新飲品給大家⇣
想解膩又怕小肚肚累積脂肪 ˃ ˂ ？
花沫烏龍
很多人不知道～今年夏天超受歡迎的蜜桃烏龍
就是以花沫為茶底喔
味道很清
新、順口，有膩口食物需要搭配的話非常推薦！
蜂蜜綠茶／四季春
龜記使用蜜蜂工坊真蜂蜜
除了是天然糖漿外，蜂蜜還有潤喉、保護心血管等附加
價值，可以依照個人口味挑選茶底
三十三茶王
說到茶系列的熱銷單品
33 絕對榜上有名！老師傅獨家訂製的烘培法，口感回
甘、韻味豐富，重點是喝完不會心悸呀～（龜小編心中 TOP 1 
）
⊱ 門市據點：https://bit.ly/40G8McA
圖片奉上最新的熱量、咖啡因含量表呦
⊱ 加入會員：https://bit.ly/3O0e5vV
⊱ 線上點餐：https://bit.ly/3AwFvGB
#龜記 #GUIJI #推薦 #飲品推薦 #茶飲 #蜂蜜', '2024-12-03 00:00:00', 53);
INSERT INTO public.marketing_content VALUES (364, 8, 'IG', '[Text] 蜂蜜綠茶', '冬天是想瘦身最有效的季節
（啪！
-
整理三支小清新飲品給大家⇣
想解膩又怕小肚肚累積脂肪 ˃ ˂ ？
花沫烏龍
很多人不知道～今年夏天超受歡迎的蜜桃烏龍
就是以花沫為茶底喔
味道很清
新、順口，有膩口食物需要搭配的話非常推薦！
蜂蜜綠茶／四季春
龜記使用蜜蜂工坊真蜂蜜
除了是天然糖漿外，蜂蜜還有潤喉、保護心血管等附加
價值，可以依照個人口味挑選茶底
三十三茶王
說到茶系列的熱銷單品
33 絕對榜上有名！老師傅獨家訂製的烘培法，口感回
甘、韻味豐富，重點是喝完不會心悸呀～（龜小編心中 TOP 1 
）
⊱ 門市據點：https://bit.ly/40G8McA
圖片奉上最新的熱量、咖啡因含量表呦
⊱ 加入會員：https://bit.ly/3O0e5vV
⊱ 線上點餐：https://bit.ly/3AwFvGB
#龜記 #GUIJI #推薦 #飲品推薦 #茶飲 #蜂蜜', '2024-12-03 00:00:00', 53);
INSERT INTO public.marketing_content VALUES (365, 8, 'IG', '[Text] 花沫烏龍', '冬天是想瘦身最有效的季節
（啪！
-
整理三支小清新飲品給大家⇣
想解膩又怕小肚肚累積脂肪 ˃ ˂ ？
花沫烏龍
很多人不知道～今年夏天超受歡迎的蜜桃烏龍
就是以花沫為茶底喔
味道很清
新、順口，有膩口食物需要搭配的話非常推薦！
蜂蜜綠茶／四季春
龜記使用蜜蜂工坊真蜂蜜
除了是天然糖漿外，蜂蜜還有潤喉、保護心血管等附加
價值，可以依照個人口味挑選茶底
三十三茶王
說到茶系列的熱銷單品
33 絕對榜上有名！老師傅獨家訂製的烘培法，口感回
甘、韻味豐富，重點是喝完不會心悸呀～（龜小編心中 TOP 1 
）
⊱ 門市據點：https://bit.ly/40G8McA
圖片奉上最新的熱量、咖啡因含量表呦
⊱ 加入會員：https://bit.ly/3O0e5vV
⊱ 線上點餐：https://bit.ly/3AwFvGB
#龜記 #GUIJI #推薦 #飲品推薦 #茶飲 #蜂蜜', '2024-12-03 00:00:00', 53);
INSERT INTO public.marketing_content VALUES (367, 8, 'IG', '[OCR] 花沫烏龍', '藍波萬啦！No.1 !!!!
-
昨晚真的創造了歷史性的一刻
謝謝你們締造「烏」與倫比的佳績
慶祝中華隊勇奪冠軍！
用細膩的醇粹與花香
感受「烏」與倫比的光榮
- 
⧁ 單筆限購一組
⧁ 限來店臨櫃現場購買，不適用各大外送平台、龜記線上點餐或電話自取
⧁ 活動品項加料需另付費，恕無法更換其他商品
⧁ 部分門店不參與：板橋環球店、新竹SOGO 店、南港中信店、汐止遠雄店、大
巨蛋店、臺大醫院店、台北車站店、統一時代店、南港CITYLINK 店
#龜記 #GUIJI #小人物大生活 #世界12 強棒球錦標賽 #中華隊 #冠軍 #台灣之
光
50 嵐', '2024-11-25 00:00:00', 200);
INSERT INTO public.marketing_content VALUES (368, 8, 'IG', '[Text] 梅綠', '「梅醬出任務，酸甜接力棒！
」 
#旺來系列臨時缺席，梅醬來HOLD 場囉 ^w^ 
門市QA 排行榜：50 嵐 #梅の綠，到底怎麼唸？
梅子綠？ 梅之綠？ 梅綠？ 梅什麼綠？ 那個綠？
 
不論怎麼唸，喝過就忍不住心心念念！
梅の綠：清爽系 
酸甜梅汁配上茉莉花香綠茶，先酸甜後茶香， 
多層風味口感，滿滿戀愛好滋味。
梅の紅：復古系 
香氣細緻的紅茶遇上梅汁，酸甜帶點回甘， 
一秒回到以前柑仔店配話梅的年代～
梅の青：淡雅系 
清香且淡雅的四季春青茶，加入酸甜梅汁， 
連員工都愛的私房搭配，喝得出層次又不會膩！
梅の烏：成熟系 
有焙火香氣的黃金烏龍搭配微酸解膩的梅汁， 
酸甜解膩、茶味相宜，大人味首選非他莫屬！
心動不如馬上行動，找到你的夏日專屬酸甜
 
#50 嵐 #50 嵐中區 #好茶陪伴你的日常 #手搖 #飲料
#梅の綠 #梅の紅 #梅の青 #梅の烏', '2025-05-28 00:00:00', 124);
INSERT INTO public.marketing_content VALUES (369, 8, 'IG', '[Text] 梅紅', '「梅醬出任務，酸甜接力棒！
」 
#旺來系列臨時缺席，梅醬來HOLD 場囉 ^w^ 
門市QA 排行榜：50 嵐 #梅の綠，到底怎麼唸？
梅子綠？ 梅之綠？ 梅綠？ 梅什麼綠？ 那個綠？
 
不論怎麼唸，喝過就忍不住心心念念！
梅の綠：清爽系 
酸甜梅汁配上茉莉花香綠茶，先酸甜後茶香， 
多層風味口感，滿滿戀愛好滋味。
梅の紅：復古系 
香氣細緻的紅茶遇上梅汁，酸甜帶點回甘， 
一秒回到以前柑仔店配話梅的年代～
梅の青：淡雅系 
清香且淡雅的四季春青茶，加入酸甜梅汁， 
連員工都愛的私房搭配，喝得出層次又不會膩！
梅の烏：成熟系 
有焙火香氣的黃金烏龍搭配微酸解膩的梅汁， 
酸甜解膩、茶味相宜，大人味首選非他莫屬！
心動不如馬上行動，找到你的夏日專屬酸甜
 
#50 嵐 #50 嵐中區 #好茶陪伴你的日常 #手搖 #飲料
#梅の綠 #梅の紅 #梅の青 #梅の烏', '2025-05-28 00:00:00', 124);
INSERT INTO public.marketing_content VALUES (370, 8, 'IG', '[Text] 梅青', '「梅醬出任務，酸甜接力棒！
」 
#旺來系列臨時缺席，梅醬來HOLD 場囉 ^w^ 
門市QA 排行榜：50 嵐 #梅の綠，到底怎麼唸？
梅子綠？ 梅之綠？ 梅綠？ 梅什麼綠？ 那個綠？
 
不論怎麼唸，喝過就忍不住心心念念！
梅の綠：清爽系 
酸甜梅汁配上茉莉花香綠茶，先酸甜後茶香， 
多層風味口感，滿滿戀愛好滋味。
梅の紅：復古系 
香氣細緻的紅茶遇上梅汁，酸甜帶點回甘， 
一秒回到以前柑仔店配話梅的年代～
梅の青：淡雅系 
清香且淡雅的四季春青茶，加入酸甜梅汁， 
連員工都愛的私房搭配，喝得出層次又不會膩！
梅の烏：成熟系 
有焙火香氣的黃金烏龍搭配微酸解膩的梅汁， 
酸甜解膩、茶味相宜，大人味首選非他莫屬！
心動不如馬上行動，找到你的夏日專屬酸甜
 
#50 嵐 #50 嵐中區 #好茶陪伴你的日常 #手搖 #飲料
#梅の綠 #梅の紅 #梅の青 #梅の烏', '2025-05-28 00:00:00', 124);
INSERT INTO public.marketing_content VALUES (371, 8, 'IG', '[Text] 多多青', '【時令鮮果首選～情人茶！】
阿嵐發現近期因應氣候關係，金桔常常請假～
為了嵐粉們的酸甜愛戀，真心推薦 #情人茶
鮮榨檸檬×獨家梅醬×茉莉綠茶 黃金組合，
酸得剛好，甜得迷人，清爽不膩，一喝就愛上
阿嵐私房喝法，今天就試試吧 (*´∀`)~
那種鮮酸甜蜜回甘的層次感，就是戀愛的味道！
甜度三分糖以上～戀愛心情百分百！
冰塊微冰或少冰～冰沁入魂包你愛！
偷偷宣傳當月詢問度破表的隱藏飲品 #多多青
養樂多×四季春青茶 酸甜控的你也一定會喜歡！
#50 嵐 #50 嵐中區 #好茶陪伴你的日常 #手搖 #飲料
#情人茶 #8 冰綠 #檸檬 #金桔 #梅醬', '2025-05-07 00:00:00', 1119);
INSERT INTO public.marketing_content VALUES (372, 8, 'IG', '[Text] 情人茶', '【時令鮮果首選～情人茶！】
阿嵐發現近期因應氣候關係，金桔常常請假～
為了嵐粉們的酸甜愛戀，真心推薦 #情人茶
鮮榨檸檬×獨家梅醬×茉莉綠茶 黃金組合，
酸得剛好，甜得迷人，清爽不膩，一喝就愛上
阿嵐私房喝法，今天就試試吧 (*´∀`)~
那種鮮酸甜蜜回甘的層次感，就是戀愛的味道！
甜度三分糖以上～戀愛心情百分百！
冰塊微冰或少冰～冰沁入魂包你愛！
偷偷宣傳當月詢問度破表的隱藏飲品 #多多青
養樂多×四季春青茶 酸甜控的你也一定會喜歡！
#50 嵐 #50 嵐中區 #好茶陪伴你的日常 #手搖 #飲料
#情人茶 #8 冰綠 #檸檬 #金桔 #梅醬', '2025-05-07 00:00:00', 1119);
INSERT INTO public.marketing_content VALUES (373, 8, 'IG', '[Text] 金桔', '【時令鮮果首選～情人茶！】
阿嵐發現近期因應氣候關係，金桔常常請假～
為了嵐粉們的酸甜愛戀，真心推薦 #情人茶
鮮榨檸檬×獨家梅醬×茉莉綠茶 黃金組合，
酸得剛好，甜得迷人，清爽不膩，一喝就愛上
阿嵐私房喝法，今天就試試吧 (*´∀`)~
那種鮮酸甜蜜回甘的層次感，就是戀愛的味道！
甜度三分糖以上～戀愛心情百分百！
冰塊微冰或少冰～冰沁入魂包你愛！
偷偷宣傳當月詢問度破表的隱藏飲品 #多多青
養樂多×四季春青茶 酸甜控的你也一定會喜歡！
#50 嵐 #50 嵐中區 #好茶陪伴你的日常 #手搖 #飲料
#情人茶 #8 冰綠 #檸檬 #金桔 #梅醬', '2025-05-07 00:00:00', 1119);
INSERT INTO public.marketing_content VALUES (374, 8, 'IG', '[Text] 荔枝烏龍', '號外號外 嵐冰友家族擴編中！
嵐氏冰淇淋三種口味～香草/芒果/荔枝
#你最喜歡哪個><
阿嵐大推 冰淇淋系列
①荔枝烏龍
使用細緻荔枝義式雪酪
搭配焙火香氣黃金烏龍
濃郁甘甜 層次再升級
②芒果青
濃郁芒果香甜鮮果雪酪
與四季春青茶完美交織
網友敲網 超經典回歸
③冰淇淋紅茶
綿密香濃的香草冰淇淋
加香醇陳韻阿薩姆紅茶
極品絕配 一口就上癮
#50 嵐 #中區50 嵐 #好茶陪伴你的日常 #手搖 #飲料 #新品 #嵐冰友 #荔枝烏龍 #芒
果青', '2024-08-05 00:00:00', 188);
INSERT INTO public.marketing_content VALUES (375, 8, 'IG', '[Text] 荔枝烏龍', '嵐粉們喝過了嗎？σ`∀´)σ
新品 #嵐冰友 強勢來襲！
必喝的3 個秘密！ #快來看看
全新飲品 #嵐冰友
1. 冰淇淋基底茶可更換～芒果青/綠/紅/烏，荔枝烏龍/綠/青/紅 #任你選
2. 配料自由加～珍珠、波霸、椰果或燕麥 #全免費
3. 杯身貼紙小秘密～荔枝、芒果、香草每個口味都不一樣
#荔枝烏龍 #芒果青 你喜歡哪個？
阿嵐兩個都超喜歡！
入口感受雪酪的沁心透涼，
再品嚐基底茶的質感回甘，
是夏天的一大救贖
#50 嵐 #中區50 嵐 #好茶陪伴你的日常 #手搖 #飲料
#新品 #嵐冰友 #荔枝烏龍 #芒果青
夏季主打 #綠茶專賣店 登場(*´∀`)~
 
十級嵐粉在哪裡～發現招牌的小秘密了嗎？', '2024-08-03 00:00:00', 248);
INSERT INTO public.marketing_content VALUES (376, 8, 'IG', '[Text] 芒果青', '嵐粉們喝過了嗎？σ`∀´)σ
新品 #嵐冰友 強勢來襲！
必喝的3 個秘密！ #快來看看
全新飲品 #嵐冰友
1. 冰淇淋基底茶可更換～芒果青/綠/紅/烏，荔枝烏龍/綠/青/紅 #任你選
2. 配料自由加～珍珠、波霸、椰果或燕麥 #全免費
3. 杯身貼紙小秘密～荔枝、芒果、香草每個口味都不一樣
#荔枝烏龍 #芒果青 你喜歡哪個？
阿嵐兩個都超喜歡！
入口感受雪酪的沁心透涼，
再品嚐基底茶的質感回甘，
是夏天的一大救贖
#50 嵐 #中區50 嵐 #好茶陪伴你的日常 #手搖 #飲料
#新品 #嵐冰友 #荔枝烏龍 #芒果青
夏季主打 #綠茶專賣店 登場(*´∀`)~
 
十級嵐粉在哪裡～發現招牌的小秘密了嗎？', '2024-08-03 00:00:00', 248);
INSERT INTO public.marketing_content VALUES (377, 8, 'IG', '[Text] 波霸綠茶拿鐵', '真正的 #招牌 #茉莉綠茶
 到來！ 
本次主視覺以超元氣的日漫風格 
強調我們滿滿的熱情與專業的搖茶技巧 
綠茶喝一下 清爽喝一夏！ 
三款經典 #綠茶系 飲品～ 必喝！
▷波霸綠茶拿鐵  
典雅奶香加綠茶 尾韻豐厚又清香 
Q 彈口感大滿足 微甜波霸一級棒 
▷冰淇淋綠茶
茉綠尬香草冰淇淋 清爽暢快透心涼 
多重層次超幸福 夏日必喝人氣款
▷多多綠茶 
經典多多配綠茶 微酸微甜超解膩 
炎熱夏日喝一口 完美療癒笑開懷
#50 嵐 #中區50 嵐 #好茶陪伴你的日常 #手搖 #飲料 #夏季主打 #綠茶專賣
店 #波霸綠茶拿鐵', '2024-05-31 00:00:00', 98);
INSERT INTO public.marketing_content VALUES (378, 8, 'IG', '[Text] 茉莉綠茶', '真正的 #招牌 #茉莉綠茶
 到來！ 
本次主視覺以超元氣的日漫風格 
強調我們滿滿的熱情與專業的搖茶技巧 
綠茶喝一下 清爽喝一夏！ 
三款經典 #綠茶系 飲品～ 必喝！
▷波霸綠茶拿鐵  
典雅奶香加綠茶 尾韻豐厚又清香 
Q 彈口感大滿足 微甜波霸一級棒 
▷冰淇淋綠茶
茉綠尬香草冰淇淋 清爽暢快透心涼 
多重層次超幸福 夏日必喝人氣款
▷多多綠茶 
經典多多配綠茶 微酸微甜超解膩 
炎熱夏日喝一口 完美療癒笑開懷
#50 嵐 #中區50 嵐 #好茶陪伴你的日常 #手搖 #飲料 #夏季主打 #綠茶專賣
店 #波霸綠茶拿鐵', '2024-05-31 00:00:00', 98);
INSERT INTO public.marketing_content VALUES (380, 8, 'IG', '[Text] 葡萄柚', '柚，是你～ ！你回來了♡ 
#葡萄柚系列 COME BACK！
少女紅橘色的經典葡萄柚
譜出如夏日戀歌般的滋味
屬於這個季節的限定飲品
是520 不可不喝酸甜滋味♡
季節限定
►鮮柚綠
►葡萄柚汁
►葡萄柚多多
#50 嵐 #50 嵐中區 #葡萄柚系列 #季節限定 #好茶陪伴你的日常', '2024-05-20 00:00:00', 694);
INSERT INTO public.marketing_content VALUES (381, 8, 'IG', '[Text] 珍波椰青茶', '珍波椰青茶升級小祕技d(`･∀･)b
什麼！竟然還可以這樣喝？！
布丁/燕麥/瑪奇朵 加上去超好喝♡ 
幸福指數大大大提升！
快相揪朋友一起來喝～
#50 嵐 #50 嵐中區 #好茶陪伴你的日常 #手搖 #飲料
#春季主打 #嵐a 青春 #珍波椰青茶', '2024-05-18 00:00:00', 1691);
INSERT INTO public.marketing_content VALUES (382, 8, 'IG', '[Text] 珍波椰青茶', '「阿華田」120 歲生日快樂
嵐粉們喜歡在「阿華田」裡加哪些配料呢？
阿嵐最喜歡在裡面加滿滿的燕麥和珍珠了！！
喝完超有飽足感～營養滿點！
聽說阿華田歡慶抽獎活動誠意滿滿！
\\ 完整內容請參閱活動網站說明 //
https://www.ovaltine.com.tw/ovaltine_120celebration/
#50 嵐 #50 嵐中區 #好茶陪伴你的日常 #手搖 #飲料
#歡慶阿華田120 周年瑞士經典不斷電 #阿華田橘色潮食尚美味大探索
本月主打 #珍波椰青茶ヽ(●´∀`●)ﾉ', '2024-05-08 00:00:00', 157);
INSERT INTO public.marketing_content VALUES (386, 8, 'IG', '[Text] 珍珠黑糖拿鐵', '嚼對很紓壓!手搖咖啡新登場!
珍珠黑糖拿鐵(14oz)是咖啡也是手搖!
Q 彈珍珠在黑糖拿鐵裡翻滾，越嚼越香越過癮!冷熱都超好喝
全台門市陸續開賣
先點再取 
maac.io/1HR0Q
#CoCo 都可 #珍珠黑糖拿鐵', '2026-02-06 00:00:00', 57);
INSERT INTO public.marketing_content VALUES (387, 8, 'IG', '[OCR] 雙果茶', '近期紅什麼
就紅這杯
明天來場莓好約會
美樂蒂最愛草莓
肯定要整組的啦～
𝟮/𝟰 
都可訂限定優惠
用美樂蒂聯名紙杯裝莓好雙果飲
夢幻可愛
莓好雙果茶(L)
憑券第二杯 #0 元
2 杯只要75 元
每個人有2 張券
點我領券 https://maac.io/1HR0Q
注意事項
𝟮/𝟰 𝟎𝟎:𝟎𝟎 開始領券，第2、4 杯可享折扣
限使用「CoCo 都可訂」線上點單，優惠不併用
限 𝟮/𝟰 當日使用，數量有限，售完為止
領券後，在確認明細時點選’’點我使用折價券’’帶入折扣
商場門市/部分門市不適用本活動
#好友日 #都可好友日 #CoCo 都可', '2026-02-03 00:00:00', 149);
INSERT INTO public.marketing_content VALUES (388, 8, 'IG', '[Text] 珍珠奶茶', '2 月開始的每一天都在開心倒數過年٩(๑> ₃ <)۶з
天天都是喝飲料的好日子 當然也要優惠喝 心情更加分
全區任選2 杯99
莓好雙果茶 草莓蔓越莓與紅茶的超幸福搭配
冬韻擂焙珍奶 天冷喝這杯最暖心
28 茉輕乳茶  21 歲輕檸烏龍 日焙珍珠奶茶
小湯圓奶茶(門市臨櫃限定)
全部任選、自由搭配！
全台門市臨櫃＆都可訂平台同步優惠
活動品項及販售依各門市公告為主
外送平台及部分門市不適用
#CoCo 都可 #2 杯99', '2026-02-03 00:00:00', 149);
INSERT INTO public.marketing_content VALUES (389, 8, 'IG', '[Text] 職人咖啡', '週二咖啡日又要到啦!
來杯西西里手搗檸檬美式
鮮檸檬現搗出檸檬特有的精油香氣
搭配職人金獎現磨咖啡
感受鮮果的清新 品味咖啡的香醇
隨心暢飲 加料更有勁
每週二限定
生椰職人拿鐵/職人美式/果咖美式 同價位買一送一
臨櫃 / 都可訂 同步開喝
準時開點
 https://maac.io/1HR0Q
活動品項
生椰職人拿鐵(14oz)（街邊) 原價$70
粉角生椰拿鐵(14oz)（街邊) 原價$80
職人美式(14oz)（街邊）原價$45
西西里手搗檸檬美式 /紅柚香檸美式(L)（街邊）原價$75
台灣柳丁美式( L) (街邊) 原價$85
活動優惠以原價計，優惠不併用
商場及部分門市不適用，詳情請洽現場公告
#CoCo 都可 #週二咖啡日 #買一送一 #職人咖啡 #CoCoCoffee', '2026-02-02 00:00:00', 12);
INSERT INTO public.marketing_content VALUES (391, 8, 'IG', '[OCR] 雙響炮', '全民喝百香雙響炮
第二杯10 元
𝟭/𝟮𝟴 
都可訂限定優惠
快找那個願意幫你出10 元的人 ~
百香雙響炮(L)
憑券第二杯 #10 元
2 杯80 元帶走
每個人有2 張券
點我領券 https://maac.io/1HR0Q
注意事項
𝟭/𝟮𝟴 𝟎𝟎:𝟎𝟎 開始領券，第2、4 杯可享折扣
限使用「CoCo 都可訂」線上點單，優惠不併用
限𝟭/𝟮𝟴 當日使用，數量有限，售完為止
領券後，在確認明細時點選’’點我使用折價券’’帶入折扣
商場門市/部分門市不適用本活動
#好友日 #都可好友日 #CoCo 都可', '2026-01-27 00:00:00', 204);
INSERT INTO public.marketing_content VALUES (392, 8, 'IG', '[OCR] 百香', '全民喝百香雙響炮
第二杯10 元
𝟭/𝟮𝟴 
都可訂限定優惠
快找那個願意幫你出10 元的人 ~
百香雙響炮(L)
憑券第二杯 #10 元
2 杯80 元帶走
每個人有2 張券
點我領券 https://maac.io/1HR0Q
注意事項
𝟭/𝟮𝟴 𝟎𝟎:𝟎𝟎 開始領券，第2、4 杯可享折扣
限使用「CoCo 都可訂」線上點單，優惠不併用
限𝟭/𝟮𝟴 當日使用，數量有限，售完為止
領券後，在確認明細時點選’’點我使用折價券’’帶入折扣
商場門市/部分門市不適用本活動
#好友日 #都可好友日 #CoCo 都可', '2026-01-27 00:00:00', 204);
INSERT INTO public.marketing_content VALUES (393, 8, 'IG', '[Text] 莓好雙果茶', 'My Melody 莓好限定!莓好雙果系列甜美開喝！
酸甜草莓 ✕ 鮮香蔓越莓
在紅茶與鮮奶的襯托下，開啟最療癒的莓果時刻～
不只「好喝」，更「喝得安心」！
採用尖端 HPP 冷高壓滅菌技術 製作
保留草莓與蔓越莓的營養、果香 ꙳⸌♡⸍꙳
同時以超高壓力鎖住新鮮、遠離細菌
讓每一口都是滿滿自然甜味與健康能量
莓好雙果茶
融合草莓、蔓越莓與紅茶香氣～
酸甜交織、沁涼爽口，超適合下午來一杯
莓好雙果牛乳
莓果的酸甜搭上濃醇鮮奶
柔滑香濃、無咖啡因，大人小孩都能喝！
酸甜莓果 × 健康科技
一起來喝下雙倍「莓」好的幸福！
1/26 開始購買任一大杯飲品還有美樂蒂聯名紙杯喔
#CoCo 都可 #莓好雙果系列 #莓好雙果茶 #莓好雙果牛乳 #HPP 冷高壓滅菌', '2026-01-24 00:00:00', 605);
INSERT INTO public.marketing_content VALUES (394, 8, 'IG', '[Text] 莓好雙果', 'My Melody 莓好限定!莓好雙果系列甜美開喝！
酸甜草莓 ✕ 鮮香蔓越莓
在紅茶與鮮奶的襯托下，開啟最療癒的莓果時刻～
不只「好喝」，更「喝得安心」！
採用尖端 HPP 冷高壓滅菌技術 製作
保留草莓與蔓越莓的營養、果香 ꙳⸌♡⸍꙳
同時以超高壓力鎖住新鮮、遠離細菌
讓每一口都是滿滿自然甜味與健康能量
莓好雙果茶
融合草莓、蔓越莓與紅茶香氣～
酸甜交織、沁涼爽口，超適合下午來一杯
莓好雙果牛乳
莓果的酸甜搭上濃醇鮮奶
柔滑香濃、無咖啡因，大人小孩都能喝！
酸甜莓果 × 健康科技
一起來喝下雙倍「莓」好的幸福！
1/26 開始購買任一大杯飲品還有美樂蒂聯名紙杯喔
#CoCo 都可 #莓好雙果系列 #莓好雙果茶 #莓好雙果牛乳 #HPP 冷高壓滅菌', '2026-01-24 00:00:00', 605);
INSERT INTO public.marketing_content VALUES (395, 8, 'IG', '[Deep-Mined] 冬韻擂焙珍奶', '不得不愛
天氣冷喝暖暖! 暖暖喝!
#冬日奶茶天花板 開喝
嚴選14 種營養穀物
𝟭/𝟮𝟭 
都可訂限定優惠
手工煮製日式鹿兒島焙奶茶
冬韻擂焙珍奶(L)
憑券第二杯 #0 元
2 杯70 元帶走
每個人有2 張券
點我領券 https://maac.io/1HR0Q
注意事項
𝟭/𝟮𝟭 𝟎𝟎:𝟎𝟎 開始領券，第2、4 杯可享折扣
限使用「CoCo 都可訂」線上點單，優惠不併用
限𝟭/𝟮𝟭當日使用，數量有限，售完為止
領券後，在確認明細時點選’’點我使用折價券’’帶入折扣
商場門市/部分門市不適用本活動
#好友日 #都可好友日 #CoCo 都可', '2026-01-20 00:00:00', 177);
INSERT INTO public.marketing_content VALUES (18, 2, 'FB', '[OCR] 草莓優格飲', '#莓光甜室
Sweet Berry Moments
12/10(三)全台新品上市
讓每一天，
都有一點柔軟的甜。
融進口裡，收在心裡
｜大茗官方網站｜https://www.damingtea.com.tw
#草莓要來了
 #就是下周
#大茗本位製茶堂', '2025-12-02 00:00:00', 309);
INSERT INTO public.marketing_content VALUES (43, 3, 'FB', '[Text-Rescued] 青檸甘蔗蕎麥綠寶', '月夕初見，跨越世代的相聚
在舉杯之間
分享澄黃如月的酸甜滋味
青檸甘蔗蕎麥綠寶 Lemon with Cane Green Rooibos Tea
甘蔗汁佐青檬，平衡中秋的豐盛味蕾
#無咖啡因 在月夜輕柔裡
𝗢𝗥𝗗𝗘𝗥   https://lihi.cc/QvWof/預約外送自取
大人孩童安心共飲', '2025-10-03 00:00:00', 50);
INSERT INTO public.marketing_content VALUES (44, 3, 'FB', '[Text-Rescued] 蕎麥綠國寶', '一畝蕎麥田，掬起穗香與青草香
蕎麥為引，綠國寶茶基底
初飲入喉是自然麥香
伴隨穀物焙炒的濃郁
深淺流轉，隨穗浪輕伏
在漸入回甘之際
漫出綠國寶茶的大地青草香
蕎麥綠寶 𝘎𝘳𝘦𝘦𝘯 𝘙𝘰𝘰𝘪𝘣𝘰𝘴 𝘛𝘦𝘢 𝘚𝘦𝘳𝘪𝘦𝘴
喉韻清香淡雅，悠香不息
金粹·馥莓·青檸甘蔗 ⟢全門市販售中', '2025-09-18 00:00:00', 173);
INSERT INTO public.marketing_content VALUES (46, 3, 'FB', '[Text-Rescued] 青檸甘蔗蕎麥綠寶', '8.27 (三) 全門市 𝘤𝘰𝘮𝘪𝘯𝘨 𝘴𝘰𝘰𝘯
全新零咖啡因飲
𝘎𝘳𝘦𝘦𝘯 𝘙𝘰𝘰𝘪𝘣𝘰𝘴 𝘛𝘦𝘢 𝘚𝘦𝘳𝘪𝘦𝘴 蕎麥綠寶系列
✦  
喚醒盛夏氣息
以青檸鮮榨原汁，融合甘蔗自然甜韻 .ᐟ  
酸沁於舌尖、口感明亮奔放
推薦微微糖至半糖
酸甜恰好
青檸甘蔗蕎麥綠寶
𝙈 𝟳𝟱・𝙇 𝟴𝟱
Lemon with Cane Green Rooibos Tea', '2025-08-22 00:00:00', 53);
INSERT INTO public.marketing_content VALUES (47, 3, 'FB', '[Text-Rescued] 蕎麥綠國寶', '莓果嫣紅，酸甜恰如其分
桑葚馥郁揭開序幕
藍莓柔甜綻放
覆盆子淡淡微酸輕盈收束
揉合蕎麥綠國寶，果韻清亮莓香沁人
𝙈 𝟱𝟱・𝙇 𝟲𝟱
馥莓蕎麥綠寶 Berrys Green Rooibos Tea
蕎麥綠寶 𝘎𝘳𝘦𝘦𝘯 𝘙𝘰𝘰𝘪𝘣𝘰𝘴 𝘛𝘦𝘢 𝘚𝘦𝘳𝘪𝘦𝘴
✦ 零咖啡因系列 ✦
8.27 (三)  全台同步上市', '2025-08-21 00:00:00', 87);
INSERT INTO public.marketing_content VALUES (187, 8, 'FB', '[Text-Rescued] 羽衣甘藍', '#二月最後一次 超級星期一優惠把握啦
被譽為超級食物的羽衣甘藍，營養滿滿!!
中午來一杯現榨 #羽衣蘋安杯 讓你開啟元氣滿滿的星期一
2/9 臨櫃限定 | 羽衣蘋安杯（M）只要49 元
*羽衣甘藍屬高鉀蔬菜，腎功能不良或低血壓族群請酌量食用
*商場、外島等部分門市無販售，請以現場公告為準
*優惠不併用
#CoCo #羽衣甘藍 #優惠活動 #超級星期一', '2026-02-08 00:00:00', 51);
INSERT INTO public.marketing_content VALUES (216, 2, 'IG', '[OCR] 草莓優格飲', '#莓光甜室
Sweet Berry Moments
12/10(三)全台新品上市
讓每一天，
都有一點柔軟的甜。
融進口裡，收在心裡
｜大茗官方網站｜https://www.damingtea.com.tw
#草莓要來了
 #就是下周
#大茗本位製茶堂', '2025-12-02 00:00:00', 164);
INSERT INTO public.marketing_content VALUES (242, 3, 'IG', '[Text-Rescued] 蕎麥綠國寶', '一畝蕎麥田，掬起穗香與青草香
蕎麥為引，綠國寶茶基底
初飲入喉是自然麥香
伴隨穀物焙炒的濃郁
深淺流轉，隨穗浪輕伏
在漸入回甘之際
漫出綠國寶茶的大地青草香
蕎麥綠寶 𝘎𝘳𝘦𝘦𝘯 𝘙𝘰𝘰𝘪𝘣𝘰𝘴 𝘛𝘦𝘢 𝘚𝘦𝘳𝘪𝘦𝘴
喉韻清香淡雅，悠香不息
金粹·馥莓·青檸甘蔗 ⟢全門市販售中', '2025-09-18 00:00:00', 237);
INSERT INTO public.marketing_content VALUES (244, 3, 'IG', '[Text-Rescued] 青檸甘蔗蕎麥綠寶', '8.27 (三) 全門市 𝘤𝘰𝘮𝘪𝘯𝘨 𝘴𝘰𝘰𝘯
全新零咖啡因飲
𝘎𝘳𝘦𝘦𝘯 𝘙𝘰𝘰𝘪𝘣𝘰𝘴 𝘛𝘦𝘢 𝘚𝘦𝘳𝘪𝘦𝘴 蕎麥綠寶系列
✦  
喚醒盛夏氣息
以青檸鮮榨原汁，融合甘蔗自然甜韻 .ᐟ  
酸沁於舌尖、口感明亮奔放
推薦微微糖至半糖
酸甜恰好
青檸甘蔗蕎麥綠寶
𝙈 𝟳𝟱・𝙇 𝟴𝟱
Lemon with Cane Green Rooibos Tea', '2025-08-22 00:00:00', 156);
INSERT INTO public.marketing_content VALUES (245, 3, 'IG', '[Text-Rescued] 蕎麥綠國寶', '莓果嫣紅，酸甜恰如其分
桑葚馥郁揭開序幕
藍莓柔甜綻放
覆盆子淡淡微酸輕盈收束
揉合蕎麥綠國寶，果韻清亮莓香沁人
𝙈 𝟱𝟱・𝙇 𝟲𝟱
馥莓蕎麥綠寶 Berrys Green Rooibos Tea
蕎麥綠寶 𝘎𝘳𝘦𝘦𝘯 𝘙𝘰𝘰𝘪𝘣𝘰𝘴 𝘛𝘦𝘢 𝘚𝘦𝘳𝘪𝘦𝘴
✦ 零咖啡因系列 ✦
8.27 (三)  全台同步上市', '2025-08-21 00:00:00', 216);
INSERT INTO public.marketing_content VALUES (383, 8, 'IG', '[Text-Rescued] 珍波椰青茶', '季主打嵐a 青春～必喝品項
#超值組合 滿滿配料珍波椰直接抵一餐
#清爽暢飲 經典四季春青茶清香又回甘
不說了！阿嵐要手刀去買一杯～
#50 嵐 #50 嵐中區 #好茶陪伴你的日常 #手搖 #飲料 #春季主打 #嵐a 青春 #
珍波椰青茶', '2024-05-06 00:00:00', 167);
INSERT INTO public.marketing_content VALUES (385, 8, 'IG', '[Text-Rescued] 羽衣甘藍', '#二月最後一次 超級星期一優惠把握啦
被譽為超級食物的羽衣甘藍，營養滿滿!!
中午來一杯現榨 #羽衣蘋安杯 讓你開啟元氣滿滿的星期一
2/9 臨櫃限定 | 羽衣蘋安杯（M）只要49 元
*羽衣甘藍屬高鉀蔬菜，腎功能不良或低血壓族群請酌量食用
*商場、外島等部分門市無販售，請以現場公告為準
*優惠不併用
#CoCo #羽衣甘藍 #優惠活動 #超級星期一', '2026-02-08 00:00:00', 28);
INSERT INTO public.marketing_content VALUES (396, 8, 'IG', '[Text] 莓好雙果茶', '• 
#美好雙果 平安健康+賺大錢🎉
#莓好新年必喝莓好雙果茶🍓🍓🍓
𝟭/𝟭𝟰 🫶都可訂限定優惠
莓好雙果茶(L)
📢憑券第二杯 #10 元
2 杯85 元帶走 🧋
每個人有2 張券
💡注意事項
2️⃣ 𝟭/𝟭𝟰 𝟎𝟎:𝟎𝟎 開始領券，第2、4 杯可享折扣
1️⃣ 限使用「CoCo 都可訂」線上點單，優惠不併用
4️⃣ 限𝟭/𝟭𝟰 當日使用，數量有限，售完為止
3️⃣ 領券後，在確認明細時點選’’點我使用折價券’’帶入折扣
5️⃣ 商場門市/部分門市不適用本活動
#好友日 #都可好友日 #CoCo 都可', '2026-01-13 00:00:00', 105);
INSERT INTO public.marketing_content VALUES (5, 1, 'FB', '[需人工確認] 圖片限定或無飲品', '#雙饗茶會 ❭❭❭  𝐓𝐄𝐀+𝐋𝐀𝐓𝐓𝐄 享組合優惠  
讓冬天過得更溫暖，以茶相聚，歡慶聖誕！
．活動不得與其他優惠合併使用 
．功夫茶保有活動更改、終止及解釋權利
#KUNGFUTEA 功夫茶 #功夫茶 ＃雙饗茶會', '2025-12-24 00:00:00', 16);
INSERT INTO public.marketing_content VALUES (6, 1, 'FB', '[需人工確認] 圖片限定或無飲品', '氣溫急速下降，早晚溫差大 ❆ 
回家路上，迎面而來的冷風   
身體忍不住顫抖，寒意包裹全身
來杯熱飲，身體立刻暖起來
讓疲憊和寒意一起消散   
 
回家路上喝拿鐵，暖身也暖心
到家喝原茶配上豐盛的晚餐   
雙重享受，迎接美好的夜晚 ෆ
✧𝟏𝟏.𝟎𝟏-𝟎𝟏.𝟏𝟏｜雙饗茶會 組合優惠價✧ 
𝐏𝐚𝐢𝐫 + 𝐒𝐡𝐚𝐫𝐞，各選一杯，幸福加倍
※活動限來店、自取、外送、享什麼 
※活動不得與其他優惠併用
#KUNGFUTEA 功夫茶 #功夫茶 #雙響茶會', '2025-11-24 00:00:00', 27);
INSERT INTO public.marketing_content VALUES (23, 2, 'FB', '[需人工確認] 圖片限定或無飲品', '雙十快樂，一起乾杯吧！
十月的陽光有點甜，
十月的風也帶著好心情～
在這充滿喜慶的日子裡，
不妨停下腳步，來杯好茶放鬆一下
我們國慶日不打烊
手搖好茶隨時待命，
無論是沁涼鮮果、濃郁奶香，
都讓幸福在舌尖綻放
秋意漸濃，早晚記得加件外套，
祝大家都能度過溫馨的雙十連假～
｜大茗官方網站｜https://www.damingtea.com.tw/
#大茗本位製茶 #雙十節快樂', '2025-10-10 00:00:00', 22);
INSERT INTO public.marketing_content VALUES (56, 4, 'FB', '[需人工確認] 圖片限定或無飲品', '馬年到，好運轉起來！
過年就是要有儀式感
馬年新春限定杯正式上市啦！
旋轉木馬的童趣設計，搭配奔馳的駿馬意象，
象徵勇往直前、好運連連、事事馬到成功
先喝道-新年換新杯，喝的每一口都是滿滿年味～
不管是自己收藏，還是送禮，都超有儀式感
馬年限定・數量有限
拿在手上，年味直接拉滿
#馬年 #新年新品 #先喝道 #把世界放在一杯茶中 #嚴選世界好茶
#TAOTAO_TEA #精品茶 #ITQI 得獎茶 #手搖飲 #手搖推薦 #古典玫瑰園 #下午
茶時間 #新春必收 #過年就是要有儀式感', '2026-01-31 00:00:00', 26);
INSERT INTO public.marketing_content VALUES (124, 7, 'FB', '[需人工確認] 圖片限定或無飲品', '過年送什麼，才不會被放在角落？
懂喝的人都知道——答案是這包
邁入第 𝟱 年 #COMEBUY 持續限量熱銷中
一年只回來一次的【冬片比賽茶包】
嚴選鬥茶協會認證的比賽茶
超值 𝟱𝗴 茶包，冷泡熱泡都好喝！
茶湯清香、甘甜醇厚、不苦不澀
為什麼過年送它剛剛好？
𝟱𝗴 立體三角茶包，香氣更完整
精緻包裝，送禮有面子
可回沖多次，在家慢慢喝也很可以
價格親切，自用送人都適合
今年過年，送一份「懂喝的心意」
也替自己留一包，好好喝一杯
一年一次，錯過真的要等明年了～
冬片比賽茶包｜𝟱𝗴 x 𝟭𝟬入裝｜𝟭𝟵𝟵元
數量有限，售完為止！
#冬片比賽茶包 #一年一次 #過年送禮首選', '2026-02-09 00:00:00', 15);
INSERT INTO public.marketing_content VALUES (125, 7, 'FB', '[Deep-Mined] 黑糖的香', '把看似平凡的事做到不平凡
才是真正的高度
世界級的舞台
來自每天不妥協的基本功
就像 #COMEBUY 把每一杯茶
都當成最重要的一杯
#把日常做到世界級
#現萃不是口號 #每一杯都很重要
2026/01/08 (fb) 按讚數:
#COMEBUY 黑糖特別在…
不是更甜，而是更「真」
—— #半糖 以上風味完整好喝
黑糖的香、甘、厚一次到位
甜度剛好，也喝出黑糖的層次口感
沖繩 × 台灣 雙重黑糖堆疊
一個給你焦糖香的厚度
一個留下甘蔗清甜的尾韻～
飲品甜度來自黑糖本身
不是比例堆疊，是經熬煮產生的自然焦糖香
層次深厚卻不膩，喝得到溫潤也喝得到乾淨
未經高度精製保留完整營養
黑糖沒有走繁複提煉流程
保留更多礦物質與原始風味
甜得剛好，也喝得安心！
一杯好喝現萃搭配黑糖
才是冬天最耐喝的暖呼呼 ☕︎ 
#雙黑糖堆疊 #OnlyBlackSugar
#黑糖不是都一樣 #無可取代的單杯現萃
𝟮𝟬𝟮𝟱 → 𝟮𝟬𝟮𝟲 倒數啦', '2026-01-26 00:00:00', 34);
INSERT INTO public.marketing_content VALUES (204, 1, 'IG', '[需人工確認] 圖片限定或無飲品', '氣溫急速下降，早晚溫差大 ❆ 
回家路上，迎面而來的冷風   
身體忍不住顫抖，寒意包裹全身
來杯熱飲，身體立刻暖起來
讓疲憊和寒意一起消散   
 
回家路上喝拿鐵，暖身也暖心
到家喝原茶配上豐盛的晚餐   
雙重享受，迎接美好的夜晚 ෆ
✧𝟏𝟏.𝟎𝟏-𝟎𝟏.𝟏𝟏｜雙饗茶會 組合優惠價✧ 
𝐏𝐚𝐢𝐫 + 𝐒𝐡𝐚𝐫𝐞，各選一杯，幸福加倍
※活動限來店、自取、外送、享什麼 
※活動不得與其他優惠併用
#KUNGFUTEA 功夫茶 #功夫茶 #雙響茶會', '2025-11-24 00:00:00', 9);
INSERT INTO public.marketing_content VALUES (221, 2, 'IG', '[需人工確認] 圖片限定或無飲品', '雙十快樂，一起乾杯吧！
十月的陽光有點甜，
十月的風也帶著好心情～
在這充滿喜慶的日子裡，
不妨停下腳步，來杯好茶放鬆一下
我們國慶日不打烊
手搖好茶隨時待命，
無論是沁涼鮮果、濃郁奶香，
都讓幸福在舌尖綻放
秋意漸濃，早晚記得加件外套，
祝大家都能度過溫馨的雙十連假～
｜大茗官方網站｜https://www.damingtea.com.tw/
#大茗本位製茶 #雙十節快樂', '2025-10-10 00:00:00', 44);
INSERT INTO public.marketing_content VALUES (254, 4, 'IG', '[需人工確認] 圖片限定或無飲品', '馬年到，好運轉起來！
過年就是要有儀式感
馬年新春限定杯正式上市啦！
旋轉木馬的童趣設計，搭配奔馳的駿馬意象，
象徵勇往直前、好運連連、事事馬到成功
先喝道-新年換新杯，喝的每一口都是滿滿年味～
不管是自己收藏，還是送禮，都超有儀式感
馬年限定・數量有限
拿在手上，年味直接拉滿
#馬年 #新年新品 #先喝道 #把世界放在一杯茶中 #嚴選世界好茶
#TAOTAO_TEA #精品茶 #ITQI 得獎茶 #手搖飲 #手搖推薦 #古典玫瑰園 #下午
茶時間 #新春必收 #過年就是要有儀式感', '2026-01-31 00:00:00', 73);
INSERT INTO public.marketing_content VALUES (322, 7, 'IG', '[需人工確認] 圖片限定或無飲品', '過年送什麼，才不會被放在角落？
懂喝的人都知道——答案是這包
邁入第 𝟱 年 #COMEBUY 持續限量熱銷中
一年只回來一次的【冬片比賽茶包】
嚴選鬥茶協會認證的比賽茶
超值 𝟱𝗴 茶包，冷泡熱泡都好喝！
茶湯清香、甘甜醇厚、不苦不澀
為什麼過年送它剛剛好？
𝟱𝗴 立體三角茶包，香氣更完整
精緻包裝，送禮有面子
可回沖多次，在家慢慢喝也很可以
價格親切，自用送人都適合
今年過年，送一份「懂喝的心意」
也替自己留一包，好好喝一杯
一年一次，錯過真的要等明年了～
冬片比賽茶包｜𝟱𝗴 x 𝟭𝟬入裝｜𝟭𝟵𝟵元
數量有限，售完為止！
#冬片比賽茶包 #一年一次 #過年送禮首選', '2026-02-09 00:00:00', 13);
INSERT INTO public.marketing_content VALUES (323, 7, 'IG', '[需人工確認] 圖片限定或無飲品', '把看似平凡的事做到不平凡
才是真正的高度
世界級的舞台
來自每天不妥協的基本功
就像 #COMEBUY 把每一杯茶
都當成最重要的一杯
#把日常做到世界級
#現萃不是口號 #每一杯都很重要', '2026-01-26 00:00:00', 62);
INSERT INTO public.marketing_content VALUES (324, 7, 'IG', '[Deep-Mined] 黑糖的香', '#COMEBUY 黑糖特別在…
不是更甜，而是更「真」
—— #半糖 以上風味完整好喝
黑糖的香、甘、厚一次到位
甜度剛好，也喝出黑糖的層次口感
沖繩 × 台灣 雙重黑糖堆疊
一個給你焦糖香的厚度
一個留下甘蔗清甜的尾韻～
飲品甜度來自黑糖本身
不是比例堆疊，是經熬煮產生的自然焦糖香
層次深厚卻不膩，喝得到溫潤也喝得到乾淨
未經高度精製保留完整營養
黑糖沒有走繁複提煉流程
保留更多礦物質與原始風味
甜得剛好，也喝得安心！
一杯好喝現萃搭配黑糖
才是冬天最耐喝的暖呼呼 ☕︎ 
#雙黑糖堆疊 #OnlyBlackSugar
#黑糖不是都一樣 #無可取代的單杯現萃
𝟮𝟬𝟮𝟱 → 𝟮𝟬𝟮𝟲 倒數啦', '2026-01-08 00:00:00', 37);


--
-- Data for Name: price_history; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.product VALUES (1, 1, '功夫茶王', 0.00, '2026-02-10 17:12:37.589741', '功夫・必喝');
INSERT INTO public.product VALUES (2, 1, '芝士奶蓋翠玉', 0.00, '2026-02-10 17:12:37.589741', '功夫・必喝');
INSERT INTO public.product VALUES (3, 1, '冰淇淋雪藏紅茶', 0.00, '2026-02-10 17:12:37.589741', '功夫・必喝');
INSERT INTO public.product VALUES (4, 1, '輕飲水果茶王', 0.00, '2026-02-10 17:12:37.589741', '功夫・必喝');
INSERT INTO public.product VALUES (5, 1, '寒天柚香飲', 0.00, '2026-02-10 17:12:37.589741', '功夫・必喝');
INSERT INTO public.product VALUES (6, 1, '黑糖波霸鮮奶', 0.00, '2026-02-10 17:12:37.589741', '功夫・必喝');
INSERT INTO public.product VALUES (7, 1, '隱山烏龍', 0.00, '2026-02-10 17:12:37.589741', '功夫・必喝');
INSERT INTO public.product VALUES (8, 1, '芭樂檸檬綠', 0.00, '2026-02-10 17:12:37.589741', '功夫・必喝');
INSERT INTO public.product VALUES (9, 1, '岩葉紅茶', 0.00, '2026-02-10 17:12:37.589741', '功夫・好茶');
INSERT INTO public.product VALUES (10, 1, '翠玉綠茶', 0.00, '2026-02-10 17:12:37.589741', '功夫・好茶');
INSERT INTO public.product VALUES (11, 1, '四季春青茶', 0.00, '2026-02-10 17:12:37.589741', '功夫・好茶');
INSERT INTO public.product VALUES (12, 1, '烏龍鐵觀音', 0.00, '2026-02-10 17:12:37.589741', '功夫・好茶');
INSERT INTO public.product VALUES (13, 1, '手作冬瓜茶', 0.00, '2026-02-10 17:12:37.589741', '功夫・好茶');
INSERT INTO public.product VALUES (14, 1, '蜜桃胭脂紅茶', 0.00, '2026-02-10 17:12:37.589741', '功夫・好茶');
INSERT INTO public.product VALUES (15, 1, '日月潭紅玉', 0.00, '2026-02-10 17:12:37.589741', '功夫・好茶');
INSERT INTO public.product VALUES (16, 1, '阿里山冰茶', 0.00, '2026-02-10 17:12:37.589741', '功夫・好茶');
INSERT INTO public.product VALUES (17, 1, '芝士奶蓋紅茶', 0.00, '2026-02-10 17:12:37.589741', '功夫・好茶');
INSERT INTO public.product VALUES (18, 1, '芝士奶蓋烏龍', 0.00, '2026-02-10 17:12:37.589741', '功夫・好茶');
INSERT INTO public.product VALUES (19, 1, '玫瑰冰茶', 0.00, '2026-02-10 17:12:37.589741', '功夫・好茶');
INSERT INTO public.product VALUES (20, 1, '青梅綠茶', 0.00, '2026-02-10 17:12:37.589741', '功夫・好茶');
INSERT INTO public.product VALUES (21, 1, '多多綠茶', 0.00, '2026-02-10 17:12:37.589741', '功夫・好茶');
INSERT INTO public.product VALUES (22, 1, '胭脂多多', 0.00, '2026-02-10 17:12:37.589741', '功夫・好茶');
INSERT INTO public.product VALUES (23, 1, '芝士奶蓋青茶', 0.00, '2026-02-10 17:12:37.589741', '功夫・好茶');
INSERT INTO public.product VALUES (24, 1, '38奶霸', 0.00, '2026-02-10 17:12:37.589741', '功夫・奶茶');
INSERT INTO public.product VALUES (25, 1, '黑糖波霸珍珠奶茶', 0.00, '2026-02-10 17:12:37.589741', '功夫・奶茶');
INSERT INTO public.product VALUES (26, 1, '厚奶茶', 0.00, '2026-02-10 17:12:37.589741', '功夫・奶茶');
INSERT INTO public.product VALUES (27, 1, '厚奶綠', 0.00, '2026-02-10 17:12:37.589741', '功夫・奶茶');
INSERT INTO public.product VALUES (28, 1, '烏龍觀音奶茶', 0.00, '2026-02-10 17:12:37.589741', '功夫・奶茶');
INSERT INTO public.product VALUES (29, 1, '英式伯爵奶茶', 0.00, '2026-02-10 17:12:37.589741', '功夫・奶茶');
INSERT INTO public.product VALUES (30, 1, '蜜桃胭脂奶茶', 0.00, '2026-02-10 17:12:37.589741', '功夫・奶茶');
INSERT INTO public.product VALUES (31, 1, '莊園玫瑰奶茶', 0.00, '2026-02-10 17:12:37.589741', '功夫・奶茶');
INSERT INTO public.product VALUES (32, 1, '巧克力奶茶', 0.00, '2026-02-10 17:12:37.589741', '功夫・奶茶');
INSERT INTO public.product VALUES (33, 1, '粉粿柚香綠', 0.00, '2026-02-10 17:12:37.589741', '功夫・鮮果');
INSERT INTO public.product VALUES (34, 1, '鮮榨柳橙綠', 0.00, '2026-02-10 17:12:37.589741', '功夫・鮮果');
INSERT INTO public.product VALUES (35, 1, '黃金芒果綠', 0.00, '2026-02-10 17:12:37.589741', '功夫・鮮果');
INSERT INTO public.product VALUES (36, 1, '百香3Q(珍珠+蒟蒻+椰果)', 0.00, '2026-02-10 17:12:37.589741', '功夫・鮮果');
INSERT INTO public.product VALUES (37, 1, '百香羅勒子', 0.00, '2026-02-10 17:12:37.589741', '功夫・鮮果');
INSERT INTO public.product VALUES (38, 1, '冬瓜檸檬', 0.00, '2026-02-10 17:12:37.589741', '功夫・鮮果');
INSERT INTO public.product VALUES (39, 1, '黃金芒果莎莎', 0.00, '2026-02-10 17:12:37.589741', '功夫・鮮果');
INSERT INTO public.product VALUES (40, 1, '泰式榴槤莎莎(冰沙)', 0.00, '2026-02-10 17:12:37.589741', '功夫・鮮果');
INSERT INTO public.product VALUES (41, 1, '紅豆粉粿鮮奶', 0.00, '2026-02-10 17:12:37.589741', '功夫・鮮奶');
INSERT INTO public.product VALUES (42, 1, '岩葉紅茶拿鐵', 0.00, '2026-02-10 17:12:37.589741', '功夫・鮮奶');
INSERT INTO public.product VALUES (43, 1, '烏龍觀音拿鐵', 0.00, '2026-02-10 17:12:37.589741', '功夫・鮮奶');
INSERT INTO public.product VALUES (44, 1, '英式伯爵拿鐵', 0.00, '2026-02-10 17:12:37.589741', '功夫・鮮奶');
INSERT INTO public.product VALUES (45, 1, '蜜桃胭脂拿鐵', 0.00, '2026-02-10 17:12:37.589741', '功夫・鮮奶');
INSERT INTO public.product VALUES (46, 1, '冰淇淋紅茶拿鐵', 0.00, '2026-02-10 17:12:37.589741', '功夫・鮮奶');
INSERT INTO public.product VALUES (47, 1, '巧克力鮮奶', 0.00, '2026-02-10 17:12:37.589741', '功夫・鮮奶');
INSERT INTO public.product VALUES (48, 1, '暖薑奶茶', 0.00, '2026-02-10 17:12:37.589741', '冬日限定');
INSERT INTO public.product VALUES (49, 1, '暖薑鮮奶', 0.00, '2026-02-10 17:12:37.589741', '冬日限定');
INSERT INTO public.product VALUES (50, 1, '薑汁桂圓紅棗', 0.00, '2026-02-10 17:12:37.589741', '冬日限定');
INSERT INTO public.product VALUES (51, 2, '玉露青茶', 0.00, '2026-02-10 17:12:37.589741', '嚴選茗品');
INSERT INTO public.product VALUES (52, 2, '桂花青茶', 0.00, '2026-02-10 17:12:37.589741', '嚴選茗品');
INSERT INTO public.product VALUES (53, 2, '炭燒青茶', 0.00, '2026-02-10 17:12:37.589741', '嚴選茗品');
INSERT INTO public.product VALUES (54, 2, '紅玉紅茶', 0.00, '2026-02-10 17:12:37.589741', '經典純粹');
INSERT INTO public.product VALUES (55, 2, '翡翠綠茶', 0.00, '2026-02-10 17:12:37.589741', '經典純粹');
INSERT INTO public.product VALUES (56, 2, '熟成油切蕎麥', 0.00, '2026-02-10 17:12:37.589741', '經典純粹');
INSERT INTO public.product VALUES (57, 2, '熟成油切蕎麥(無)', 0.00, '2026-02-10 17:12:37.589741', '經典純粹');
INSERT INTO public.product VALUES (58, 2, '御品冬瓜露', 0.00, '2026-02-10 17:12:37.589741', '經典純粹');
INSERT INTO public.product VALUES (59, 2, '冷萃東方美人', 0.00, '2026-02-10 17:12:37.589741', '經典純粹');
INSERT INTO public.product VALUES (60, 2, '冷萃半熟金萱', 0.00, '2026-02-10 17:12:37.589741', '經典純粹');
INSERT INTO public.product VALUES (61, 2, '老奶奶的鳳梨田', 0.00, '2026-02-10 17:12:37.589741', '職人手作');
INSERT INTO public.product VALUES (62, 2, '蘋果玉露青', 0.00, '2026-02-10 17:12:37.589741', '職人手作');
INSERT INTO public.product VALUES (63, 2, '甘蔗玉露青', 0.00, '2026-02-10 17:12:37.589741', '職人手作');
INSERT INTO public.product VALUES (64, 2, '冬瓜玉露青', 0.00, '2026-02-10 17:12:37.589741', '職人手作');
INSERT INTO public.product VALUES (65, 2, '纖檸冬瓜露', 0.00, '2026-02-10 17:12:37.589741', '職人手作');
INSERT INTO public.product VALUES (66, 2, '翡翠多多青', 0.00, '2026-02-10 17:12:37.589741', '職人手作');
INSERT INTO public.product VALUES (67, 2, '檸檬桂花青', 0.00, '2026-02-10 17:12:37.589741', '職人手作');
INSERT INTO public.product VALUES (68, 2, '柳橙翡翠青', 0.00, '2026-02-10 17:12:37.589741', '職人手作');
INSERT INTO public.product VALUES (69, 2, '酪梨奶蓋紅玉', 0.00, '2026-02-10 17:12:37.589741', '雲朵奶蓋');
INSERT INTO public.product VALUES (70, 2, '酪梨奶蓋綠茶', 0.00, '2026-02-10 17:12:37.589741', '雲朵奶蓋');
INSERT INTO public.product VALUES (71, 2, '酪梨奶蓋烏龍', 0.00, '2026-02-10 17:12:37.589741', '雲朵奶蓋');
INSERT INTO public.product VALUES (72, 2, '酪梨奶蓋冬瓜露', 0.00, '2026-02-10 17:12:37.589741', '雲朵奶蓋');
INSERT INTO public.product VALUES (73, 2, '玉露奶青', 0.00, '2026-02-10 17:12:37.589741', '香醇濃郁');
INSERT INTO public.product VALUES (74, 2, '桂花奶青', 0.00, '2026-02-10 17:12:37.589741', '香醇濃郁');
INSERT INTO public.product VALUES (75, 2, '懷舊經典奶茶', 0.00, '2026-02-10 17:12:37.589741', '香醇濃郁');
INSERT INTO public.product VALUES (76, 2, '鐵觀音奶茶', 0.00, '2026-02-10 17:12:37.589741', '香醇濃郁');
INSERT INTO public.product VALUES (77, 2, '翡翠奶綠', 0.00, '2026-02-10 17:12:37.589741', '香醇濃郁');
INSERT INTO public.product VALUES (78, 2, '熟成蕎麥奶茶', 0.00, '2026-02-10 17:12:37.589741', '香醇濃郁');
INSERT INTO public.product VALUES (79, 2, '熟成蕎麥奶茶(無)', 0.00, '2026-02-10 17:12:37.589741', '香醇濃郁');
INSERT INTO public.product VALUES (80, 2, '珍珠奶茶', 0.00, '2026-02-10 17:12:37.589741', '香醇濃郁');
INSERT INTO public.product VALUES (81, 2, '烤糖蕎麥凍奶青', 0.00, '2026-02-10 17:12:37.589741', '香醇濃郁');
INSERT INTO public.product VALUES (82, 2, '珈琲粉粿蕎麥奶', 0.00, '2026-02-10 17:12:37.589741', '香醇濃郁');
INSERT INTO public.product VALUES (83, 2, '珈琲粉粿蕎麥奶(無)', 0.00, '2026-02-10 17:12:37.589741', '香醇濃郁');
INSERT INTO public.product VALUES (84, 2, '紅茶拿鐵', 0.00, '2026-02-10 17:12:37.589741', '牧場直送');
INSERT INTO public.product VALUES (85, 2, '翡翠拿鐵', 0.00, '2026-02-10 17:12:37.589741', '牧場直送');
INSERT INTO public.product VALUES (86, 2, '珍珠粉粿牛奶', 0.00, '2026-02-10 17:12:37.589741', '牧場直送');
INSERT INTO public.product VALUES (87, 2, '鐵觀音拿鐵', 0.00, '2026-02-10 17:12:37.589741', '牧場直送');
INSERT INTO public.product VALUES (88, 2, '仙草嫩奶', 0.00, '2026-02-10 17:12:37.589741', '牧場直送');
INSERT INTO public.product VALUES (89, 2, '翡翠莓香', 0.00, '2026-02-10 17:12:37.589741', '季節限定');
INSERT INTO public.product VALUES (90, 2, '草莓優格飲', 0.00, '2026-02-10 17:12:37.589741', '季節限定');
INSERT INTO public.product VALUES (91, 2, '冬瓜蕎麥老鄉茶', 0.00, '2026-02-10 17:12:37.589741', '期間限定');
INSERT INTO public.product VALUES (92, 2, '冬瓜蕎麥老鄉拿鐵', 0.00, '2026-02-10 17:12:37.589741', '期間限定');
INSERT INTO public.product VALUES (93, 3, '緋烏龍', 0.00, '2026-02-10 17:12:37.589741', '新品上市-緋烏龍系列');
INSERT INTO public.product VALUES (94, 3, '馥莓緋烏龍', 0.00, '2026-02-10 17:12:37.589741', '新品上市-緋烏龍系列');
INSERT INTO public.product VALUES (95, 3, '緋烏龍奶茶', 0.00, '2026-02-10 17:12:37.589741', '新品上市-緋烏龍系列');
INSERT INTO public.product VALUES (96, 3, '緋烏龍鮮奶', 0.00, '2026-02-10 17:12:37.589741', '新品上市-緋烏龍系列');
INSERT INTO public.product VALUES (97, 3, '芝士奶蓋緋烏龍', 0.00, '2026-02-10 17:12:37.589741', '新品上市-緋烏龍系列');
INSERT INTO public.product VALUES (98, 3, '紅茶', 0.00, '2026-02-10 17:12:37.589741', 'Original TEA');
INSERT INTO public.product VALUES (99, 3, '綠茶', 0.00, '2026-02-10 17:12:37.589741', 'Original TEA');
INSERT INTO public.product VALUES (100, 3, '春烏龍', 0.00, '2026-02-10 17:12:37.589741', 'Original TEA');
INSERT INTO public.product VALUES (101, 3, '輕烏龍', 0.00, '2026-02-10 17:12:37.589741', 'Original TEA');
INSERT INTO public.product VALUES (102, 3, '焙烏龍', 0.00, '2026-02-10 17:12:37.589741', 'Original TEA');
INSERT INTO public.product VALUES (103, 3, '奶茶', 0.00, '2026-02-10 17:12:37.589741', 'Classic MILK TEA');
INSERT INTO public.product VALUES (104, 3, '焙烏龍奶茶', 0.00, '2026-02-10 17:12:37.589741', 'Classic MILK TEA');
INSERT INTO public.product VALUES (105, 3, '珍珠奶茶', 0.00, '2026-02-10 17:12:37.589741', 'Classic MILK TEA');
INSERT INTO public.product VALUES (106, 3, '黃金珍珠奶綠', 0.00, '2026-02-10 17:12:37.589741', 'Classic MILK TEA');
INSERT INTO public.product VALUES (107, 3, '烘吉奶茶', 0.00, '2026-02-10 17:12:37.589741', 'Classic MILK TEA');
INSERT INTO public.product VALUES (108, 3, '紅茶鮮奶', 0.00, '2026-02-10 17:12:37.589741', 'Fresh MILK');
INSERT INTO public.product VALUES (109, 3, '輕烏龍鮮奶', 0.00, '2026-02-10 17:12:37.589741', 'Fresh MILK');
INSERT INTO public.product VALUES (110, 3, '焙烏龍鮮奶', 0.00, '2026-02-10 17:12:37.589741', 'Fresh MILK');
INSERT INTO public.product VALUES (111, 3, '烘吉鮮奶', 0.00, '2026-02-10 17:12:37.589741', 'Fresh MILK');
INSERT INTO public.product VALUES (112, 3, '檸檬春烏龍', 0.00, '2026-02-10 17:12:37.589741', 'Double FRUIT');
INSERT INTO public.product VALUES (113, 3, '香橙春烏龍', 0.00, '2026-02-10 17:12:37.589741', 'Double FRUIT');
INSERT INTO public.product VALUES (114, 3, '甘蔗春烏龍', 0.00, '2026-02-10 17:12:37.589741', 'Double FRUIT');
INSERT INTO public.product VALUES (115, 3, '青梅春烏龍', 0.00, '2026-02-10 17:12:37.589741', 'Double FRUIT');
INSERT INTO public.product VALUES (116, 3, '優酪春烏龍', 0.00, '2026-02-10 17:12:37.589741', 'Double FRUIT');
INSERT INTO public.product VALUES (117, 3, '雙柚金烏龍', 0.00, '2026-02-10 17:12:37.589741', 'Double FRUIT');
INSERT INTO public.product VALUES (118, 3, '芝士奶蓋春烏龍', 0.00, '2026-02-10 17:12:37.589741', 'Cheese MILK FOAM');
INSERT INTO public.product VALUES (119, 3, '芝士奶蓋焙烏龍', 0.00, '2026-02-10 17:12:37.589741', 'Cheese MILK FOAM');
INSERT INTO public.product VALUES (120, 3, '芝士奶蓋阿華田', 0.00, '2026-02-10 17:12:37.589741', 'Cheese MILK FOAM');
INSERT INTO public.product VALUES (121, 3, '芝士奶蓋烘吉茶', 0.00, '2026-02-10 17:12:37.589741', 'Cheese MILK FOAM');
INSERT INTO public.product VALUES (122, 4, '太妃蜜桃風味厚奶霜', 0.00, '2026-02-10 17:12:37.589741', '新品上市-太妃厚奶系列');
INSERT INTO public.product VALUES (123, 4, '太妃風味伯爵厚奶霜', 0.00, '2026-02-10 17:12:37.589741', '新品上市-太妃厚奶系列');
INSERT INTO public.product VALUES (124, 4, '太妃風味錫蘭厚奶霜', 0.00, '2026-02-10 17:12:37.589741', '新品上市-太妃厚奶系列');
INSERT INTO public.product VALUES (125, 4, '太妃蜜桃風味拿鐵', 0.00, '2026-02-10 17:12:37.589741', '新品上市-太妃厚奶系列');
INSERT INTO public.product VALUES (126, 4, '太妃風味伯爵拿鐵', 0.00, '2026-02-10 17:12:37.589741', '新品上市-太妃厚奶系列');
INSERT INTO public.product VALUES (127, 4, '太妃風味錫蘭拿鐵', 0.00, '2026-02-10 17:12:37.589741', '新品上市-太妃厚奶系列');
INSERT INTO public.product VALUES (128, 4, '太妃蜜桃風味奶茶', 0.00, '2026-02-10 17:12:37.589741', '新品上市-太妃厚奶系列');
INSERT INTO public.product VALUES (129, 4, '太妃風味伯爵奶茶', 0.00, '2026-02-10 17:12:37.589741', '新品上市-太妃厚奶系列');
INSERT INTO public.product VALUES (130, 4, '太妃風味錫蘭奶茶', 0.00, '2026-02-10 17:12:37.589741', '新品上市-太妃厚奶系列');
INSERT INTO public.product VALUES (131, 4, '英式玫瑰拿鐵', 0.00, '2026-02-10 17:12:37.589741', '活動區');
INSERT INTO public.product VALUES (132, 4, '英式水果茶', 0.00, '2026-02-10 17:12:37.589741', '人氣精選 TOP7');
INSERT INTO public.product VALUES (133, 4, '四季春茶王', 0.00, '2026-02-10 17:12:37.589741', '人氣精選 TOP7');
INSERT INTO public.product VALUES (134, 4, '輕焙穀麥茶', 0.00, '2026-02-10 17:12:37.589741', '人氣精選 TOP7');
INSERT INTO public.product VALUES (135, 4, '英式蜜桃風味茶', 0.00, '2026-02-10 17:12:37.589741', '人氣精選 TOP7');
INSERT INTO public.product VALUES (136, 4, '朵朵奶蓋伯爵茶', 0.00, '2026-02-10 17:12:37.589741', '人氣精選 TOP7');
INSERT INTO public.product VALUES (137, 4, '錫蘭高地莊園紅茶', 0.00, '2026-02-10 17:12:37.589741', '莊園好茶');
INSERT INTO public.product VALUES (138, 4, '皇家伯爵茶', 0.00, '2026-02-10 17:12:37.589741', '莊園好茶');
INSERT INTO public.product VALUES (139, 4, '英式玫瑰特調茶', 0.00, '2026-02-10 17:12:37.589741', '莊園好茶');
INSERT INTO public.product VALUES (140, 4, '糯烏龍', 0.00, '2026-02-10 17:12:37.589741', '莊園好茶');
INSERT INTO public.product VALUES (141, 4, '花開茉綠茶', 0.00, '2026-02-10 17:12:37.589741', '莊園好茶');
INSERT INTO public.product VALUES (142, 4, '硬頸奶茶', 0.00, '2026-02-10 17:12:37.589741', '硬頸乳茶');
INSERT INTO public.product VALUES (143, 4, '硬頸乳茶', 0.00, '2026-02-10 17:12:37.589741', '硬頸乳茶');
INSERT INTO public.product VALUES (144, 4, '蜜桃風味水果茶', 0.00, '2026-02-10 17:12:37.589741', '招牌水果茶');
INSERT INTO public.product VALUES (145, 4, '英式玫瑰水果茶', 0.00, '2026-02-10 17:12:37.589741', '招牌水果茶');
INSERT INTO public.product VALUES (146, 4, '皇家伯爵水果茶', 0.00, '2026-02-10 17:12:37.589741', '招牌水果茶');
INSERT INTO public.product VALUES (147, 4, '花開茉綠茶拿鐵', 0.00, '2026-02-10 17:12:37.589741', '英式鮮奶茶');
INSERT INTO public.product VALUES (148, 4, '錫蘭莊園紅茶拿鐵', 0.00, '2026-02-10 17:12:37.589741', '英式鮮奶茶');
INSERT INTO public.product VALUES (149, 4, '蜜桃風味拿鐵', 0.00, '2026-02-10 17:12:37.589741', '英式鮮奶茶');
INSERT INTO public.product VALUES (150, 4, '皇家伯爵拿鐵', 0.00, '2026-02-10 17:12:37.589741', '英式鮮奶茶');
INSERT INTO public.product VALUES (151, 4, '巧克力伯爵拿鐵', 0.00, '2026-02-10 17:12:37.589741', '英式鮮奶茶');
INSERT INTO public.product VALUES (152, 4, '輕焙穀麥拿鐵', 0.00, '2026-02-10 17:12:37.589741', '英式鮮奶茶');
INSERT INTO public.product VALUES (153, 4, '糯烏龍拿鐵', 0.00, '2026-02-10 17:12:37.589741', '英式鮮奶茶');
INSERT INTO public.product VALUES (154, 4, '朵朵奶蓋蜜桃風味茶', 0.00, '2026-02-10 17:12:37.589741', '朵朵海鹽奶蓋');
INSERT INTO public.product VALUES (155, 4, '蜂蜜花開茉綠茶', 0.00, '2026-02-10 17:12:37.589741', '特調');
INSERT INTO public.product VALUES (156, 4, '蜂蜜四季春茶', 0.00, '2026-02-10 17:12:37.589741', '特調');
INSERT INTO public.product VALUES (157, 4, '玫瑰水', 0.00, '2026-02-10 17:12:37.589741', '特調');
INSERT INTO public.product VALUES (158, 4, '冬瓜糯烏龍', 0.00, '2026-02-10 17:12:37.589741', '特調');
INSERT INTO public.product VALUES (159, 4, '錫蘭高地莊園奶茶', 0.00, '2026-02-10 17:12:37.589741', '精選奶茶');
INSERT INTO public.product VALUES (160, 4, '花開茉綠奶茶', 0.00, '2026-02-10 17:12:37.589741', '精選奶茶');
INSERT INTO public.product VALUES (161, 4, '蜜桃風味奶茶', 0.00, '2026-02-10 17:12:37.589741', '精選奶茶');
INSERT INTO public.product VALUES (162, 4, '皇家伯爵奶茶', 0.00, '2026-02-10 17:12:37.589741', '精選奶茶');
INSERT INTO public.product VALUES (163, 4, '英式玫瑰奶茶', 0.00, '2026-02-10 17:12:37.589741', '精選奶茶');
INSERT INTO public.product VALUES (164, 4, '巧克力伯爵奶茶', 0.00, '2026-02-10 17:12:37.589741', '精選奶茶');
INSERT INTO public.product VALUES (165, 4, '錫蘭高地珍珠奶茶', 0.00, '2026-02-10 17:12:37.589741', '精選奶茶');
INSERT INTO public.product VALUES (166, 4, '輕焙穀麥奶茶', 0.00, '2026-02-10 17:12:37.589741', '精選奶茶');
INSERT INTO public.product VALUES (167, 5, '白韻杏仁奶', 0.00, '2026-02-10 17:12:37.589741', '新品系列');
INSERT INTO public.product VALUES (168, 5, '白韻杏仁鮮奶', 0.00, '2026-02-10 17:12:37.589741', '新品系列');
INSERT INTO public.product VALUES (169, 5, '白韻杏仁頂級可可', 0.00, '2026-02-10 17:12:37.589741', '新品系列');
INSERT INTO public.product VALUES (170, 5, '桂圓茶', 0.00, '2026-02-10 17:12:37.589741', '冬季熱飲');
INSERT INTO public.product VALUES (171, 5, '桂圓鮮奶茶', 0.00, '2026-02-10 17:12:37.589741', '冬季熱飲');
INSERT INTO public.product VALUES (172, 5, '薑薑好茶', 0.00, '2026-02-10 17:12:37.589741', '冬季熱飲');
INSERT INTO public.product VALUES (173, 5, '薑薑奶茶', 0.00, '2026-02-10 17:12:37.589741', '冬季熱飲');
INSERT INTO public.product VALUES (174, 5, '烏龍綠茶', 0.00, '2026-02-10 17:12:37.589741', '茗品系列');
INSERT INTO public.product VALUES (175, 5, '特級綠茶', 0.00, '2026-02-10 17:12:37.589741', '茗品系列');
INSERT INTO public.product VALUES (176, 5, '錫蘭紅茶', 0.00, '2026-02-10 17:12:37.589741', '茗品系列');
INSERT INTO public.product VALUES (177, 5, '極品菁茶', 0.00, '2026-02-10 17:12:37.589741', '茗品系列');
INSERT INTO public.product VALUES (178, 5, '特選普洱', 0.00, '2026-02-10 17:12:37.589741', '茗品系列');
INSERT INTO public.product VALUES (179, 5, '烏龍菁茶', 0.00, '2026-02-10 17:12:37.589741', '茗品系列');
INSERT INTO public.product VALUES (180, 5, '@綠+紅', 0.00, '2026-02-10 17:12:37.589741', '茗品系列');
INSERT INTO public.product VALUES (181, 5, '冬瓜茶', 0.00, '2026-02-10 17:12:37.589741', '冬瓜/百香系列');
INSERT INTO public.product VALUES (182, 5, '冬瓜檸檬', 0.00, '2026-02-10 17:12:37.589741', '冬瓜/百香系列');
INSERT INTO public.product VALUES (183, 5, '冬瓜菁茶', 0.00, '2026-02-10 17:12:37.589741', '冬瓜/百香系列');
INSERT INTO public.product VALUES (184, 5, '百香果綠茶', 0.00, '2026-02-10 17:12:37.589741', '冬瓜/百香系列');
INSERT INTO public.product VALUES (185, 5, '雙Q百香果綠茶', 0.00, '2026-02-10 17:12:37.589741', '冬瓜/百香系列');
INSERT INTO public.product VALUES (186, 5, '蜜桃凍紅茶', 0.00, '2026-02-10 17:12:37.589741', '特調系列');
INSERT INTO public.product VALUES (187, 5, '梅子綠茶', 0.00, '2026-02-10 17:12:37.589741', '特調系列');
INSERT INTO public.product VALUES (188, 5, '蜂蜜烏龍', 0.00, '2026-02-10 17:12:37.589741', '特調系列');
INSERT INTO public.product VALUES (189, 5, '頂級可可', 0.00, '2026-02-10 17:12:37.589741', '特調系列');
INSERT INTO public.product VALUES (190, 5, '濃情巧克力', 0.00, '2026-02-10 17:12:37.589741', '特調系列');
INSERT INTO public.product VALUES (191, 5, '蜜茶', 0.00, '2026-02-10 17:12:37.589741', '特調系列');
INSERT INTO public.product VALUES (192, 5, '咖啡奶茶', 0.00, '2026-02-10 17:12:37.589741', '特調系列');
INSERT INTO public.product VALUES (193, 5, '蜂蜜綠茶', 0.00, '2026-02-10 17:12:37.589741', '特調系列');
INSERT INTO public.product VALUES (194, 5, '荔枝紅茶', 0.00, '2026-02-10 17:12:37.589741', '特調系列');
INSERT INTO public.product VALUES (195, 5, '妃嚐美荔', 0.00, '2026-02-10 17:12:37.589741', '特調系列');
INSERT INTO public.product VALUES (196, 5, '桔茶', 0.00, '2026-02-10 17:12:37.589741', '季節鮮果系列');
INSERT INTO public.product VALUES (197, 5, '鮮橙綠', 0.00, '2026-02-10 17:12:37.589741', '季節鮮果系列');
INSERT INTO public.product VALUES (198, 5, '甘蔗金桔', 0.00, '2026-02-10 17:12:37.589741', '季節鮮果系列');
INSERT INTO public.product VALUES (199, 5, '甘蔗菁茶', 0.00, '2026-02-10 17:12:37.589741', '季節鮮果系列');
INSERT INTO public.product VALUES (200, 5, '鳳梨紅茶', 0.00, '2026-02-10 17:12:37.589741', '季節鮮果系列');
INSERT INTO public.product VALUES (201, 5, '珍珠琥珀黑糖鮮奶', 0.00, '2026-02-10 17:12:37.589741', '鮮奶/拿鐵系列');
INSERT INTO public.product VALUES (202, 5, '鮮奶茶', 0.00, '2026-02-10 17:12:37.589741', '鮮奶/拿鐵系列');
INSERT INTO public.product VALUES (203, 5, '珍珠鮮奶茶', 0.00, '2026-02-10 17:12:37.589741', '鮮奶/拿鐵系列');
INSERT INTO public.product VALUES (204, 5, '(隱藏版)珍珠蜂蜜鮮奶普洱', 0.00, '2026-02-10 17:12:37.589741', '鮮奶/拿鐵系列');
INSERT INTO public.product VALUES (205, 5, '頂級可可拿鐵', 0.00, '2026-02-10 17:12:37.589741', '鮮奶/拿鐵系列');
INSERT INTO public.product VALUES (206, 5, '鮮奶冬瓜', 0.00, '2026-02-10 17:12:37.589741', '鮮奶/拿鐵系列');
INSERT INTO public.product VALUES (207, 5, '咖啡拿鐵', 0.00, '2026-02-10 17:12:37.589741', '鮮奶/拿鐵系列');
INSERT INTO public.product VALUES (208, 5, '珍珠芝麻拿鐵', 0.00, '2026-02-10 17:12:37.589741', '鮮奶/拿鐵系列');
INSERT INTO public.product VALUES (209, 5, '雙凍拿鐵(綠茶凍、仙草凍)', 0.00, '2026-02-10 17:12:37.589741', '鮮奶/拿鐵系列');
INSERT INTO public.product VALUES (210, 5, '茉綠茶凍拿鐵', 0.00, '2026-02-10 17:12:37.589741', '鮮奶/拿鐵系列');
INSERT INTO public.product VALUES (211, 5, '粉戀莓莓', 0.00, '2026-02-10 17:12:37.589741', '鮮奶/拿鐵系列');
INSERT INTO public.product VALUES (212, 5, '琥珀黑糖奶茶', 0.00, '2026-02-10 17:12:37.589741', '奶茶系列');
INSERT INTO public.product VALUES (213, 5, '珍珠奶茶', 0.00, '2026-02-10 17:12:37.589741', '奶茶系列');
INSERT INTO public.product VALUES (214, 5, '錫蘭奶紅', 0.00, '2026-02-10 17:12:37.589741', '奶茶系列');
INSERT INTO public.product VALUES (215, 5, '烏龍奶茶', 0.00, '2026-02-10 17:12:37.589741', '奶茶系列');
INSERT INTO public.product VALUES (216, 5, '特級奶綠', 0.00, '2026-02-10 17:12:37.589741', '奶茶系列');
INSERT INTO public.product VALUES (217, 5, '仙草凍奶茶', 0.00, '2026-02-10 17:12:37.589741', '奶茶系列');
INSERT INTO public.product VALUES (218, 5, '椰果奶茶', 0.00, '2026-02-10 17:12:37.589741', '奶茶系列');
INSERT INTO public.product VALUES (219, 5, '布丁奶茶', 0.00, '2026-02-10 17:12:37.589741', '奶茶系列');
INSERT INTO public.product VALUES (220, 5, '暗黑水晶奶茶', 0.00, '2026-02-10 17:12:37.589741', '奶茶系列');
INSERT INTO public.product VALUES (221, 5, '蜂蜜奶茶', 0.00, '2026-02-10 17:12:37.589741', '奶茶系列');
INSERT INTO public.product VALUES (222, 5, '芝麻奶茶', 0.00, '2026-02-10 17:12:37.589741', '奶茶系列');
INSERT INTO public.product VALUES (223, 5, '極品奶菁', 0.00, '2026-02-10 17:12:37.589741', '奶茶系列');
INSERT INTO public.product VALUES (224, 5, '烏龍奶菁', 0.00, '2026-02-10 17:12:37.589741', '奶茶系列');
INSERT INTO public.product VALUES (225, 5, '普洱奶茶', 0.00, '2026-02-10 17:12:37.589741', '奶茶系列');
INSERT INTO public.product VALUES (226, 5, '奶茶', 0.00, '2026-02-10 17:12:37.589741', '奶茶系列');
INSERT INTO public.product VALUES (227, 5, '茶凍奶綠', 0.00, '2026-02-10 17:12:37.589741', '奶茶系列');
INSERT INTO public.product VALUES (228, 5, '優多綠茶', 0.00, '2026-02-10 17:12:37.589741', '優多系列');
INSERT INTO public.product VALUES (229, 5, '優多百香果綠茶', 0.00, '2026-02-10 17:12:37.589741', '優多系列');
INSERT INTO public.product VALUES (230, 5, '紅心芭樂優多', 0.00, '2026-02-10 17:12:37.589741', '優多系列');
INSERT INTO public.product VALUES (231, 5, '優多莓莓', 0.00, '2026-02-10 17:12:37.589741', '優多系列');
INSERT INTO public.product VALUES (232, 5, '蘋果醋', 0.00, '2026-02-10 17:12:37.589741', '果醋系列');
INSERT INTO public.product VALUES (233, 5, '蘋果醋紅茶', 0.00, '2026-02-10 17:12:37.589741', '果醋系列');
INSERT INTO public.product VALUES (234, 5, '蜂蜜蘋果醋', 0.00, '2026-02-10 17:12:37.589741', '果醋系列');
INSERT INTO public.product VALUES (235, 5, '藍莓醋', 0.00, '2026-02-10 17:12:37.589741', '果醋系列');
INSERT INTO public.product VALUES (236, 5, '蜂蜜藍莓醋', 0.00, '2026-02-10 17:12:37.589741', '果醋系列');
INSERT INTO public.product VALUES (237, 5, '荔枝蘋果醋', 0.00, '2026-02-10 17:12:37.589741', '果醋系列');
INSERT INTO public.product VALUES (238, 5, 'Red Bull紅牛能量紅茶', 0.00, '2026-02-10 17:12:37.589741', 'Red Bull能量系列');
INSERT INTO public.product VALUES (239, 5, 'Red Bull紅牛能量藍莓蜜', 0.00, '2026-02-10 17:12:37.589741', 'Red Bull能量系列');
INSERT INTO public.product VALUES (240, 5, 'Red Bull巨峰葡萄能量優多', 0.00, '2026-02-10 17:12:37.589741', 'Red Bull能量系列');
INSERT INTO public.product VALUES (241, 5, 'Red Bull巨峰葡萄能量果醋', 0.00, '2026-02-10 17:12:37.589741', 'Red Bull能量系列');
INSERT INTO public.product VALUES (242, 6, '桂香輕蕎麥', 0.00, '2026-02-10 17:12:37.589741', '熱銷新品');
INSERT INTO public.product VALUES (243, 6, '娜杯桂香拿鐵', 0.00, '2026-02-10 17:12:37.589741', '熱銷新品');
INSERT INTO public.product VALUES (244, 6, '香芋仙草綠茶拿鐵', 0.00, '2026-02-10 17:12:37.589741', '熱銷新品');
INSERT INTO public.product VALUES (245, 6, '靜岡焙焙鮮奶', 0.00, '2026-02-10 17:12:37.589741', '熱銷新品');
INSERT INTO public.product VALUES (246, 6, '娜杯紅茶', 0.00, '2026-02-10 17:12:37.589741', '愛茶的牛');
INSERT INTO public.product VALUES (247, 6, '茉莉原淬綠茶', 0.00, '2026-02-10 17:12:37.589741', '愛茶的牛');
INSERT INTO public.product VALUES (248, 6, '水之森玄米抹茶', 0.00, '2026-02-10 17:12:37.589741', '愛茶的牛');
INSERT INTO public.product VALUES (249, 6, '熟釀青梅綠', 0.00, '2026-02-10 17:12:37.589741', '鮮調果茶');
INSERT INTO public.product VALUES (250, 6, '熟釀青梅檸', 0.00, '2026-02-10 17:12:37.589741', '鮮調果茶');
INSERT INTO public.product VALUES (251, 6, '香柚綠茶', 0.00, '2026-02-10 17:12:37.589741', '鮮調果茶');
INSERT INTO public.product VALUES (252, 6, '養樂多綠', 0.00, '2026-02-10 17:12:37.589741', '鮮調果茶');
INSERT INTO public.product VALUES (253, 6, '青檸香茶', 0.00, '2026-02-10 17:12:37.589741', '鮮調果茶');
INSERT INTO public.product VALUES (254, 6, '柳丁綠茶', 0.00, '2026-02-10 17:12:37.589741', '鮮調果茶');
INSERT INTO public.product VALUES (255, 6, '冰萃柳丁', 0.00, '2026-02-10 17:12:37.589741', '鮮調果茶');
INSERT INTO public.product VALUES (256, 6, '蜂蜜檸檬晶凍', 0.00, '2026-02-10 17:12:37.589741', '鮮調果茶');
INSERT INTO public.product VALUES (257, 6, '娜杯紅茶拿鐵', 0.00, '2026-02-10 17:12:37.589741', '醇濃鮮奶茶');
INSERT INTO public.product VALUES (258, 6, '茉香綠茶拿鐵', 0.00, '2026-02-10 17:12:37.589741', '醇濃鮮奶茶');
INSERT INTO public.product VALUES (259, 6, '珍珠娜杯紅茶拿鐵', 0.00, '2026-02-10 17:12:37.589741', '醇濃鮮奶茶');
INSERT INTO public.product VALUES (260, 6, '芋頭鮮奶', 0.00, '2026-02-10 17:12:37.589741', '醇濃綠光鮮奶');
INSERT INTO public.product VALUES (261, 6, '手炒黑糖鮮奶', 0.00, '2026-02-10 17:12:37.589741', '醇濃綠光鮮奶');
INSERT INTO public.product VALUES (262, 6, '法芙娜可可鮮奶', 0.00, '2026-02-10 17:12:37.589741', '醇濃綠光鮮奶');
INSERT INTO public.product VALUES (263, 6, '珍珠鮮奶', 0.00, '2026-02-10 17:12:37.589741', '醇濃綠光鮮奶');
INSERT INTO public.product VALUES (264, 6, '嫩仙草凍奶', 0.00, '2026-02-10 17:12:37.589741', '醇濃綠光鮮奶');
INSERT INTO public.product VALUES (265, 6, '綠光純鮮奶家庭號', 0.00, '2026-02-10 17:12:37.589741', '醇濃綠光鮮奶');
INSERT INTO public.product VALUES (266, 6, '玄米抹茶鮮奶', 0.00, '2026-02-10 17:12:37.589741', '醇濃綠光鮮奶');
INSERT INTO public.product VALUES (267, 6, '輕纖蕎麥拿鐵', 0.00, '2026-02-10 17:12:37.589741', '無咖啡因');
INSERT INTO public.product VALUES (268, 6, '輕纖蕎麥茶', 0.00, '2026-02-10 17:12:37.589741', '無咖啡因');
INSERT INTO public.product VALUES (269, 6, '原鄉冬瓜茶', 0.00, '2026-02-10 17:12:37.589741', '無咖啡因');
INSERT INTO public.product VALUES (270, 6, '焙香決明大麥', 0.00, '2026-02-10 17:12:37.589741', '無咖啡因');
INSERT INTO public.product VALUES (271, 6, '焙香大麥拿鐵', 0.00, '2026-02-10 17:12:37.589741', '無咖啡因');
INSERT INTO public.product VALUES (272, 6, '冬瓜檸檬', 0.00, '2026-02-10 17:12:37.589741', '無咖啡因');
INSERT INTO public.product VALUES (273, 6, '冬瓜麥茶', 0.00, '2026-02-10 17:12:37.589741', '無咖啡因');
INSERT INTO public.product VALUES (274, 7, '小葉紅茶', 0.00, '2026-02-10 17:12:37.589741', '原葉鮮萃茶 TEAPRESSO');
INSERT INTO public.product VALUES (275, 7, '鮮萃大麥紅茶', 0.00, '2026-02-10 17:12:37.589741', '原葉鮮萃茶 TEAPRESSO');
INSERT INTO public.product VALUES (276, 7, '嗨神', 0.00, '2026-02-10 17:12:37.589741', '原葉鮮萃茶 TEAPRESSO');
INSERT INTO public.product VALUES (277, 7, '玩火', 0.00, '2026-02-10 17:12:37.589741', '原葉鮮萃茶 TEAPRESSO');
INSERT INTO public.product VALUES (278, 7, '四季春', 0.00, '2026-02-10 17:12:37.589741', '原葉鮮萃茶 TEAPRESSO');
INSERT INTO public.product VALUES (279, 7, '烏龍綠茶', 0.00, '2026-02-10 17:12:37.589741', '原葉鮮萃茶 TEAPRESSO');
INSERT INTO public.product VALUES (280, 7, '碧螺春', 0.00, '2026-02-10 17:12:37.589741', '原葉鮮萃茶 TEAPRESSO');
INSERT INTO public.product VALUES (281, 7, '金萱茶', 0.00, '2026-02-10 17:12:37.589741', '原葉鮮萃茶 TEAPRESSO');
INSERT INTO public.product VALUES (282, 7, '茉莉烏龍', 0.00, '2026-02-10 17:12:37.589741', '原葉鮮萃茶 TEAPRESSO');
INSERT INTO public.product VALUES (283, 7, '烏瓦紅茶', 0.00, '2026-02-10 17:12:37.589741', '原葉鮮萃茶 TEAPRESSO');
INSERT INTO public.product VALUES (284, 7, '熟滄觀音', 0.00, '2026-02-10 17:12:37.589741', '原葉鮮萃茶 TEAPRESSO');
INSERT INTO public.product VALUES (285, 7, '玫瑰普洱', 0.00, '2026-02-10 17:12:37.589741', '原葉鮮萃茶 TEAPRESSO');
INSERT INTO public.product VALUES (286, 7, '東方美人', 0.00, '2026-02-10 17:12:37.589741', '原葉鮮萃茶 TEAPRESSO');
INSERT INTO public.product VALUES (287, 7, '文山包種', 0.00, '2026-02-10 17:12:37.589741', '原葉鮮萃茶 TEAPRESSO');
INSERT INTO public.product VALUES (288, 7, '白桃蜜烏龍', 0.00, '2026-02-10 17:12:37.589741', '原葉鮮萃茶 TEAPRESSO');
INSERT INTO public.product VALUES (289, 7, '桂花四季春', 0.00, '2026-02-10 17:12:37.589741', '原葉鮮萃茶 TEAPRESSO');
INSERT INTO public.product VALUES (290, 7, '小葉紅奶茶', 0.00, '2026-02-10 17:12:37.589741', '鮮萃茶奶茶 TEAPRESSO MILK TEA');
INSERT INTO public.product VALUES (291, 7, '大麥奶茶', 0.00, '2026-02-10 17:12:37.589741', '鮮萃茶奶茶 TEAPRESSO MILK TEA');
INSERT INTO public.product VALUES (292, 7, '嗨神奶茶', 0.00, '2026-02-10 17:12:37.589741', '鮮萃茶奶茶 TEAPRESSO MILK TEA');
INSERT INTO public.product VALUES (293, 7, '玩火奶茶', 0.00, '2026-02-10 17:12:37.589741', '鮮萃茶奶茶 TEAPRESSO MILK TEA');
INSERT INTO public.product VALUES (294, 7, '四季春奶茶', 0.00, '2026-02-10 17:12:37.589741', '鮮萃茶奶茶 TEAPRESSO MILK TEA');
INSERT INTO public.product VALUES (295, 7, '玫瑰普洱奶茶', 0.00, '2026-02-10 17:12:37.589741', '鮮萃茶奶茶 TEAPRESSO MILK TEA');
INSERT INTO public.product VALUES (296, 7, '烏龍奶茶', 0.00, '2026-02-10 17:12:37.589741', '鮮萃茶奶茶 TEAPRESSO MILK TEA');
INSERT INTO public.product VALUES (297, 7, '茉莉烏龍奶茶', 0.00, '2026-02-10 17:12:37.589741', '鮮萃茶奶茶 TEAPRESSO MILK TEA');
INSERT INTO public.product VALUES (298, 7, '觀音奶茶', 0.00, '2026-02-10 17:12:37.589741', '鮮萃茶奶茶 TEAPRESSO MILK TEA');
INSERT INTO public.product VALUES (299, 7, '黑糖紅茶拿鐵', 0.00, '2026-02-10 17:12:37.589741', '鮮萃茶拿鐵 TEAPRESSO LATTE');
INSERT INTO public.product VALUES (300, 7, '小葉紅拿鐵', 0.00, '2026-02-10 17:12:37.589741', '鮮萃茶拿鐵 TEAPRESSO LATTE');
INSERT INTO public.product VALUES (301, 7, '四季春拿鐵', 0.00, '2026-02-10 17:12:37.589741', '鮮萃茶拿鐵 TEAPRESSO LATTE');
INSERT INTO public.product VALUES (302, 7, '玫瑰普洱拿鐵', 0.00, '2026-02-10 17:12:37.589741', '鮮萃茶拿鐵 TEAPRESSO LATTE');
INSERT INTO public.product VALUES (303, 7, '烏龍拿鐵', 0.00, '2026-02-10 17:12:37.589741', '鮮萃茶拿鐵 TEAPRESSO LATTE');
INSERT INTO public.product VALUES (304, 7, '茉莉烏龍拿鐵', 0.00, '2026-02-10 17:12:37.589741', '鮮萃茶拿鐵 TEAPRESSO LATTE');
INSERT INTO public.product VALUES (305, 7, '烏瓦紅茶拿鐵', 0.00, '2026-02-10 17:12:37.589741', '鮮萃茶拿鐵 TEAPRESSO LATTE');
INSERT INTO public.product VALUES (306, 7, '金萱拿鐵', 0.00, '2026-02-10 17:12:37.589741', '鮮萃茶拿鐵 TEAPRESSO LATTE');
INSERT INTO public.product VALUES (307, 7, '觀音拿鐵', 0.00, '2026-02-10 17:12:37.589741', '鮮萃茶拿鐵 TEAPRESSO LATTE');
INSERT INTO public.product VALUES (308, 7, '文山包種拿鐵', 0.00, '2026-02-10 17:12:37.589741', '鮮萃茶拿鐵 TEAPRESSO LATTE');
INSERT INTO public.product VALUES (309, 7, '沖繩黑糖奶茶', 0.00, '2026-02-10 17:12:37.589741', '奶茶/特調 MILK TEA / SPECIAL');
INSERT INTO public.product VALUES (310, 7, '沖繩黑糖奶綠', 0.00, '2026-02-10 17:12:37.589741', '奶茶/特調 MILK TEA / SPECIAL');
INSERT INTO public.product VALUES (311, 7, '黑糖港式厚奶', 0.00, '2026-02-10 17:12:37.589741', '奶茶/特調 MILK TEA / SPECIAL');
INSERT INTO public.product VALUES (312, 7, '雙Q奶茶1號條', 0.00, '2026-02-10 17:12:37.589741', '奶茶/特調 MILK TEA / SPECIAL');
INSERT INTO public.product VALUES (313, 7, '雙Q奶茶2號芋', 0.00, '2026-02-10 17:12:37.589741', '奶茶/特調 MILK TEA / SPECIAL');
INSERT INTO public.product VALUES (314, 7, '招牌奶茶', 0.00, '2026-02-10 17:12:37.589741', '奶茶/特調 MILK TEA / SPECIAL');
INSERT INTO public.product VALUES (315, 7, '黃金奶綠', 0.00, '2026-02-10 17:12:37.589741', '奶茶/特調 MILK TEA / SPECIAL');
INSERT INTO public.product VALUES (316, 7, '珍珠奶茶', 0.00, '2026-02-10 17:12:37.589741', '奶茶/特調 MILK TEA / SPECIAL');
INSERT INTO public.product VALUES (317, 7, '珍珠奶綠', 0.00, '2026-02-10 17:12:37.589741', '奶茶/特調 MILK TEA / SPECIAL');
INSERT INTO public.product VALUES (318, 7, '粉條奶茶', 0.00, '2026-02-10 17:12:37.589741', '奶茶/特調 MILK TEA / SPECIAL');
INSERT INTO public.product VALUES (319, 7, '仙草凍奶茶', 0.00, '2026-02-10 17:12:37.589741', '奶茶/特調 MILK TEA / SPECIAL');
INSERT INTO public.product VALUES (320, 7, '桂花奶綠', 0.00, '2026-02-10 17:12:37.589741', '奶茶/特調 MILK TEA / SPECIAL');
INSERT INTO public.product VALUES (321, 7, '港式厚奶', 0.00, '2026-02-10 17:12:37.589741', '奶茶/特調 MILK TEA / SPECIAL');
INSERT INTO public.product VALUES (322, 7, '經典可可', 0.00, '2026-02-10 17:12:37.589741', '奶茶/特調 MILK TEA / SPECIAL');
INSERT INTO public.product VALUES (323, 7, '可可拿鐵', 0.00, '2026-02-10 17:12:37.589741', '奶茶/特調 MILK TEA / SPECIAL');
INSERT INTO public.product VALUES (324, 7, '宇治抹茶', 0.00, '2026-02-10 17:12:37.589741', '奶茶/特調 MILK TEA / SPECIAL');
INSERT INTO public.product VALUES (325, 7, '抹茶拿鐵', 0.00, '2026-02-10 17:12:37.589741', '奶茶/特調 MILK TEA / SPECIAL');
INSERT INTO public.product VALUES (326, 7, '話梅冰綠', 0.00, '2026-02-10 17:12:37.589741', '鮮調果茶 SPECIALTY');
INSERT INTO public.product VALUES (327, 7, '話梅檸檬綠', 0.00, '2026-02-10 17:12:37.589741', '鮮調果茶 SPECIALTY');
INSERT INTO public.product VALUES (328, 7, '錫蘭紅茶', 0.00, '2026-02-10 17:12:37.589741', '鮮調果茶 SPECIALTY');
INSERT INTO public.product VALUES (329, 7, '茉莉綠茶', 0.00, '2026-02-10 17:12:37.589741', '鮮調果茶 SPECIALTY');
INSERT INTO public.product VALUES (330, 7, '蜂蜜紅茶', 0.00, '2026-02-10 17:12:37.589741', '鮮調果茶 SPECIALTY');
INSERT INTO public.product VALUES (331, 7, '蜂蜜綠茶', 0.00, '2026-02-10 17:12:37.589741', '鮮調果茶 SPECIALTY');
INSERT INTO public.product VALUES (332, 7, '玉荷冰綠', 0.00, '2026-02-10 17:12:37.589741', '鮮調果茶 SPECIALTY');
INSERT INTO public.product VALUES (333, 7, '檸檬紅茶', 0.00, '2026-02-10 17:12:37.589741', '鮮調果茶 SPECIALTY');
INSERT INTO public.product VALUES (334, 7, '檸檬綠茶', 0.00, '2026-02-10 17:12:37.589741', '鮮調果茶 SPECIALTY');
INSERT INTO public.product VALUES (335, 7, '養樂多綠茶', 0.00, '2026-02-10 17:12:37.589741', '鮮調果茶 SPECIALTY');
INSERT INTO public.product VALUES (336, 7, '百香搖果樂', 0.00, '2026-02-10 17:12:37.589741', '鮮調果茶 SPECIALTY');
INSERT INTO public.product VALUES (337, 7, '蘋果冰茶', 0.00, '2026-02-10 17:12:37.589741', '鮮調果茶 SPECIALTY');
INSERT INTO public.product VALUES (338, 7, '鳳梨冰茶', 0.00, '2026-02-10 17:12:37.589741', '鮮調果茶 SPECIALTY');
INSERT INTO public.product VALUES (339, 7, '芭樂檸檬綠', 0.00, '2026-02-10 17:12:37.589741', '鮮調果茶 SPECIALTY');
INSERT INTO public.product VALUES (340, 7, '超桔霸氣飲', 0.00, '2026-02-10 17:12:37.589741', '果然系列 (無咖啡因 DECAFFEINE)');
INSERT INTO public.product VALUES (341, 7, '蜂蜜蘆薈', 0.00, '2026-02-10 17:12:37.589741', '果然系列 (無咖啡因 DECAFFEINE)');
INSERT INTO public.product VALUES (342, 7, '金桔檸檬', 0.00, '2026-02-10 17:12:37.589741', '果然系列 (無咖啡因 DECAFFEINE)');
INSERT INTO public.product VALUES (343, 7, '荔枝玉露', 0.00, '2026-02-10 17:12:37.589741', '果然系列 (無咖啡因 DECAFFEINE)');
INSERT INTO public.product VALUES (344, 7, '纖美小紫蘇', 0.00, '2026-02-10 17:12:37.589741', '果然系列 (無咖啡因 DECAFFEINE)');
INSERT INTO public.product VALUES (345, 7, '芭樂多多', 0.00, '2026-02-10 17:12:37.589741', '果然系列 (無咖啡因 DECAFFEINE)');
INSERT INTO public.product VALUES (346, 7, '檸檬愛玉風味飲', 0.00, '2026-02-10 17:12:37.589741', '夏季季節限定 SEASONAL');
INSERT INTO public.product VALUES (347, 7, '葡萄柚綠茶', 0.00, '2026-02-10 17:12:37.589741', '夏季季節限定 SEASONAL');
INSERT INTO public.product VALUES (348, 7, '青檸香柚QQ', 0.00, '2026-02-10 17:12:37.589741', '夏季季節限定 SEASONAL');
INSERT INTO public.product VALUES (349, 7, '桂圓紅棗', 0.00, '2026-02-10 17:12:37.589741', '冬季季節限定 SEASONAL');
INSERT INTO public.product VALUES (350, 7, '暖薑茶', 0.00, '2026-02-10 17:12:37.589741', '冬季季節限定 SEASONAL');
INSERT INTO public.product VALUES (351, 7, '暖薑奶茶', 0.00, '2026-02-10 17:12:37.589741', '冬季季節限定 SEASONAL');
INSERT INTO public.product VALUES (352, 7, '熱檸紅茶', 0.00, '2026-02-10 17:12:37.589741', '冬季季節限定 SEASONAL');
INSERT INTO public.product VALUES (353, 7, '熱檸綠茶', 0.00, '2026-02-10 17:12:37.589741', '冬季季節限定 SEASONAL');
INSERT INTO public.product VALUES (354, 7, '熱桔茶', 0.00, '2026-02-10 17:12:37.589741', '冬季季節限定 SEASONAL');
INSERT INTO public.product VALUES (355, 7, '紫米奶茶', 0.00, '2026-02-10 17:12:37.589741', '冬季季節限定 SEASONAL');
INSERT INTO public.product VALUES (356, 7, '紫米可可', 0.00, '2026-02-10 17:12:37.589741', '冬季季節限定 SEASONAL');
INSERT INTO public.product VALUES (357, 7, '黑糖薑汁可可', 0.00, '2026-02-10 17:12:37.589741', '冬季季節限定 SEASONAL');
INSERT INTO public.product VALUES (358, 8, '極品紅茶', 0.00, '2026-02-10 17:12:37.589741', '醇萃');
INSERT INTO public.product VALUES (359, 8, '翡翠綠茶', 0.00, '2026-02-10 17:12:37.589741', '醇萃');
INSERT INTO public.product VALUES (360, 8, '青四季春', 0.00, '2026-02-10 17:12:37.589741', '醇萃');
INSERT INTO public.product VALUES (361, 8, '三韻紅萱', 0.00, '2026-02-10 17:12:37.589741', '醇萃');
INSERT INTO public.product VALUES (362, 8, '三十三茶王', 0.00, '2026-02-10 17:12:37.589741', '醇萃');
INSERT INTO public.product VALUES (363, 8, '碎銀普洱茶', 0.00, '2026-02-10 17:12:37.589741', '醇萃');
INSERT INTO public.product VALUES (364, 8, '花沫烏龍', 0.00, '2026-02-10 17:12:37.589741', '醇萃');
INSERT INTO public.product VALUES (365, 8, '紅柚翡翠', 0.00, '2026-02-10 17:12:37.589741', '鮮調');
INSERT INTO public.product VALUES (366, 8, '鮮果百香紅茶', 0.00, '2026-02-10 17:12:37.589741', '鮮調');
INSERT INTO public.product VALUES (367, 8, '鮮果百香綠茶', 0.00, '2026-02-10 17:12:37.589741', '鮮調');
INSERT INTO public.product VALUES (368, 8, '翡翠雷夢', 0.00, '2026-02-10 17:12:37.589741', '鮮調');
INSERT INTO public.product VALUES (369, 8, '柳丁翡翠', 0.00, '2026-02-10 17:12:37.589741', '鮮調');
INSERT INTO public.product VALUES (370, 8, '蘋果紅萱', 0.00, '2026-02-10 17:12:37.589741', '鮮調');
INSERT INTO public.product VALUES (371, 8, '蜜桃烏龍', 0.00, '2026-02-10 17:12:37.589741', '鮮調');
INSERT INTO public.product VALUES (372, 8, '阿源楊桃紅茶', 0.00, '2026-02-10 17:12:37.589741', '鄉韻');
INSERT INTO public.product VALUES (373, 8, '阿源楊桃綠茶', 0.00, '2026-02-10 17:12:37.589741', '鄉韻');
INSERT INTO public.product VALUES (374, 8, '楊桃雷夢', 0.00, '2026-02-10 17:12:37.589741', '鄉韻');
INSERT INTO public.product VALUES (375, 8, '冬瓜雷夢', 0.00, '2026-02-10 17:12:37.589741', '鄉韻');
INSERT INTO public.product VALUES (376, 8, '冬瓜茶王', 0.00, '2026-02-10 17:12:37.589741', '鄉韻');
INSERT INTO public.product VALUES (377, 8, '甘蔗四季春', 0.00, '2026-02-10 17:12:37.589741', '鄉韻');
INSERT INTO public.product VALUES (378, 8, '豆漿紅茶', 0.00, '2026-02-10 17:12:37.589741', '鄉韻');
INSERT INTO public.product VALUES (379, 8, '冬瓜鮮乳', 0.00, '2026-02-10 17:12:37.589741', '小農鮮乳坊');
INSERT INTO public.product VALUES (380, 8, '巧克鮮乳茶', 0.00, '2026-02-10 17:12:37.589741', '小農鮮乳坊');
INSERT INTO public.product VALUES (381, 8, '龜記濃乳茶', 0.00, '2026-02-10 17:12:37.589741', '小農鮮乳坊');
INSERT INTO public.product VALUES (382, 8, '極品鮮乳茶', 0.00, '2026-02-10 17:12:37.589741', '小農鮮乳坊');
INSERT INTO public.product VALUES (383, 8, '翡翠鮮乳茶', 0.00, '2026-02-10 17:12:37.589741', '小農鮮乳坊');
INSERT INTO public.product VALUES (384, 8, '碎銀普洱鮮乳', 0.00, '2026-02-10 17:12:37.589741', '小農鮮乳坊');
INSERT INTO public.product VALUES (385, 8, '茶王鮮乳茶', 0.00, '2026-02-10 17:12:37.589741', '小農鮮乳坊');
INSERT INTO public.product VALUES (386, 8, '蜂蜜綠茶', 0.00, '2026-02-10 17:12:37.589741', '蜜蜂工坊');
INSERT INTO public.product VALUES (387, 8, '蜂蜜四季春', 0.00, '2026-02-10 17:12:37.589741', '蜜蜂工坊');
INSERT INTO public.product VALUES (388, 8, '蜂蜜雷夢', 0.00, '2026-02-10 17:12:37.589741', '蜜蜂工坊');
INSERT INTO public.product VALUES (389, 8, '雷夢蘆薈蜜', 0.00, '2026-02-10 17:12:37.589741', '蜜蜂工坊');
INSERT INTO public.product VALUES (390, 8, '蜂蜜花沫烏龍', 0.00, '2026-02-10 17:12:37.589741', '蜜蜂工坊');
INSERT INTO public.product VALUES (391, 8, '蜂蜜奶茶', 0.00, '2026-02-10 17:12:37.589741', '奶茶');
INSERT INTO public.product VALUES (392, 8, '極品奶茶', 0.00, '2026-02-10 17:12:37.589741', '奶茶');
INSERT INTO public.product VALUES (393, 8, '翡翠奶茶', 0.00, '2026-02-10 17:12:37.589741', '奶茶');
INSERT INTO public.product VALUES (394, 8, '茶王奶茶', 0.00, '2026-02-10 17:12:37.589741', '奶茶');
INSERT INTO public.product VALUES (395, 8, '碎銀普洱奶茶', 0.00, '2026-02-10 17:12:37.589741', '奶茶');
INSERT INTO public.product VALUES (396, 8, '珍珠奶茶', 0.00, '2026-02-10 17:12:37.589741', '奶茶');
INSERT INTO public.product VALUES (397, 8, '原味薑茶', 0.00, '2026-02-10 17:12:37.589741', '冬日暖飲');
INSERT INTO public.product VALUES (398, 8, '薑汁奶茶', 0.00, '2026-02-10 17:12:37.589741', '冬日暖飲');
INSERT INTO public.product VALUES (399, 8, '薑汁雷夢', 0.00, '2026-02-10 17:12:37.589741', '冬日暖飲');
INSERT INTO public.product VALUES (400, 9, '阿薩姆紅茶', 0.00, '2026-02-10 17:12:37.589741', '找好茶');
INSERT INTO public.product VALUES (401, 9, '茉莉綠茶', 0.00, '2026-02-10 17:12:37.589741', '找好茶');
INSERT INTO public.product VALUES (402, 9, '四季春青茶', 0.00, '2026-02-10 17:12:37.589741', '找好茶');
INSERT INTO public.product VALUES (403, 9, '黃金烏龍', 0.00, '2026-02-10 17:12:37.589741', '找好茶');
INSERT INTO public.product VALUES (404, 9, '檸檬綠', 0.00, '2026-02-10 17:12:37.589741', '找好茶');
INSERT INTO public.product VALUES (405, 9, '檸檬紅', 0.00, '2026-02-10 17:12:37.589741', '找好茶');
INSERT INTO public.product VALUES (406, 9, '梅の綠', 0.00, '2026-02-10 17:12:37.589741', '找好茶');
INSERT INTO public.product VALUES (407, 9, '冰綠', 0.00, '2026-02-10 17:12:37.589741', '找好茶');
INSERT INTO public.product VALUES (408, 9, '桔子綠', 0.00, '2026-02-10 17:12:37.589741', '找好茶');
INSERT INTO public.product VALUES (409, 9, '養樂多綠', 0.00, '2026-02-10 17:12:37.589741', '找好茶');
INSERT INTO public.product VALUES (410, 9, '旺來紅', 0.00, '2026-02-10 17:12:37.589741', '找好茶');
INSERT INTO public.product VALUES (411, 9, '旺來綠', 0.00, '2026-02-10 17:12:37.589741', '找好茶');
INSERT INTO public.product VALUES (412, 9, '柚子烏龍', 0.00, '2026-02-10 17:12:37.589741', '找好茶');
INSERT INTO public.product VALUES (413, 9, '麵茶綠', 0.00, '2026-02-10 17:12:37.589741', '找好茶');
INSERT INTO public.product VALUES (414, 9, '麵茶紅', 0.00, '2026-02-10 17:12:37.589741', '找好茶');
INSERT INTO public.product VALUES (415, 9, '麵茶青', 0.00, '2026-02-10 17:12:37.589741', '找好茶');
INSERT INTO public.product VALUES (416, 9, '麵茶烏龍', 0.00, '2026-02-10 17:12:37.589741', '找好茶');
INSERT INTO public.product VALUES (417, 9, '柚子紅', 0.00, '2026-02-10 17:12:37.589741', '找好茶');
INSERT INTO public.product VALUES (418, 9, '柚子綠', 0.00, '2026-02-10 17:12:37.589741', '找好茶');
INSERT INTO public.product VALUES (419, 9, '柚子青', 0.00, '2026-02-10 17:12:37.589741', '找好茶');
INSERT INTO public.product VALUES (420, 9, '奶茶', 0.00, '2026-02-10 17:12:37.589741', '找奶茶');
INSERT INTO public.product VALUES (421, 9, '奶綠', 0.00, '2026-02-10 17:12:37.589741', '找奶茶');
INSERT INTO public.product VALUES (422, 9, '紅茶瑪奇朵', 0.00, '2026-02-10 17:12:37.589741', '找奶茶');
INSERT INTO public.product VALUES (423, 9, '綠茶瑪奇朵', 0.00, '2026-02-10 17:12:37.589741', '找奶茶');
INSERT INTO public.product VALUES (424, 9, '四季瑪奇朵', 0.00, '2026-02-10 17:12:37.589741', '找奶茶');
INSERT INTO public.product VALUES (425, 9, '烏龍瑪奇朵', 0.00, '2026-02-10 17:12:37.589741', '找奶茶');
INSERT INTO public.product VALUES (426, 9, '四季奶青', 0.00, '2026-02-10 17:12:37.589741', '找奶茶');
INSERT INTO public.product VALUES (427, 9, '黃金烏龍奶', 0.00, '2026-02-10 17:12:37.589741', '找奶茶');
INSERT INTO public.product VALUES (428, 9, '阿華田', 0.00, '2026-02-10 17:12:37.589741', '找奶茶');
INSERT INTO public.product VALUES (429, 9, '麵茶奶綠', 0.00, '2026-02-10 17:12:37.589741', '找奶茶');
INSERT INTO public.product VALUES (430, 9, '麵茶奶茶', 0.00, '2026-02-10 17:12:37.589741', '找奶茶');
INSERT INTO public.product VALUES (431, 9, '麵茶四季奶青', 0.00, '2026-02-10 17:12:37.589741', '找奶茶');
INSERT INTO public.product VALUES (432, 9, '麵茶黃金烏龍奶', 0.00, '2026-02-10 17:12:37.589741', '找奶茶');
INSERT INTO public.product VALUES (433, 9, '波霸紅茶', 0.00, '2026-02-10 17:12:37.589741', '找口感');
INSERT INTO public.product VALUES (434, 9, '波霸綠茶', 0.00, '2026-02-10 17:12:37.589741', '找口感');
INSERT INTO public.product VALUES (435, 9, '波霸青茶', 0.00, '2026-02-10 17:12:37.589741', '找口感');
INSERT INTO public.product VALUES (436, 9, '波霸烏龍茶', 0.00, '2026-02-10 17:12:37.589741', '找口感');
INSERT INTO public.product VALUES (437, 9, '波霸奶茶', 0.00, '2026-02-10 17:12:37.589741', '找口感');
INSERT INTO public.product VALUES (438, 9, '波霸奶綠', 0.00, '2026-02-10 17:12:37.589741', '找口感');
INSERT INTO public.product VALUES (439, 9, '珍珠紅茶', 0.00, '2026-02-10 17:12:37.589741', '找口感');
INSERT INTO public.product VALUES (440, 9, '珍珠綠茶', 0.00, '2026-02-10 17:12:37.589741', '找口感');
INSERT INTO public.product VALUES (441, 9, '珍珠青茶', 0.00, '2026-02-10 17:12:37.589741', '找口感');
INSERT INTO public.product VALUES (442, 9, '珍珠黃金烏龍', 0.00, '2026-02-10 17:12:37.589741', '找口感');
INSERT INTO public.product VALUES (443, 9, '珍珠奶茶', 0.00, '2026-02-10 17:12:37.589741', '找口感');
INSERT INTO public.product VALUES (444, 9, '布丁奶茶', 0.00, '2026-02-10 17:12:37.589741', '找口感');
INSERT INTO public.product VALUES (445, 9, '布丁奶綠', 0.00, '2026-02-10 17:12:37.589741', '找口感');
INSERT INTO public.product VALUES (446, 9, '布丁奶青', 0.00, '2026-02-10 17:12:37.589741', '找口感');
INSERT INTO public.product VALUES (447, 9, '椰果奶茶', 0.00, '2026-02-10 17:12:37.589741', '找口感');
INSERT INTO public.product VALUES (448, 9, '布丁黃金烏龍', 0.00, '2026-02-10 17:12:37.589741', '找口感');
INSERT INTO public.product VALUES (449, 9, '布丁紅', 0.00, '2026-02-10 17:12:37.589741', '找口感');
INSERT INTO public.product VALUES (450, 9, '布丁綠', 0.00, '2026-02-10 17:12:37.589741', '找口感');
INSERT INTO public.product VALUES (451, 9, '布丁青', 0.00, '2026-02-10 17:12:37.589741', '找口感');
INSERT INTO public.product VALUES (452, 9, '布丁烏龍奶茶', 0.00, '2026-02-10 17:12:37.589741', '找口感');
INSERT INTO public.product VALUES (453, 9, '紅茶拿鐵', 0.00, '2026-02-10 17:12:37.589741', '紅茶拿鐵');
INSERT INTO public.product VALUES (454, 9, '綠茶拿鐵', 0.00, '2026-02-10 17:12:37.589741', '紅茶拿鐵');
INSERT INTO public.product VALUES (455, 9, '黃金烏龍拿鐵', 0.00, '2026-02-10 17:12:37.589741', '紅茶拿鐵');
INSERT INTO public.product VALUES (456, 9, '阿華田拿鐵', 0.00, '2026-02-10 17:12:37.589741', '紅茶拿鐵');
INSERT INTO public.product VALUES (457, 9, '珍珠鮮奶', 0.00, '2026-02-10 17:12:37.589741', '紅茶拿鐵');
INSERT INTO public.product VALUES (458, 9, '波霸鮮奶', 0.00, '2026-02-10 17:12:37.589741', '紅茶拿鐵');
INSERT INTO public.product VALUES (459, 9, '重焙烏龍拿鐵', 0.00, '2026-02-10 17:12:37.589741', '紅茶拿鐵');
INSERT INTO public.product VALUES (460, 9, '麵茶綠茶拿鐵', 0.00, '2026-02-10 17:12:37.589741', '紅茶拿鐵');
INSERT INTO public.product VALUES (461, 9, '麵茶紅茶拿鐵', 0.00, '2026-02-10 17:12:37.589741', '紅茶拿鐵');
INSERT INTO public.product VALUES (462, 9, '麵茶四季拿鐵', 0.00, '2026-02-10 17:12:37.589741', '紅茶拿鐵');
INSERT INTO public.product VALUES (463, 9, '麵茶黃金烏龍拿鐵', 0.00, '2026-02-10 17:12:37.589741', '紅茶拿鐵');
INSERT INTO public.product VALUES (464, 9, '麵茶重焙烏龍拿鐵', 0.00, '2026-02-10 17:12:37.589741', '紅茶拿鐵');
INSERT INTO public.product VALUES (465, 9, '冰茶', 0.00, '2026-02-10 17:12:37.589741', '找新鮮');
INSERT INTO public.product VALUES (466, 9, '檸檬養樂多', 0.00, '2026-02-10 17:12:37.589741', '找新鮮');
INSERT INTO public.product VALUES (467, 9, '檸檬汁', 0.00, '2026-02-10 17:12:37.589741', '找新鮮');
INSERT INTO public.product VALUES (468, 9, '金桔檸檬', 0.00, '2026-02-10 17:12:37.589741', '找新鮮');
INSERT INTO public.product VALUES (469, 9, '檸檬梅汁', 0.00, '2026-02-10 17:12:37.589741', '找新鮮');
INSERT INTO public.product VALUES (470, 9, '柚子茶', 0.00, '2026-02-10 17:12:37.589741', '找新鮮');
INSERT INTO public.product VALUES (471, 9, '芒果紅', 0.00, '2026-02-10 17:12:37.589741', '找冰淇淋');
INSERT INTO public.product VALUES (472, 9, '芒果綠', 0.00, '2026-02-10 17:12:37.589741', '找冰淇淋');
INSERT INTO public.product VALUES (473, 9, '芒果青', 0.00, '2026-02-10 17:12:37.589741', '找冰淇淋');
INSERT INTO public.product VALUES (474, 9, '芒果烏龍', 0.00, '2026-02-10 17:12:37.589741', '找冰淇淋');
INSERT INTO public.product VALUES (475, 9, '荔枝紅', 0.00, '2026-02-10 17:12:37.589741', '找冰淇淋');
INSERT INTO public.product VALUES (476, 9, '荔枝綠', 0.00, '2026-02-10 17:12:37.589741', '找冰淇淋');
INSERT INTO public.product VALUES (477, 9, '荔枝青', 0.00, '2026-02-10 17:12:37.589741', '找冰淇淋');
INSERT INTO public.product VALUES (478, 9, '荔枝烏龍', 0.00, '2026-02-10 17:12:37.589741', '找冰淇淋');
INSERT INTO public.product VALUES (479, 9, '冰淇淋紅茶', 0.00, '2026-02-10 17:12:37.589741', '找冰淇淋');
INSERT INTO public.product VALUES (480, 9, '冰淇淋綠茶', 0.00, '2026-02-10 17:12:37.589741', '找冰淇淋');
INSERT INTO public.product VALUES (481, 9, '冰淇淋青茶', 0.00, '2026-02-10 17:12:37.589741', '找冰淇淋');
INSERT INTO public.product VALUES (482, 9, '冰淇淋烏龍茶', 0.00, '2026-02-10 17:12:37.589741', '找冰淇淋');
INSERT INTO public.product VALUES (483, 9, '四季春珍波椰', 0.00, '2026-02-10 17:12:37.589741', '店長推薦');
INSERT INTO public.product VALUES (484, 9, '珍珠奶綠', 0.00, '2026-02-10 17:12:37.589741', '店長推薦');
INSERT INTO public.product VALUES (485, 9, '四季奶青瑪奇朵', 0.00, '2026-02-10 17:12:37.589741', '店長推薦');
INSERT INTO public.product VALUES (486, 10, '職人美式(14oz)', 0.00, '2026-02-10 17:12:37.589741', '醇品咖啡香');
INSERT INTO public.product VALUES (487, 10, '職人拿鐵(14oz)', 0.00, '2026-02-10 17:12:37.589741', '醇品咖啡香');
INSERT INTO public.product VALUES (488, 10, '珍珠職人拿鐵(14oz)', 0.00, '2026-02-10 17:12:37.589741', '醇品咖啡香');
INSERT INTO public.product VALUES (489, 10, '粉角職人拿鐵(14oz)', 0.00, '2026-02-10 17:12:37.589741', '醇品咖啡香');
INSERT INTO public.product VALUES (490, 10, '珍珠黑糖拿鐵(14oz)', 0.00, '2026-02-10 17:12:37.589741', '醇品咖啡香');
INSERT INTO public.product VALUES (491, 10, '紅柚香檸美式', 0.00, '2026-02-10 17:12:37.589741', '醇品咖啡香');
INSERT INTO public.product VALUES (492, 10, '西西里手搗檸檬美式', 0.00, '2026-02-10 17:12:37.589741', '醇品咖啡香');
INSERT INTO public.product VALUES (493, 10, '生椰職人拿鐵(14oz)', 0.00, '2026-02-10 17:12:37.589741', '醇品咖啡香');
INSERT INTO public.product VALUES (494, 10, '粉角生椰拿鐵(14oz)', 0.00, '2026-02-10 17:12:37.589741', '醇品咖啡香');
INSERT INTO public.product VALUES (495, 10, '台灣柳丁美式', 0.00, '2026-02-10 17:12:37.589741', '醇品咖啡香');
INSERT INTO public.product VALUES (496, 10, '日安大麥', 0.00, '2026-02-10 17:12:37.589741', '熱門新品');
INSERT INTO public.product VALUES (497, 10, '手作仙草凍乳', 0.00, '2026-02-10 17:12:37.589741', '熱門新品');
INSERT INTO public.product VALUES (498, 10, '28茉輕乳茶', 0.00, '2026-02-10 17:12:37.589741', '熱門新品');
INSERT INTO public.product VALUES (499, 10, '28茉粉角輕乳茶', 0.00, '2026-02-10 17:12:37.589741', '熱門新品');
INSERT INTO public.product VALUES (500, 10, '手採紅茶', 0.00, '2026-02-10 17:12:37.589741', '經典純茶');
INSERT INTO public.product VALUES (501, 10, '茉莉綠茶', 0.00, '2026-02-10 17:12:37.589741', '經典純茶');
INSERT INTO public.product VALUES (502, 10, '四季春青茶', 0.00, '2026-02-10 17:12:37.589741', '經典純茶');
INSERT INTO public.product VALUES (503, 10, '日式焙茶', 0.00, '2026-02-10 17:12:37.589741', '經典純茶');
INSERT INTO public.product VALUES (504, 10, '２１歲輕烏龍', 0.00, '2026-02-10 17:12:37.589741', '經典純茶');
INSERT INTO public.product VALUES (505, 10, '蕎麥四季春', 0.00, '2026-02-10 17:12:37.589741', '經典純茶');
INSERT INTO public.product VALUES (506, 10, '仙草蜜', 0.00, '2026-02-10 17:12:37.589741', '經典純茶');
INSERT INTO public.product VALUES (507, 10, '四季珍椰青', 0.00, '2026-02-10 17:12:37.589741', '經典純茶');
INSERT INTO public.product VALUES (508, 10, '蜜香凍紅茶', 0.00, '2026-02-10 17:12:37.589741', '經典純茶');
INSERT INTO public.product VALUES (509, 10, '蜜香凍綠茶', 0.00, '2026-02-10 17:12:37.589741', '經典純茶');
INSERT INTO public.product VALUES (510, 10, '蜜香凍青茶', 0.00, '2026-02-10 17:12:37.589741', '經典純茶');
INSERT INTO public.product VALUES (511, 10, '粉角檸檬冬瓜', 0.00, '2026-02-10 17:12:37.589741', '激推果茶');
INSERT INTO public.product VALUES (512, 10, '檸檬奇遇桔', 0.00, '2026-02-10 17:12:37.589741', '激推果茶');
INSERT INTO public.product VALUES (513, 10, '芒裡偷閒奇亞籽', 0.00, '2026-02-10 17:12:37.589741', '激推果茶');
INSERT INTO public.product VALUES (514, 10, '２１歲輕檸烏龍', 0.00, '2026-02-10 17:12:37.589741', '激推果茶');
INSERT INTO public.product VALUES (515, 10, '百香雙響炮', 0.00, '2026-02-10 17:12:37.589741', '激推果茶');
INSERT INTO public.product VALUES (516, 10, '葡萄柚果粒茶', 0.00, '2026-02-10 17:12:37.589741', '激推果茶');
INSERT INTO public.product VALUES (517, 10, '百香綠茶', 0.00, '2026-02-10 17:12:37.589741', '激推果茶');
INSERT INTO public.product VALUES (518, 10, '芒果綠茶', 0.00, '2026-02-10 17:12:37.589741', '激推果茶');
INSERT INTO public.product VALUES (519, 10, '蜜香檸凍紅茶', 0.00, '2026-02-10 17:12:37.589741', '激推果茶');
INSERT INTO public.product VALUES (520, 10, '蜜香檸凍綠茶', 0.00, '2026-02-10 17:12:37.589741', '激推果茶');
INSERT INTO public.product VALUES (521, 10, '蜜香檸凍青茶', 0.00, '2026-02-10 17:12:37.589741', '激推果茶');
INSERT INTO public.product VALUES (522, 10, '蜜香檸凍冬瓜', 0.00, '2026-02-10 17:12:37.589741', '激推果茶');
INSERT INTO public.product VALUES (523, 10, '檸檬紅茶', 0.00, '2026-02-10 17:12:37.589741', '激推果茶');
INSERT INTO public.product VALUES (524, 10, '檸檬綠茶', 0.00, '2026-02-10 17:12:37.589741', '激推果茶');
INSERT INTO public.product VALUES (525, 10, '檸檬青茶', 0.00, '2026-02-10 17:12:37.589741', '激推果茶');
INSERT INTO public.product VALUES (526, 10, '檸檬冬瓜露', 0.00, '2026-02-10 17:12:37.589741', '激推果茶');
INSERT INTO public.product VALUES (527, 10, '蕎麥冬瓜露', 0.00, '2026-02-10 17:12:37.589741', '激推果茶');
INSERT INTO public.product VALUES (528, 10, '金桔檸檬', 0.00, '2026-02-10 17:12:37.589741', '激推果茶');
INSERT INTO public.product VALUES (529, 10, '檸檬霸', 0.00, '2026-02-10 17:12:37.589741', '激推果茶');
INSERT INTO public.product VALUES (530, 10, '綠茶養樂多', 0.00, '2026-02-10 17:12:37.589741', '激推果茶');
INSERT INTO public.product VALUES (531, 10, '莓好雙果茶', 0.00, '2026-02-10 17:12:37.589741', '莓果系列');
INSERT INTO public.product VALUES (532, 10, '莓好雙果牛乳', 0.00, '2026-02-10 17:12:37.589741', '莓果系列');
INSERT INTO public.product VALUES (533, 10, '茉香奶茶', 0.00, '2026-02-10 17:12:37.589741', '就愛喝奶茶');
INSERT INTO public.product VALUES (534, 10, '阿薩姆奶茶', 0.00, '2026-02-10 17:12:37.589741', '就愛喝奶茶');
INSERT INTO public.product VALUES (535, 10, '珍珠奶茶', 0.00, '2026-02-10 17:12:37.589741', '就愛喝奶茶');
INSERT INTO public.product VALUES (536, 10, '奶茶三兄弟', 0.00, '2026-02-10 17:12:37.589741', '就愛喝奶茶');
INSERT INTO public.product VALUES (537, 10, '布丁奶茶', 0.00, '2026-02-10 17:12:37.589741', '就愛喝奶茶');
INSERT INTO public.product VALUES (538, 10, '粉角奶茶', 0.00, '2026-02-10 17:12:37.589741', '就愛喝奶茶');
INSERT INTO public.product VALUES (539, 10, '冬韻擂焙珍奶', 0.00, '2026-02-10 17:12:37.589741', '就愛喝奶茶');
INSERT INTO public.product VALUES (540, 10, '日式焙奶茶', 0.00, '2026-02-10 17:12:37.589741', '就愛喝奶茶');
INSERT INTO public.product VALUES (541, 10, '日焙珍珠奶茶', 0.00, '2026-02-10 17:12:37.589741', '就愛喝奶茶');
INSERT INTO public.product VALUES (542, 10, '英式鮮奶茶', 0.00, '2026-02-10 17:12:37.589741', '濃純鮮奶');
INSERT INTO public.product VALUES (543, 10, '珍珠鮮奶茶', 0.00, '2026-02-10 17:12:37.589741', '濃純鮮奶');
INSERT INTO public.product VALUES (544, 10, '粉角鮮奶茶', 0.00, '2026-02-10 17:12:37.589741', '濃純鮮奶');
INSERT INTO public.product VALUES (545, 10, '芋頭牛奶', 0.00, '2026-02-10 17:12:37.589741', '濃純鮮奶');
INSERT INTO public.product VALUES (546, 10, '芋頭珍珠牛奶', 0.00, '2026-02-10 17:12:37.589741', '濃純鮮奶');
INSERT INTO public.product VALUES (547, 10, '日焙鮮奶茶', 0.00, '2026-02-10 17:12:37.589741', '濃純鮮奶');


--
-- Data for Name: product_composition; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.product_composition VALUES (1, 1, 1);
INSERT INTO public.product_composition VALUES (2, 2, 2);
INSERT INTO public.product_composition VALUES (3, 2, 3);
INSERT INTO public.product_composition VALUES (4, 2, 4);
INSERT INTO public.product_composition VALUES (5, 3, 5);
INSERT INTO public.product_composition VALUES (6, 3, 6);
INSERT INTO public.product_composition VALUES (7, 4, 7);
INSERT INTO public.product_composition VALUES (8, 4, 8);
INSERT INTO public.product_composition VALUES (9, 4, 9);
INSERT INTO public.product_composition VALUES (10, 4, 10);
INSERT INTO public.product_composition VALUES (11, 4, 11);
INSERT INTO public.product_composition VALUES (12, 5, 12);
INSERT INTO public.product_composition VALUES (13, 5, 13);
INSERT INTO public.product_composition VALUES (14, 5, 14);
INSERT INTO public.product_composition VALUES (15, 6, 15);
INSERT INTO public.product_composition VALUES (16, 6, 16);
INSERT INTO public.product_composition VALUES (17, 6, 17);
INSERT INTO public.product_composition VALUES (18, 7, 18);
INSERT INTO public.product_composition VALUES (19, 8, 19);
INSERT INTO public.product_composition VALUES (20, 8, 20);
INSERT INTO public.product_composition VALUES (21, 8, 12);
INSERT INTO public.product_composition VALUES (22, 9, 21);
INSERT INTO public.product_composition VALUES (23, 10, 22);
INSERT INTO public.product_composition VALUES (24, 11, 23);
INSERT INTO public.product_composition VALUES (25, 12, 24);
INSERT INTO public.product_composition VALUES (26, 13, 25);
INSERT INTO public.product_composition VALUES (27, 14, 26);
INSERT INTO public.product_composition VALUES (28, 15, 27);
INSERT INTO public.product_composition VALUES (29, 16, 1);
INSERT INTO public.product_composition VALUES (30, 17, 4);
INSERT INTO public.product_composition VALUES (31, 17, 21);
INSERT INTO public.product_composition VALUES (32, 18, 28);
INSERT INTO public.product_composition VALUES (33, 18, 4);
INSERT INTO public.product_composition VALUES (34, 19, 29);
INSERT INTO public.product_composition VALUES (35, 19, 30);
INSERT INTO public.product_composition VALUES (36, 20, 31);
INSERT INTO public.product_composition VALUES (37, 20, 32);
INSERT INTO public.product_composition VALUES (38, 20, 33);
INSERT INTO public.product_composition VALUES (39, 21, 34);
INSERT INTO public.product_composition VALUES (40, 21, 12);
INSERT INTO public.product_composition VALUES (41, 22, 26);
INSERT INTO public.product_composition VALUES (42, 22, 35);
INSERT INTO public.product_composition VALUES (43, 23, 36);
INSERT INTO public.product_composition VALUES (44, 23, 4);
INSERT INTO public.product_composition VALUES (45, 24, 37);
INSERT INTO public.product_composition VALUES (46, 24, 38);
INSERT INTO public.product_composition VALUES (47, 24, 39);
INSERT INTO public.product_composition VALUES (48, 24, 40);
INSERT INTO public.product_composition VALUES (49, 25, 41);
INSERT INTO public.product_composition VALUES (50, 25, 42);
INSERT INTO public.product_composition VALUES (51, 25, 16);
INSERT INTO public.product_composition VALUES (52, 25, 21);
INSERT INTO public.product_composition VALUES (53, 26, 43);
INSERT INTO public.product_composition VALUES (54, 26, 42);
INSERT INTO public.product_composition VALUES (55, 26, 44);
INSERT INTO public.product_composition VALUES (56, 27, 42);
INSERT INTO public.product_composition VALUES (57, 27, 32);
INSERT INTO public.product_composition VALUES (58, 28, 42);
INSERT INTO public.product_composition VALUES (59, 28, 45);
INSERT INTO public.product_composition VALUES (60, 29, 42);
INSERT INTO public.product_composition VALUES (61, 29, 46);
INSERT INTO public.product_composition VALUES (62, 30, 42);
INSERT INTO public.product_composition VALUES (63, 30, 47);
INSERT INTO public.product_composition VALUES (64, 31, 43);
INSERT INTO public.product_composition VALUES (65, 31, 42);
INSERT INTO public.product_composition VALUES (66, 31, 29);
INSERT INTO public.product_composition VALUES (67, 32, 42);
INSERT INTO public.product_composition VALUES (68, 32, 48);
INSERT INTO public.product_composition VALUES (69, 32, 21);
INSERT INTO public.product_composition VALUES (70, 33, 12);
INSERT INTO public.product_composition VALUES (71, 33, 49);
INSERT INTO public.product_composition VALUES (72, 33, 50);
INSERT INTO public.product_composition VALUES (73, 34, 11);
INSERT INTO public.product_composition VALUES (74, 34, 51);
INSERT INTO public.product_composition VALUES (75, 34, 52);
INSERT INTO public.product_composition VALUES (76, 35, 3);
INSERT INTO public.product_composition VALUES (77, 35, 53);
INSERT INTO public.product_composition VALUES (78, 35, 54);
INSERT INTO public.product_composition VALUES (79, 36, 21);
INSERT INTO public.product_composition VALUES (80, 36, 8);
INSERT INTO public.product_composition VALUES (81, 36, 12);
INSERT INTO public.product_composition VALUES (82, 36, 41);
INSERT INTO public.product_composition VALUES (83, 36, 40);
INSERT INTO public.product_composition VALUES (84, 36, 55);
INSERT INTO public.product_composition VALUES (85, 36, 56);
INSERT INTO public.product_composition VALUES (86, 37, 57);
INSERT INTO public.product_composition VALUES (87, 37, 8);
INSERT INTO public.product_composition VALUES (88, 37, 12);
INSERT INTO public.product_composition VALUES (89, 37, 56);
INSERT INTO public.product_composition VALUES (90, 37, 58);
INSERT INTO public.product_composition VALUES (91, 38, 19);
INSERT INTO public.product_composition VALUES (92, 38, 59);
INSERT INTO public.product_composition VALUES (93, 38, 60);
INSERT INTO public.product_composition VALUES (94, 39, 61);
INSERT INTO public.product_composition VALUES (95, 39, 12);
INSERT INTO public.product_composition VALUES (96, 39, 58);
INSERT INTO public.product_composition VALUES (97, 39, 54);
INSERT INTO public.product_composition VALUES (98, 40, 62);
INSERT INTO public.product_composition VALUES (99, 40, 63);
INSERT INTO public.product_composition VALUES (100, 41, 64);
INSERT INTO public.product_composition VALUES (101, 41, 65);
INSERT INTO public.product_composition VALUES (102, 41, 49);
INSERT INTO public.product_composition VALUES (103, 42, 65);
INSERT INTO public.product_composition VALUES (104, 42, 5);
INSERT INTO public.product_composition VALUES (105, 43, 65);
INSERT INTO public.product_composition VALUES (106, 43, 45);
INSERT INTO public.product_composition VALUES (107, 44, 65);
INSERT INTO public.product_composition VALUES (108, 44, 66);
INSERT INTO public.product_composition VALUES (109, 45, 65);
INSERT INTO public.product_composition VALUES (110, 45, 47);
INSERT INTO public.product_composition VALUES (111, 46, 65);
INSERT INTO public.product_composition VALUES (112, 46, 21);
INSERT INTO public.product_composition VALUES (113, 46, 6);
INSERT INTO public.product_composition VALUES (114, 47, 65);
INSERT INTO public.product_composition VALUES (115, 47, 48);
INSERT INTO public.product_composition VALUES (116, 48, 39);
INSERT INTO public.product_composition VALUES (117, 48, 67);
INSERT INTO public.product_composition VALUES (118, 49, 67);
INSERT INTO public.product_composition VALUES (119, 49, 18);
INSERT INTO public.product_composition VALUES (120, 49, 17);
INSERT INTO public.product_composition VALUES (121, 50, 67);
INSERT INTO public.product_composition VALUES (122, 50, 68);
INSERT INTO public.product_composition VALUES (123, 51, 69);
INSERT INTO public.product_composition VALUES (124, 52, 70);
INSERT INTO public.product_composition VALUES (125, 52, 71);
INSERT INTO public.product_composition VALUES (126, 53, 71);
INSERT INTO public.product_composition VALUES (127, 54, 72);
INSERT INTO public.product_composition VALUES (128, 55, 73);
INSERT INTO public.product_composition VALUES (129, 56, 74);
INSERT INTO public.product_composition VALUES (130, 57, 74);
INSERT INTO public.product_composition VALUES (131, 58, 75);
INSERT INTO public.product_composition VALUES (132, 59, 76);
INSERT INTO public.product_composition VALUES (133, 60, 77);
INSERT INTO public.product_composition VALUES (134, 61, 78);
INSERT INTO public.product_composition VALUES (135, 61, 79);
INSERT INTO public.product_composition VALUES (136, 62, 80);
INSERT INTO public.product_composition VALUES (137, 62, 79);
INSERT INTO public.product_composition VALUES (138, 63, 81);
INSERT INTO public.product_composition VALUES (139, 63, 79);
INSERT INTO public.product_composition VALUES (140, 64, 82);
INSERT INTO public.product_composition VALUES (141, 64, 79);
INSERT INTO public.product_composition VALUES (142, 65, 82);
INSERT INTO public.product_composition VALUES (143, 65, 83);
INSERT INTO public.product_composition VALUES (144, 65, 84);
INSERT INTO public.product_composition VALUES (145, 66, 69);
INSERT INTO public.product_composition VALUES (146, 66, 85);
INSERT INTO public.product_composition VALUES (147, 67, 69);
INSERT INTO public.product_composition VALUES (148, 67, 83);
INSERT INTO public.product_composition VALUES (149, 67, 84);
INSERT INTO public.product_composition VALUES (150, 67, 86);
INSERT INTO public.product_composition VALUES (151, 68, 69);
INSERT INTO public.product_composition VALUES (152, 68, 87);
INSERT INTO public.product_composition VALUES (153, 68, 88);
INSERT INTO public.product_composition VALUES (154, 69, 89);
INSERT INTO public.product_composition VALUES (155, 69, 72);
INSERT INTO public.product_composition VALUES (156, 69, 90);
INSERT INTO public.product_composition VALUES (157, 69, 91);
INSERT INTO public.product_composition VALUES (158, 69, 92);
INSERT INTO public.product_composition VALUES (159, 70, 89);
INSERT INTO public.product_composition VALUES (160, 70, 90);
INSERT INTO public.product_composition VALUES (161, 70, 73);
INSERT INTO public.product_composition VALUES (162, 70, 91);
INSERT INTO public.product_composition VALUES (163, 70, 92);
INSERT INTO public.product_composition VALUES (164, 71, 89);
INSERT INTO public.product_composition VALUES (165, 71, 93);
INSERT INTO public.product_composition VALUES (166, 71, 90);
INSERT INTO public.product_composition VALUES (167, 71, 91);
INSERT INTO public.product_composition VALUES (168, 71, 92);
INSERT INTO public.product_composition VALUES (169, 72, 89);
INSERT INTO public.product_composition VALUES (170, 72, 90);
INSERT INTO public.product_composition VALUES (171, 72, 94);
INSERT INTO public.product_composition VALUES (172, 72, 91);
INSERT INTO public.product_composition VALUES (173, 72, 92);
INSERT INTO public.product_composition VALUES (174, 73, 95);
INSERT INTO public.product_composition VALUES (175, 73, 92);
INSERT INTO public.product_composition VALUES (176, 74, 79);
INSERT INTO public.product_composition VALUES (177, 74, 96);
INSERT INTO public.product_composition VALUES (178, 74, 97);
INSERT INTO public.product_composition VALUES (179, 75, 98);
INSERT INTO public.product_composition VALUES (180, 75, 99);
INSERT INTO public.product_composition VALUES (181, 76, 100);
INSERT INTO public.product_composition VALUES (182, 76, 101);
INSERT INTO public.product_composition VALUES (183, 77, 102);
INSERT INTO public.product_composition VALUES (184, 77, 96);
INSERT INTO public.product_composition VALUES (185, 78, 74);
INSERT INTO public.product_composition VALUES (186, 78, 103);
INSERT INTO public.product_composition VALUES (187, 79, 74);
INSERT INTO public.product_composition VALUES (188, 79, 103);
INSERT INTO public.product_composition VALUES (189, 80, 100);
INSERT INTO public.product_composition VALUES (190, 80, 104);
INSERT INTO public.product_composition VALUES (191, 80, 99);
INSERT INTO public.product_composition VALUES (192, 81, 105);
INSERT INTO public.product_composition VALUES (193, 81, 106);
INSERT INTO public.product_composition VALUES (194, 81, 107);
INSERT INTO public.product_composition VALUES (195, 81, 79);
INSERT INTO public.product_composition VALUES (196, 82, 107);
INSERT INTO public.product_composition VALUES (197, 82, 74);
INSERT INTO public.product_composition VALUES (198, 82, 108);
INSERT INTO public.product_composition VALUES (199, 83, 107);
INSERT INTO public.product_composition VALUES (200, 83, 74);
INSERT INTO public.product_composition VALUES (201, 83, 108);
INSERT INTO public.product_composition VALUES (202, 84, 96);
INSERT INTO public.product_composition VALUES (203, 84, 99);
INSERT INTO public.product_composition VALUES (204, 85, 102);
INSERT INTO public.product_composition VALUES (205, 85, 96);
INSERT INTO public.product_composition VALUES (206, 86, 104);
INSERT INTO public.product_composition VALUES (207, 86, 109);
INSERT INTO public.product_composition VALUES (208, 86, 103);
INSERT INTO public.product_composition VALUES (209, 87, 96);
INSERT INTO public.product_composition VALUES (210, 87, 101);
INSERT INTO public.product_composition VALUES (211, 88, 110);
INSERT INTO public.product_composition VALUES (212, 88, 111);
INSERT INTO public.product_composition VALUES (213, 89, 112);
INSERT INTO public.product_composition VALUES (214, 89, 96);
INSERT INTO public.product_composition VALUES (215, 89, 113);
INSERT INTO public.product_composition VALUES (216, 90, 96);
INSERT INTO public.product_composition VALUES (217, 90, 114);
INSERT INTO public.product_composition VALUES (218, 90, 115);
INSERT INTO public.product_composition VALUES (219, 91, 82);
INSERT INTO public.product_composition VALUES (220, 91, 116);
INSERT INTO public.product_composition VALUES (221, 92, 96);
INSERT INTO public.product_composition VALUES (222, 92, 82);
INSERT INTO public.product_composition VALUES (223, 92, 74);
INSERT INTO public.product_composition VALUES (224, 93, 117);
INSERT INTO public.product_composition VALUES (225, 94, 118);
INSERT INTO public.product_composition VALUES (226, 94, 117);
INSERT INTO public.product_composition VALUES (227, 95, 119);
INSERT INTO public.product_composition VALUES (228, 95, 117);
INSERT INTO public.product_composition VALUES (229, 96, 120);
INSERT INTO public.product_composition VALUES (230, 96, 117);
INSERT INTO public.product_composition VALUES (231, 97, 117);
INSERT INTO public.product_composition VALUES (232, 97, 121);
INSERT INTO public.product_composition VALUES (233, 98, 122);
INSERT INTO public.product_composition VALUES (234, 99, 123);
INSERT INTO public.product_composition VALUES (235, 100, 124);
INSERT INTO public.product_composition VALUES (236, 101, 124);
INSERT INTO public.product_composition VALUES (237, 102, 124);
INSERT INTO public.product_composition VALUES (238, 103, 125);
INSERT INTO public.product_composition VALUES (239, 103, 124);
INSERT INTO public.product_composition VALUES (240, 104, 126);
INSERT INTO public.product_composition VALUES (241, 104, 125);
INSERT INTO public.product_composition VALUES (242, 105, 127);
INSERT INTO public.product_composition VALUES (243, 105, 125);
INSERT INTO public.product_composition VALUES (244, 105, 124);
INSERT INTO public.product_composition VALUES (245, 106, 127);
INSERT INTO public.product_composition VALUES (246, 106, 125);
INSERT INTO public.product_composition VALUES (247, 106, 123);
INSERT INTO public.product_composition VALUES (248, 107, 125);
INSERT INTO public.product_composition VALUES (249, 107, 128);
INSERT INTO public.product_composition VALUES (250, 108, 120);
INSERT INTO public.product_composition VALUES (251, 108, 122);
INSERT INTO public.product_composition VALUES (252, 109, 120);
INSERT INTO public.product_composition VALUES (253, 109, 124);
INSERT INTO public.product_composition VALUES (254, 110, 120);
INSERT INTO public.product_composition VALUES (255, 110, 126);
INSERT INTO public.product_composition VALUES (256, 111, 120);
INSERT INTO public.product_composition VALUES (257, 111, 128);
INSERT INTO public.product_composition VALUES (258, 112, 129);
INSERT INTO public.product_composition VALUES (259, 112, 130);
INSERT INTO public.product_composition VALUES (260, 112, 131);
INSERT INTO public.product_composition VALUES (261, 113, 132);
INSERT INTO public.product_composition VALUES (262, 113, 133);
INSERT INTO public.product_composition VALUES (263, 113, 131);
INSERT INTO public.product_composition VALUES (264, 114, 134);
INSERT INTO public.product_composition VALUES (265, 114, 131);
INSERT INTO public.product_composition VALUES (266, 115, 135);
INSERT INTO public.product_composition VALUES (267, 115, 136);
INSERT INTO public.product_composition VALUES (268, 115, 131);
INSERT INTO public.product_composition VALUES (269, 116, 137);
INSERT INTO public.product_composition VALUES (270, 116, 131);
INSERT INTO public.product_composition VALUES (271, 116, 138);
INSERT INTO public.product_composition VALUES (272, 117, 139);
INSERT INTO public.product_composition VALUES (273, 117, 124);
INSERT INTO public.product_composition VALUES (274, 117, 138);
INSERT INTO public.product_composition VALUES (275, 117, 140);
INSERT INTO public.product_composition VALUES (276, 118, 121);
INSERT INTO public.product_composition VALUES (277, 118, 141);
INSERT INTO public.product_composition VALUES (278, 119, 142);
INSERT INTO public.product_composition VALUES (279, 119, 121);
INSERT INTO public.product_composition VALUES (280, 120, 143);
INSERT INTO public.product_composition VALUES (281, 120, 121);
INSERT INTO public.product_composition VALUES (282, 121, 128);
INSERT INTO public.product_composition VALUES (283, 121, 121);
INSERT INTO public.product_composition VALUES (284, 122, 144);
INSERT INTO public.product_composition VALUES (285, 122, 145);
INSERT INTO public.product_composition VALUES (286, 122, 146);
INSERT INTO public.product_composition VALUES (287, 122, 147);
INSERT INTO public.product_composition VALUES (288, 123, 144);
INSERT INTO public.product_composition VALUES (289, 123, 148);
INSERT INTO public.product_composition VALUES (290, 123, 147);
INSERT INTO public.product_composition VALUES (291, 124, 144);
INSERT INTO public.product_composition VALUES (292, 124, 149);
INSERT INTO public.product_composition VALUES (293, 124, 147);
INSERT INTO public.product_composition VALUES (294, 125, 144);
INSERT INTO public.product_composition VALUES (295, 125, 150);
INSERT INTO public.product_composition VALUES (296, 125, 147);
INSERT INTO public.product_composition VALUES (297, 126, 144);
INSERT INTO public.product_composition VALUES (298, 126, 151);
INSERT INTO public.product_composition VALUES (299, 126, 148);
INSERT INTO public.product_composition VALUES (300, 127, 151);
INSERT INTO public.product_composition VALUES (301, 127, 149);
INSERT INTO public.product_composition VALUES (302, 127, 144);
INSERT INTO public.product_composition VALUES (303, 128, 144);
INSERT INTO public.product_composition VALUES (304, 128, 149);
INSERT INTO public.product_composition VALUES (305, 128, 152);
INSERT INTO public.product_composition VALUES (306, 128, 145);
INSERT INTO public.product_composition VALUES (307, 129, 144);
INSERT INTO public.product_composition VALUES (308, 129, 152);
INSERT INTO public.product_composition VALUES (309, 129, 153);
INSERT INTO public.product_composition VALUES (310, 130, 144);
INSERT INTO public.product_composition VALUES (311, 130, 149);
INSERT INTO public.product_composition VALUES (312, 130, 152);
INSERT INTO public.product_composition VALUES (313, 131, 151);
INSERT INTO public.product_composition VALUES (314, 131, 146);
INSERT INTO public.product_composition VALUES (315, 131, 154);
INSERT INTO public.product_composition VALUES (316, 132, 149);
INSERT INTO public.product_composition VALUES (317, 132, 155);
INSERT INTO public.product_composition VALUES (318, 132, 156);
INSERT INTO public.product_composition VALUES (319, 132, 157);
INSERT INTO public.product_composition VALUES (320, 133, 158);
INSERT INTO public.product_composition VALUES (321, 134, 159);
INSERT INTO public.product_composition VALUES (322, 134, 160);
INSERT INTO public.product_composition VALUES (323, 135, 149);
INSERT INTO public.product_composition VALUES (324, 135, 145);
INSERT INTO public.product_composition VALUES (325, 136, 148);
INSERT INTO public.product_composition VALUES (326, 136, 161);
INSERT INTO public.product_composition VALUES (327, 137, 149);
INSERT INTO public.product_composition VALUES (328, 138, 149);
INSERT INTO public.product_composition VALUES (329, 138, 162);
INSERT INTO public.product_composition VALUES (330, 139, 149);
INSERT INTO public.product_composition VALUES (331, 139, 154);
INSERT INTO public.product_composition VALUES (332, 140, 163);
INSERT INTO public.product_composition VALUES (333, 140, 164);
INSERT INTO public.product_composition VALUES (334, 140, 165);
INSERT INTO public.product_composition VALUES (335, 141, 166);
INSERT INTO public.product_composition VALUES (336, 141, 167);
INSERT INTO public.product_composition VALUES (337, 141, 168);
INSERT INTO public.product_composition VALUES (338, 142, 169);
INSERT INTO public.product_composition VALUES (339, 142, 170);
INSERT INTO public.product_composition VALUES (340, 143, 169);
INSERT INTO public.product_composition VALUES (341, 143, 151);
INSERT INTO public.product_composition VALUES (342, 144, 149);
INSERT INTO public.product_composition VALUES (343, 144, 156);
INSERT INTO public.product_composition VALUES (344, 144, 157);
INSERT INTO public.product_composition VALUES (345, 144, 145);
INSERT INTO public.product_composition VALUES (346, 145, 154);
INSERT INTO public.product_composition VALUES (347, 145, 157);
INSERT INTO public.product_composition VALUES (348, 145, 156);
INSERT INTO public.product_composition VALUES (349, 145, 155);
INSERT INTO public.product_composition VALUES (350, 145, 149);
INSERT INTO public.product_composition VALUES (351, 146, 149);
INSERT INTO public.product_composition VALUES (352, 146, 155);
INSERT INTO public.product_composition VALUES (353, 146, 156);
INSERT INTO public.product_composition VALUES (354, 146, 157);
INSERT INTO public.product_composition VALUES (355, 147, 151);
INSERT INTO public.product_composition VALUES (356, 147, 167);
INSERT INTO public.product_composition VALUES (357, 147, 166);
INSERT INTO public.product_composition VALUES (358, 147, 168);
INSERT INTO public.product_composition VALUES (359, 148, 151);
INSERT INTO public.product_composition VALUES (360, 148, 149);
INSERT INTO public.product_composition VALUES (361, 149, 151);
INSERT INTO public.product_composition VALUES (362, 149, 149);
INSERT INTO public.product_composition VALUES (363, 149, 145);
INSERT INTO public.product_composition VALUES (364, 150, 151);
INSERT INTO public.product_composition VALUES (365, 150, 149);
INSERT INTO public.product_composition VALUES (366, 150, 162);
INSERT INTO public.product_composition VALUES (367, 151, 151);
INSERT INTO public.product_composition VALUES (368, 151, 149);
INSERT INTO public.product_composition VALUES (369, 151, 171);
INSERT INTO public.product_composition VALUES (370, 151, 162);
INSERT INTO public.product_composition VALUES (371, 152, 169);
INSERT INTO public.product_composition VALUES (372, 152, 151);
INSERT INTO public.product_composition VALUES (373, 153, 151);
INSERT INTO public.product_composition VALUES (374, 153, 172);
INSERT INTO public.product_composition VALUES (375, 154, 151);
INSERT INTO public.product_composition VALUES (376, 154, 149);
INSERT INTO public.product_composition VALUES (377, 154, 145);
INSERT INTO public.product_composition VALUES (378, 155, 166);
INSERT INTO public.product_composition VALUES (379, 155, 167);
INSERT INTO public.product_composition VALUES (380, 155, 168);
INSERT INTO public.product_composition VALUES (381, 155, 173);
INSERT INTO public.product_composition VALUES (382, 156, 158);
INSERT INTO public.product_composition VALUES (383, 156, 173);
INSERT INTO public.product_composition VALUES (384, 157, 154);
INSERT INTO public.product_composition VALUES (385, 158, 163);
INSERT INTO public.product_composition VALUES (386, 158, 172);
INSERT INTO public.product_composition VALUES (387, 159, 149);
INSERT INTO public.product_composition VALUES (388, 159, 152);
INSERT INTO public.product_composition VALUES (389, 160, 166);
INSERT INTO public.product_composition VALUES (390, 160, 152);
INSERT INTO public.product_composition VALUES (391, 160, 168);
INSERT INTO public.product_composition VALUES (392, 160, 167);
INSERT INTO public.product_composition VALUES (393, 161, 149);
INSERT INTO public.product_composition VALUES (394, 161, 152);
INSERT INTO public.product_composition VALUES (395, 161, 145);
INSERT INTO public.product_composition VALUES (396, 162, 149);
INSERT INTO public.product_composition VALUES (397, 162, 152);
INSERT INTO public.product_composition VALUES (398, 162, 162);
INSERT INTO public.product_composition VALUES (399, 163, 149);
INSERT INTO public.product_composition VALUES (400, 163, 152);
INSERT INTO public.product_composition VALUES (401, 163, 154);
INSERT INTO public.product_composition VALUES (402, 164, 149);
INSERT INTO public.product_composition VALUES (403, 164, 152);
INSERT INTO public.product_composition VALUES (404, 164, 171);
INSERT INTO public.product_composition VALUES (405, 164, 162);
INSERT INTO public.product_composition VALUES (406, 165, 174);
INSERT INTO public.product_composition VALUES (407, 165, 149);
INSERT INTO public.product_composition VALUES (408, 165, 152);
INSERT INTO public.product_composition VALUES (409, 166, 169);
INSERT INTO public.product_composition VALUES (410, 166, 152);
INSERT INTO public.product_composition VALUES (411, 167, 175);
INSERT INTO public.product_composition VALUES (412, 167, 176);
INSERT INTO public.product_composition VALUES (413, 168, 177);
INSERT INTO public.product_composition VALUES (414, 168, 176);
INSERT INTO public.product_composition VALUES (415, 169, 175);
INSERT INTO public.product_composition VALUES (416, 169, 176);
INSERT INTO public.product_composition VALUES (417, 169, 178);
INSERT INTO public.product_composition VALUES (418, 170, 179);
INSERT INTO public.product_composition VALUES (419, 170, 180);
INSERT INTO public.product_composition VALUES (420, 171, 177);
INSERT INTO public.product_composition VALUES (421, 171, 179);
INSERT INTO public.product_composition VALUES (422, 171, 180);
INSERT INTO public.product_composition VALUES (423, 172, 181);
INSERT INTO public.product_composition VALUES (424, 172, 182);
INSERT INTO public.product_composition VALUES (425, 173, 183);
INSERT INTO public.product_composition VALUES (426, 173, 181);
INSERT INTO public.product_composition VALUES (427, 173, 182);
INSERT INTO public.product_composition VALUES (428, 174, 184);
INSERT INTO public.product_composition VALUES (429, 174, 185);
INSERT INTO public.product_composition VALUES (430, 175, 184);
INSERT INTO public.product_composition VALUES (431, 176, 186);
INSERT INTO public.product_composition VALUES (432, 177, 187);
INSERT INTO public.product_composition VALUES (433, 178, 188);
INSERT INTO public.product_composition VALUES (434, 179, 187);
INSERT INTO public.product_composition VALUES (435, 179, 185);
INSERT INTO public.product_composition VALUES (436, 180, 184);
INSERT INTO public.product_composition VALUES (437, 180, 186);
INSERT INTO public.product_composition VALUES (438, 181, 189);
INSERT INTO public.product_composition VALUES (439, 182, 189);
INSERT INTO public.product_composition VALUES (440, 182, 190);
INSERT INTO public.product_composition VALUES (441, 182, 191);
INSERT INTO public.product_composition VALUES (442, 183, 189);
INSERT INTO public.product_composition VALUES (443, 183, 187);
INSERT INTO public.product_composition VALUES (444, 184, 184);
INSERT INTO public.product_composition VALUES (445, 184, 192);
INSERT INTO public.product_composition VALUES (446, 185, 193);
INSERT INTO public.product_composition VALUES (447, 185, 184);
INSERT INTO public.product_composition VALUES (448, 185, 194);
INSERT INTO public.product_composition VALUES (449, 185, 192);
INSERT INTO public.product_composition VALUES (450, 186, 195);
INSERT INTO public.product_composition VALUES (451, 186, 196);
INSERT INTO public.product_composition VALUES (452, 186, 197);
INSERT INTO public.product_composition VALUES (453, 186, 198);
INSERT INTO public.product_composition VALUES (454, 187, 199);
INSERT INTO public.product_composition VALUES (455, 187, 184);
INSERT INTO public.product_composition VALUES (456, 187, 200);
INSERT INTO public.product_composition VALUES (457, 188, 185);
INSERT INTO public.product_composition VALUES (458, 188, 201);
INSERT INTO public.product_composition VALUES (459, 189, 175);
INSERT INTO public.product_composition VALUES (460, 189, 178);
INSERT INTO public.product_composition VALUES (461, 190, 177);
INSERT INTO public.product_composition VALUES (462, 190, 178);
INSERT INTO public.product_composition VALUES (463, 191, 201);
INSERT INTO public.product_composition VALUES (464, 192, 175);
INSERT INTO public.product_composition VALUES (465, 192, 202);
INSERT INTO public.product_composition VALUES (466, 192, 195);
INSERT INTO public.product_composition VALUES (467, 193, 184);
INSERT INTO public.product_composition VALUES (468, 193, 201);
INSERT INTO public.product_composition VALUES (469, 194, 195);
INSERT INTO public.product_composition VALUES (470, 194, 203);
INSERT INTO public.product_composition VALUES (471, 195, 195);
INSERT INTO public.product_composition VALUES (472, 195, 203);
INSERT INTO public.product_composition VALUES (473, 195, 204);
INSERT INTO public.product_composition VALUES (474, 196, 205);
INSERT INTO public.product_composition VALUES (475, 196, 206);
INSERT INTO public.product_composition VALUES (476, 197, 207);
INSERT INTO public.product_composition VALUES (477, 197, 208);
INSERT INTO public.product_composition VALUES (478, 197, 184);
INSERT INTO public.product_composition VALUES (479, 198, 209);
INSERT INTO public.product_composition VALUES (480, 198, 205);
INSERT INTO public.product_composition VALUES (481, 198, 206);
INSERT INTO public.product_composition VALUES (482, 199, 209);
INSERT INTO public.product_composition VALUES (483, 199, 187);
INSERT INTO public.product_composition VALUES (484, 200, 195);
INSERT INTO public.product_composition VALUES (485, 200, 210);
INSERT INTO public.product_composition VALUES (486, 200, 211);
INSERT INTO public.product_composition VALUES (487, 201, 193);
INSERT INTO public.product_composition VALUES (488, 201, 177);
INSERT INTO public.product_composition VALUES (489, 201, 181);
INSERT INTO public.product_composition VALUES (490, 202, 177);
INSERT INTO public.product_composition VALUES (491, 202, 201);
INSERT INTO public.product_composition VALUES (492, 202, 195);
INSERT INTO public.product_composition VALUES (493, 203, 193);
INSERT INTO public.product_composition VALUES (494, 203, 177);
INSERT INTO public.product_composition VALUES (495, 203, 195);
INSERT INTO public.product_composition VALUES (496, 204, 193);
INSERT INTO public.product_composition VALUES (497, 204, 177);
INSERT INTO public.product_composition VALUES (498, 204, 201);
INSERT INTO public.product_composition VALUES (499, 204, 188);
INSERT INTO public.product_composition VALUES (500, 205, 177);
INSERT INTO public.product_composition VALUES (501, 205, 178);
INSERT INTO public.product_composition VALUES (502, 206, 177);
INSERT INTO public.product_composition VALUES (503, 206, 189);
INSERT INTO public.product_composition VALUES (504, 207, 177);
INSERT INTO public.product_composition VALUES (505, 207, 202);
INSERT INTO public.product_composition VALUES (506, 208, 193);
INSERT INTO public.product_composition VALUES (507, 208, 177);
INSERT INTO public.product_composition VALUES (508, 208, 212);
INSERT INTO public.product_composition VALUES (509, 208, 195);
INSERT INTO public.product_composition VALUES (510, 209, 213);
INSERT INTO public.product_composition VALUES (511, 209, 214);
INSERT INTO public.product_composition VALUES (512, 209, 184);
INSERT INTO public.product_composition VALUES (513, 209, 177);
INSERT INTO public.product_composition VALUES (514, 210, 214);
INSERT INTO public.product_composition VALUES (515, 210, 184);
INSERT INTO public.product_composition VALUES (516, 210, 215);
INSERT INTO public.product_composition VALUES (517, 211, 216);
INSERT INTO public.product_composition VALUES (518, 211, 214);
INSERT INTO public.product_composition VALUES (519, 211, 215);
INSERT INTO public.product_composition VALUES (520, 211, 195);
INSERT INTO public.product_composition VALUES (521, 211, 217);
INSERT INTO public.product_composition VALUES (522, 212, 175);
INSERT INTO public.product_composition VALUES (523, 212, 181);
INSERT INTO public.product_composition VALUES (524, 212, 195);
INSERT INTO public.product_composition VALUES (525, 213, 193);
INSERT INTO public.product_composition VALUES (526, 213, 195);
INSERT INTO public.product_composition VALUES (527, 213, 175);
INSERT INTO public.product_composition VALUES (528, 214, 195);
INSERT INTO public.product_composition VALUES (529, 214, 175);
INSERT INTO public.product_composition VALUES (530, 215, 175);
INSERT INTO public.product_composition VALUES (531, 215, 218);
INSERT INTO public.product_composition VALUES (532, 216, 175);
INSERT INTO public.product_composition VALUES (533, 216, 184);
INSERT INTO public.product_composition VALUES (534, 217, 213);
INSERT INTO public.product_composition VALUES (535, 217, 175);
INSERT INTO public.product_composition VALUES (536, 217, 195);
INSERT INTO public.product_composition VALUES (537, 218, 175);
INSERT INTO public.product_composition VALUES (538, 218, 195);
INSERT INTO public.product_composition VALUES (539, 218, 194);
INSERT INTO public.product_composition VALUES (540, 219, 175);
INSERT INTO public.product_composition VALUES (541, 219, 195);
INSERT INTO public.product_composition VALUES (542, 219, 219);
INSERT INTO public.product_composition VALUES (543, 220, 175);
INSERT INTO public.product_composition VALUES (544, 220, 220);
INSERT INTO public.product_composition VALUES (545, 220, 195);
INSERT INTO public.product_composition VALUES (546, 221, 175);
INSERT INTO public.product_composition VALUES (547, 221, 201);
INSERT INTO public.product_composition VALUES (548, 221, 195);
INSERT INTO public.product_composition VALUES (549, 222, 175);
INSERT INTO public.product_composition VALUES (550, 222, 212);
INSERT INTO public.product_composition VALUES (551, 222, 195);
INSERT INTO public.product_composition VALUES (552, 223, 175);
INSERT INTO public.product_composition VALUES (553, 223, 187);
INSERT INTO public.product_composition VALUES (554, 224, 175);
INSERT INTO public.product_composition VALUES (555, 224, 218);
INSERT INTO public.product_composition VALUES (556, 225, 177);
INSERT INTO public.product_composition VALUES (557, 225, 201);
INSERT INTO public.product_composition VALUES (558, 225, 188);
INSERT INTO public.product_composition VALUES (559, 226, 175);
INSERT INTO public.product_composition VALUES (560, 226, 195);
INSERT INTO public.product_composition VALUES (561, 227, 175);
INSERT INTO public.product_composition VALUES (562, 227, 184);
INSERT INTO public.product_composition VALUES (563, 227, 214);
INSERT INTO public.product_composition VALUES (564, 228, 221);
INSERT INTO public.product_composition VALUES (565, 228, 184);
INSERT INTO public.product_composition VALUES (566, 229, 221);
INSERT INTO public.product_composition VALUES (567, 229, 184);
INSERT INTO public.product_composition VALUES (568, 229, 192);
INSERT INTO public.product_composition VALUES (569, 230, 221);
INSERT INTO public.product_composition VALUES (570, 230, 184);
INSERT INTO public.product_composition VALUES (571, 230, 222);
INSERT INTO public.product_composition VALUES (572, 230, 223);
INSERT INTO public.product_composition VALUES (573, 231, 221);
INSERT INTO public.product_composition VALUES (574, 231, 195);
INSERT INTO public.product_composition VALUES (575, 231, 224);
INSERT INTO public.product_composition VALUES (576, 232, 225);
INSERT INTO public.product_composition VALUES (577, 233, 195);
INSERT INTO public.product_composition VALUES (578, 233, 225);
INSERT INTO public.product_composition VALUES (579, 234, 225);
INSERT INTO public.product_composition VALUES (580, 234, 201);
INSERT INTO public.product_composition VALUES (581, 235, 226);
INSERT INTO public.product_composition VALUES (582, 236, 226);
INSERT INTO public.product_composition VALUES (583, 236, 201);
INSERT INTO public.product_composition VALUES (584, 237, 225);
INSERT INTO public.product_composition VALUES (585, 237, 227);
INSERT INTO public.product_composition VALUES (586, 238, 186);
INSERT INTO public.product_composition VALUES (587, 238, 228);
INSERT INTO public.product_composition VALUES (588, 239, 226);
INSERT INTO public.product_composition VALUES (589, 239, 201);
INSERT INTO public.product_composition VALUES (590, 239, 228);
INSERT INTO public.product_composition VALUES (591, 240, 221);
INSERT INTO public.product_composition VALUES (592, 240, 229);
INSERT INTO public.product_composition VALUES (593, 241, 225);
INSERT INTO public.product_composition VALUES (594, 241, 229);
INSERT INTO public.product_composition VALUES (595, 242, 230);
INSERT INTO public.product_composition VALUES (596, 242, 231);
INSERT INTO public.product_composition VALUES (597, 243, 232);
INSERT INTO public.product_composition VALUES (598, 243, 233);
INSERT INTO public.product_composition VALUES (599, 243, 231);
INSERT INTO public.product_composition VALUES (600, 244, 234);
INSERT INTO public.product_composition VALUES (601, 244, 233);
INSERT INTO public.product_composition VALUES (602, 244, 235);
INSERT INTO public.product_composition VALUES (603, 244, 236);
INSERT INTO public.product_composition VALUES (604, 245, 233);
INSERT INTO public.product_composition VALUES (605, 245, 237);
INSERT INTO public.product_composition VALUES (606, 246, 232);
INSERT INTO public.product_composition VALUES (607, 246, 233);
INSERT INTO public.product_composition VALUES (608, 247, 235);
INSERT INTO public.product_composition VALUES (609, 248, 238);
INSERT INTO public.product_composition VALUES (610, 248, 239);
INSERT INTO public.product_composition VALUES (611, 249, 240);
INSERT INTO public.product_composition VALUES (612, 249, 235);
INSERT INTO public.product_composition VALUES (613, 250, 240);
INSERT INTO public.product_composition VALUES (614, 250, 235);
INSERT INTO public.product_composition VALUES (615, 250, 241);
INSERT INTO public.product_composition VALUES (616, 251, 235);
INSERT INTO public.product_composition VALUES (617, 251, 242);
INSERT INTO public.product_composition VALUES (618, 251, 243);
INSERT INTO public.product_composition VALUES (619, 252, 235);
INSERT INTO public.product_composition VALUES (620, 252, 244);
INSERT INTO public.product_composition VALUES (621, 253, 245);
INSERT INTO public.product_composition VALUES (622, 253, 246);
INSERT INTO public.product_composition VALUES (623, 253, 235);
INSERT INTO public.product_composition VALUES (624, 254, 235);
INSERT INTO public.product_composition VALUES (625, 254, 247);
INSERT INTO public.product_composition VALUES (626, 254, 248);
INSERT INTO public.product_composition VALUES (627, 255, 249);
INSERT INTO public.product_composition VALUES (628, 255, 247);
INSERT INTO public.product_composition VALUES (629, 255, 248);
INSERT INTO public.product_composition VALUES (630, 256, 245);
INSERT INTO public.product_composition VALUES (631, 256, 250);
INSERT INTO public.product_composition VALUES (632, 256, 251);
INSERT INTO public.product_composition VALUES (633, 257, 232);
INSERT INTO public.product_composition VALUES (634, 257, 233);
INSERT INTO public.product_composition VALUES (635, 258, 233);
INSERT INTO public.product_composition VALUES (636, 258, 235);
INSERT INTO public.product_composition VALUES (637, 259, 252);
INSERT INTO public.product_composition VALUES (638, 259, 233);
INSERT INTO public.product_composition VALUES (639, 259, 232);
INSERT INTO public.product_composition VALUES (640, 260, 233);
INSERT INTO public.product_composition VALUES (641, 260, 236);
INSERT INTO public.product_composition VALUES (642, 261, 233);
INSERT INTO public.product_composition VALUES (643, 261, 253);
INSERT INTO public.product_composition VALUES (644, 262, 233);
INSERT INTO public.product_composition VALUES (645, 262, 254);
INSERT INTO public.product_composition VALUES (646, 263, 252);
INSERT INTO public.product_composition VALUES (647, 263, 233);
INSERT INTO public.product_composition VALUES (648, 264, 234);
INSERT INTO public.product_composition VALUES (649, 264, 233);
INSERT INTO public.product_composition VALUES (650, 265, 233);
INSERT INTO public.product_composition VALUES (651, 266, 233);
INSERT INTO public.product_composition VALUES (652, 266, 255);
INSERT INTO public.product_composition VALUES (653, 267, 233);
INSERT INTO public.product_composition VALUES (654, 267, 230);
INSERT INTO public.product_composition VALUES (655, 268, 230);
INSERT INTO public.product_composition VALUES (656, 269, 256);
INSERT INTO public.product_composition VALUES (657, 270, 257);
INSERT INTO public.product_composition VALUES (658, 270, 258);
INSERT INTO public.product_composition VALUES (659, 271, 233);
INSERT INTO public.product_composition VALUES (660, 271, 259);
INSERT INTO public.product_composition VALUES (661, 272, 256);
INSERT INTO public.product_composition VALUES (662, 272, 245);
INSERT INTO public.product_composition VALUES (663, 272, 260);
INSERT INTO public.product_composition VALUES (664, 273, 256);
INSERT INTO public.product_composition VALUES (665, 273, 259);
INSERT INTO public.product_composition VALUES (666, 274, 261);
INSERT INTO public.product_composition VALUES (667, 275, 262);
INSERT INTO public.product_composition VALUES (668, 275, 263);
INSERT INTO public.product_composition VALUES (669, 276, 264);
INSERT INTO public.product_composition VALUES (670, 276, 265);
INSERT INTO public.product_composition VALUES (671, 277, 266);
INSERT INTO public.product_composition VALUES (672, 277, 267);
INSERT INTO public.product_composition VALUES (673, 277, 264);
INSERT INTO public.product_composition VALUES (674, 277, 268);
INSERT INTO public.product_composition VALUES (675, 278, 261);
INSERT INTO public.product_composition VALUES (676, 279, 269);
INSERT INTO public.product_composition VALUES (677, 279, 270);
INSERT INTO public.product_composition VALUES (678, 280, 271);
INSERT INTO public.product_composition VALUES (679, 281, 272);
INSERT INTO public.product_composition VALUES (680, 281, 273);
INSERT INTO public.product_composition VALUES (681, 282, 270);
INSERT INTO public.product_composition VALUES (682, 283, 274);
INSERT INTO public.product_composition VALUES (683, 284, 275);
INSERT INTO public.product_composition VALUES (684, 285, 276);
INSERT INTO public.product_composition VALUES (685, 285, 277);
INSERT INTO public.product_composition VALUES (686, 286, 270);
INSERT INTO public.product_composition VALUES (687, 287, 270);
INSERT INTO public.product_composition VALUES (688, 288, 272);
INSERT INTO public.product_composition VALUES (689, 288, 278);
INSERT INTO public.product_composition VALUES (690, 288, 270);
INSERT INTO public.product_composition VALUES (691, 289, 270);
INSERT INTO public.product_composition VALUES (692, 289, 279);
INSERT INTO public.product_composition VALUES (693, 290, 280);
INSERT INTO public.product_composition VALUES (694, 290, 281);
INSERT INTO public.product_composition VALUES (695, 291, 282);
INSERT INTO public.product_composition VALUES (696, 291, 283);
INSERT INTO public.product_composition VALUES (697, 291, 284);
INSERT INTO public.product_composition VALUES (698, 292, 285);
INSERT INTO public.product_composition VALUES (699, 292, 286);
INSERT INTO public.product_composition VALUES (700, 292, 287);
INSERT INTO public.product_composition VALUES (701, 293, 264);
INSERT INTO public.product_composition VALUES (702, 293, 270);
INSERT INTO public.product_composition VALUES (703, 293, 288);
INSERT INTO public.product_composition VALUES (704, 293, 289);
INSERT INTO public.product_composition VALUES (705, 294, 286);
INSERT INTO public.product_composition VALUES (706, 294, 290);
INSERT INTO public.product_composition VALUES (707, 295, 286);
INSERT INTO public.product_composition VALUES (708, 295, 277);
INSERT INTO public.product_composition VALUES (709, 295, 291);
INSERT INTO public.product_composition VALUES (710, 296, 292);
INSERT INTO public.product_composition VALUES (711, 296, 270);
INSERT INTO public.product_composition VALUES (712, 297, 293);
INSERT INTO public.product_composition VALUES (713, 297, 292);
INSERT INTO public.product_composition VALUES (714, 298, 292);
INSERT INTO public.product_composition VALUES (715, 298, 294);
INSERT INTO public.product_composition VALUES (716, 299, 295);
INSERT INTO public.product_composition VALUES (717, 299, 296);
INSERT INTO public.product_composition VALUES (718, 299, 297);
INSERT INTO public.product_composition VALUES (719, 300, 298);
INSERT INTO public.product_composition VALUES (720, 300, 281);
INSERT INTO public.product_composition VALUES (721, 301, 261);
INSERT INTO public.product_composition VALUES (722, 301, 298);
INSERT INTO public.product_composition VALUES (723, 302, 299);
INSERT INTO public.product_composition VALUES (724, 302, 296);
INSERT INTO public.product_composition VALUES (725, 303, 298);
INSERT INTO public.product_composition VALUES (726, 303, 270);
INSERT INTO public.product_composition VALUES (727, 304, 298);
INSERT INTO public.product_composition VALUES (728, 304, 270);
INSERT INTO public.product_composition VALUES (729, 305, 298);
INSERT INTO public.product_composition VALUES (730, 305, 297);
INSERT INTO public.product_composition VALUES (731, 306, 298);
INSERT INTO public.product_composition VALUES (732, 306, 300);
INSERT INTO public.product_composition VALUES (733, 307, 298);
INSERT INTO public.product_composition VALUES (734, 307, 270);
INSERT INTO public.product_composition VALUES (735, 308, 298);
INSERT INTO public.product_composition VALUES (736, 308, 270);
INSERT INTO public.product_composition VALUES (737, 309, 292);
INSERT INTO public.product_composition VALUES (738, 309, 295);
INSERT INTO public.product_composition VALUES (739, 309, 274);
INSERT INTO public.product_composition VALUES (740, 310, 269);
INSERT INTO public.product_composition VALUES (741, 310, 295);
INSERT INTO public.product_composition VALUES (742, 310, 292);
INSERT INTO public.product_composition VALUES (743, 311, 298);
INSERT INTO public.product_composition VALUES (744, 311, 295);
INSERT INTO public.product_composition VALUES (745, 311, 274);
INSERT INTO public.product_composition VALUES (746, 312, 301);
INSERT INTO public.product_composition VALUES (747, 312, 292);
INSERT INTO public.product_composition VALUES (748, 312, 274);
INSERT INTO public.product_composition VALUES (749, 312, 302);
INSERT INTO public.product_composition VALUES (750, 313, 301);
INSERT INTO public.product_composition VALUES (751, 313, 292);
INSERT INTO public.product_composition VALUES (752, 313, 274);
INSERT INTO public.product_composition VALUES (753, 313, 303);
INSERT INTO public.product_composition VALUES (754, 314, 304);
INSERT INTO public.product_composition VALUES (755, 314, 286);
INSERT INTO public.product_composition VALUES (756, 315, 269);
INSERT INTO public.product_composition VALUES (757, 315, 292);
INSERT INTO public.product_composition VALUES (758, 316, 292);
INSERT INTO public.product_composition VALUES (759, 316, 305);
INSERT INTO public.product_composition VALUES (760, 316, 274);
INSERT INTO public.product_composition VALUES (761, 317, 269);
INSERT INTO public.product_composition VALUES (762, 317, 292);
INSERT INTO public.product_composition VALUES (763, 317, 305);
INSERT INTO public.product_composition VALUES (764, 318, 292);
INSERT INTO public.product_composition VALUES (765, 318, 274);
INSERT INTO public.product_composition VALUES (766, 318, 302);
INSERT INTO public.product_composition VALUES (767, 319, 306);
INSERT INTO public.product_composition VALUES (768, 319, 292);
INSERT INTO public.product_composition VALUES (769, 319, 274);
INSERT INTO public.product_composition VALUES (770, 320, 269);
INSERT INTO public.product_composition VALUES (771, 320, 307);
INSERT INTO public.product_composition VALUES (772, 320, 292);
INSERT INTO public.product_composition VALUES (773, 321, 304);
INSERT INTO public.product_composition VALUES (774, 321, 308);
INSERT INTO public.product_composition VALUES (775, 322, 286);
INSERT INTO public.product_composition VALUES (776, 322, 309);
INSERT INTO public.product_composition VALUES (777, 323, 298);
INSERT INTO public.product_composition VALUES (778, 323, 309);
INSERT INTO public.product_composition VALUES (779, 324, 310);
INSERT INTO public.product_composition VALUES (780, 325, 310);
INSERT INTO public.product_composition VALUES (781, 325, 298);
INSERT INTO public.product_composition VALUES (782, 326, 311);
INSERT INTO public.product_composition VALUES (783, 326, 269);
INSERT INTO public.product_composition VALUES (784, 326, 312);
INSERT INTO public.product_composition VALUES (785, 327, 313);
INSERT INTO public.product_composition VALUES (786, 327, 311);
INSERT INTO public.product_composition VALUES (787, 327, 269);
INSERT INTO public.product_composition VALUES (788, 327, 312);
INSERT INTO public.product_composition VALUES (789, 328, 274);
INSERT INTO public.product_composition VALUES (790, 329, 269);
INSERT INTO public.product_composition VALUES (791, 330, 265);
INSERT INTO public.product_composition VALUES (792, 330, 274);
INSERT INTO public.product_composition VALUES (793, 331, 269);
INSERT INTO public.product_composition VALUES (794, 331, 265);
INSERT INTO public.product_composition VALUES (795, 332, 314);
INSERT INTO public.product_composition VALUES (796, 332, 315);
INSERT INTO public.product_composition VALUES (797, 332, 316);
INSERT INTO public.product_composition VALUES (798, 333, 313);
INSERT INTO public.product_composition VALUES (799, 333, 274);
INSERT INTO public.product_composition VALUES (800, 334, 313);
INSERT INTO public.product_composition VALUES (801, 334, 269);
INSERT INTO public.product_composition VALUES (802, 335, 269);
INSERT INTO public.product_composition VALUES (803, 335, 317);
INSERT INTO public.product_composition VALUES (804, 336, 318);
INSERT INTO public.product_composition VALUES (805, 336, 319);
INSERT INTO public.product_composition VALUES (806, 336, 315);
INSERT INTO public.product_composition VALUES (807, 336, 301);
INSERT INTO public.product_composition VALUES (808, 336, 320);
INSERT INTO public.product_composition VALUES (809, 337, 321);
INSERT INTO public.product_composition VALUES (810, 337, 274);
INSERT INTO public.product_composition VALUES (811, 337, 313);
INSERT INTO public.product_composition VALUES (812, 337, 322);
INSERT INTO public.product_composition VALUES (813, 337, 323);
INSERT INTO public.product_composition VALUES (814, 338, 324);
INSERT INTO public.product_composition VALUES (815, 338, 269);
INSERT INTO public.product_composition VALUES (816, 338, 325);
INSERT INTO public.product_composition VALUES (817, 339, 313);
INSERT INTO public.product_composition VALUES (818, 339, 326);
INSERT INTO public.product_composition VALUES (819, 339, 315);
INSERT INTO public.product_composition VALUES (820, 339, 327);
INSERT INTO public.product_composition VALUES (821, 339, 323);
INSERT INTO public.product_composition VALUES (822, 340, 328);
INSERT INTO public.product_composition VALUES (823, 340, 329);
INSERT INTO public.product_composition VALUES (824, 340, 312);
INSERT INTO public.product_composition VALUES (825, 340, 330);
INSERT INTO public.product_composition VALUES (826, 341, 265);
INSERT INTO public.product_composition VALUES (827, 341, 331);
INSERT INTO public.product_composition VALUES (828, 342, 313);
INSERT INTO public.product_composition VALUES (829, 342, 330);
INSERT INTO public.product_composition VALUES (830, 343, 314);
INSERT INTO public.product_composition VALUES (831, 343, 332);
INSERT INTO public.product_composition VALUES (832, 343, 316);
INSERT INTO public.product_composition VALUES (833, 344, 333);
INSERT INTO public.product_composition VALUES (834, 344, 334);
INSERT INTO public.product_composition VALUES (835, 344, 330);
INSERT INTO public.product_composition VALUES (836, 344, 335);
INSERT INTO public.product_composition VALUES (837, 344, 336);
INSERT INTO public.product_composition VALUES (838, 345, 327);
INSERT INTO public.product_composition VALUES (839, 345, 317);
INSERT INTO public.product_composition VALUES (840, 346, 313);
INSERT INTO public.product_composition VALUES (841, 346, 334);
INSERT INTO public.product_composition VALUES (842, 347, 269);
INSERT INTO public.product_composition VALUES (843, 347, 337);
INSERT INTO public.product_composition VALUES (844, 348, 313);
INSERT INTO public.product_composition VALUES (845, 348, 322);
INSERT INTO public.product_composition VALUES (846, 348, 337);
INSERT INTO public.product_composition VALUES (847, 348, 331);
INSERT INTO public.product_composition VALUES (848, 349, 338);
INSERT INTO public.product_composition VALUES (849, 349, 339);
INSERT INTO public.product_composition VALUES (850, 350, 340);
INSERT INTO public.product_composition VALUES (851, 350, 274);
INSERT INTO public.product_composition VALUES (852, 351, 340);
INSERT INTO public.product_composition VALUES (853, 351, 292);
INSERT INTO public.product_composition VALUES (854, 351, 274);
INSERT INTO public.product_composition VALUES (855, 352, 313);
INSERT INTO public.product_composition VALUES (856, 352, 323);
INSERT INTO public.product_composition VALUES (857, 352, 274);
INSERT INTO public.product_composition VALUES (858, 353, 313);
INSERT INTO public.product_composition VALUES (859, 353, 269);
INSERT INTO public.product_composition VALUES (860, 353, 323);
INSERT INTO public.product_composition VALUES (861, 354, 328);
INSERT INTO public.product_composition VALUES (862, 354, 330);
INSERT INTO public.product_composition VALUES (863, 355, 292);
INSERT INTO public.product_composition VALUES (864, 355, 341);
INSERT INTO public.product_composition VALUES (865, 356, 341);
INSERT INTO public.product_composition VALUES (866, 356, 342);
INSERT INTO public.product_composition VALUES (867, 357, 295);
INSERT INTO public.product_composition VALUES (868, 357, 342);
INSERT INTO public.product_composition VALUES (869, 358, 343);
INSERT INTO public.product_composition VALUES (870, 359, 344);
INSERT INTO public.product_composition VALUES (871, 360, 345);
INSERT INTO public.product_composition VALUES (872, 361, 346);
INSERT INTO public.product_composition VALUES (873, 362, 347);
INSERT INTO public.product_composition VALUES (874, 363, 348);
INSERT INTO public.product_composition VALUES (875, 364, 347);
INSERT INTO public.product_composition VALUES (876, 365, 344);
INSERT INTO public.product_composition VALUES (877, 365, 349);
INSERT INTO public.product_composition VALUES (878, 365, 350);
INSERT INTO public.product_composition VALUES (879, 366, 351);
INSERT INTO public.product_composition VALUES (880, 366, 343);
INSERT INTO public.product_composition VALUES (881, 367, 344);
INSERT INTO public.product_composition VALUES (882, 367, 351);
INSERT INTO public.product_composition VALUES (883, 368, 352);
INSERT INTO public.product_composition VALUES (884, 368, 344);
INSERT INTO public.product_composition VALUES (885, 368, 353);
INSERT INTO public.product_composition VALUES (886, 369, 354);
INSERT INTO public.product_composition VALUES (887, 369, 344);
INSERT INTO public.product_composition VALUES (888, 369, 355);
INSERT INTO public.product_composition VALUES (889, 370, 356);
INSERT INTO public.product_composition VALUES (890, 370, 357);
INSERT INTO public.product_composition VALUES (891, 370, 343);
INSERT INTO public.product_composition VALUES (892, 371, 358);
INSERT INTO public.product_composition VALUES (893, 371, 359);
INSERT INTO public.product_composition VALUES (894, 371, 347);
INSERT INTO public.product_composition VALUES (895, 372, 360);
INSERT INTO public.product_composition VALUES (896, 372, 361);
INSERT INTO public.product_composition VALUES (897, 372, 343);
INSERT INTO public.product_composition VALUES (898, 373, 360);
INSERT INTO public.product_composition VALUES (899, 373, 344);
INSERT INTO public.product_composition VALUES (900, 373, 361);
INSERT INTO public.product_composition VALUES (901, 374, 361);
INSERT INTO public.product_composition VALUES (902, 374, 362);
INSERT INTO public.product_composition VALUES (903, 374, 343);
INSERT INTO public.product_composition VALUES (904, 374, 352);
INSERT INTO public.product_composition VALUES (905, 374, 353);
INSERT INTO public.product_composition VALUES (906, 375, 352);
INSERT INTO public.product_composition VALUES (907, 375, 363);
INSERT INTO public.product_composition VALUES (908, 375, 353);
INSERT INTO public.product_composition VALUES (909, 376, 363);
INSERT INTO public.product_composition VALUES (910, 376, 347);
INSERT INTO public.product_composition VALUES (911, 377, 345);
INSERT INTO public.product_composition VALUES (912, 377, 364);
INSERT INTO public.product_composition VALUES (913, 378, 365);
INSERT INTO public.product_composition VALUES (914, 378, 343);
INSERT INTO public.product_composition VALUES (915, 379, 366);
INSERT INTO public.product_composition VALUES (916, 379, 367);
INSERT INTO public.product_composition VALUES (917, 380, 366);
INSERT INTO public.product_composition VALUES (918, 380, 343);
INSERT INTO public.product_composition VALUES (919, 380, 368);
INSERT INTO public.product_composition VALUES (920, 381, 366);
INSERT INTO public.product_composition VALUES (921, 381, 343);
INSERT INTO public.product_composition VALUES (922, 382, 366);
INSERT INTO public.product_composition VALUES (923, 382, 343);
INSERT INTO public.product_composition VALUES (924, 383, 366);
INSERT INTO public.product_composition VALUES (925, 383, 344);
INSERT INTO public.product_composition VALUES (926, 384, 366);
INSERT INTO public.product_composition VALUES (927, 384, 348);
INSERT INTO public.product_composition VALUES (928, 385, 366);
INSERT INTO public.product_composition VALUES (929, 385, 347);
INSERT INTO public.product_composition VALUES (930, 386, 344);
INSERT INTO public.product_composition VALUES (931, 386, 369);
INSERT INTO public.product_composition VALUES (932, 387, 370);
INSERT INTO public.product_composition VALUES (933, 387, 369);
INSERT INTO public.product_composition VALUES (934, 388, 352);
INSERT INTO public.product_composition VALUES (935, 388, 353);
INSERT INTO public.product_composition VALUES (936, 388, 369);
INSERT INTO public.product_composition VALUES (937, 389, 352);
INSERT INTO public.product_composition VALUES (938, 389, 353);
INSERT INTO public.product_composition VALUES (939, 389, 371);
INSERT INTO public.product_composition VALUES (940, 389, 369);
INSERT INTO public.product_composition VALUES (941, 390, 347);
INSERT INTO public.product_composition VALUES (942, 390, 369);
INSERT INTO public.product_composition VALUES (943, 391, 372);
INSERT INTO public.product_composition VALUES (944, 391, 369);
INSERT INTO public.product_composition VALUES (945, 391, 343);
INSERT INTO public.product_composition VALUES (946, 392, 373);
INSERT INTO public.product_composition VALUES (947, 392, 343);
INSERT INTO public.product_composition VALUES (948, 393, 344);
INSERT INTO public.product_composition VALUES (949, 393, 373);
INSERT INTO public.product_composition VALUES (950, 394, 347);
INSERT INTO public.product_composition VALUES (951, 394, 373);
INSERT INTO public.product_composition VALUES (952, 395, 372);
INSERT INTO public.product_composition VALUES (953, 395, 348);
INSERT INTO public.product_composition VALUES (954, 396, 372);
INSERT INTO public.product_composition VALUES (955, 396, 343);
INSERT INTO public.product_composition VALUES (956, 396, 374);
INSERT INTO public.product_composition VALUES (957, 397, 375);
INSERT INTO public.product_composition VALUES (958, 397, 343);
INSERT INTO public.product_composition VALUES (959, 398, 375);
INSERT INTO public.product_composition VALUES (960, 398, 372);
INSERT INTO public.product_composition VALUES (961, 398, 343);
INSERT INTO public.product_composition VALUES (962, 399, 352);
INSERT INTO public.product_composition VALUES (963, 399, 375);
INSERT INTO public.product_composition VALUES (964, 399, 353);
INSERT INTO public.product_composition VALUES (965, 399, 344);
INSERT INTO public.product_composition VALUES (966, 400, 376);
INSERT INTO public.product_composition VALUES (967, 401, 377);
INSERT INTO public.product_composition VALUES (968, 402, 378);
INSERT INTO public.product_composition VALUES (969, 403, 379);
INSERT INTO public.product_composition VALUES (970, 404, 380);
INSERT INTO public.product_composition VALUES (971, 404, 377);
INSERT INTO public.product_composition VALUES (972, 404, 381);
INSERT INTO public.product_composition VALUES (973, 405, 380);
INSERT INTO public.product_composition VALUES (974, 405, 381);
INSERT INTO public.product_composition VALUES (975, 405, 376);
INSERT INTO public.product_composition VALUES (976, 406, 382);
INSERT INTO public.product_composition VALUES (977, 406, 377);
INSERT INTO public.product_composition VALUES (978, 407, 377);
INSERT INTO public.product_composition VALUES (979, 407, 383);
INSERT INTO public.product_composition VALUES (980, 407, 384);
INSERT INTO public.product_composition VALUES (981, 407, 385);
INSERT INTO public.product_composition VALUES (982, 408, 377);
INSERT INTO public.product_composition VALUES (983, 408, 383);
INSERT INTO public.product_composition VALUES (984, 408, 384);
INSERT INTO public.product_composition VALUES (985, 408, 385);
INSERT INTO public.product_composition VALUES (986, 409, 377);
INSERT INTO public.product_composition VALUES (987, 409, 386);
INSERT INTO public.product_composition VALUES (988, 410, 387);
INSERT INTO public.product_composition VALUES (989, 410, 388);
INSERT INTO public.product_composition VALUES (990, 410, 376);
INSERT INTO public.product_composition VALUES (991, 411, 387);
INSERT INTO public.product_composition VALUES (992, 411, 377);
INSERT INTO public.product_composition VALUES (993, 411, 388);
INSERT INTO public.product_composition VALUES (994, 412, 379);
INSERT INTO public.product_composition VALUES (995, 412, 389);
INSERT INTO public.product_composition VALUES (996, 412, 390);
INSERT INTO public.product_composition VALUES (997, 413, 391);
INSERT INTO public.product_composition VALUES (998, 413, 377);
INSERT INTO public.product_composition VALUES (999, 414, 391);
INSERT INTO public.product_composition VALUES (1000, 414, 376);
INSERT INTO public.product_composition VALUES (1001, 415, 391);
INSERT INTO public.product_composition VALUES (1002, 415, 378);
INSERT INTO public.product_composition VALUES (1003, 416, 391);
INSERT INTO public.product_composition VALUES (1004, 416, 379);
INSERT INTO public.product_composition VALUES (1005, 417, 389);
INSERT INTO public.product_composition VALUES (1006, 417, 390);
INSERT INTO public.product_composition VALUES (1007, 417, 376);
INSERT INTO public.product_composition VALUES (1008, 418, 377);
INSERT INTO public.product_composition VALUES (1009, 418, 390);
INSERT INTO public.product_composition VALUES (1010, 418, 389);
INSERT INTO public.product_composition VALUES (1011, 419, 378);
INSERT INTO public.product_composition VALUES (1012, 419, 390);
INSERT INTO public.product_composition VALUES (1013, 419, 389);
INSERT INTO public.product_composition VALUES (1014, 420, 392);
INSERT INTO public.product_composition VALUES (1015, 420, 376);
INSERT INTO public.product_composition VALUES (1016, 421, 392);
INSERT INTO public.product_composition VALUES (1017, 421, 377);
INSERT INTO public.product_composition VALUES (1018, 422, 393);
INSERT INTO public.product_composition VALUES (1019, 422, 376);
INSERT INTO public.product_composition VALUES (1020, 423, 377);
INSERT INTO public.product_composition VALUES (1021, 423, 393);
INSERT INTO public.product_composition VALUES (1022, 424, 394);
INSERT INTO public.product_composition VALUES (1023, 424, 393);
INSERT INTO public.product_composition VALUES (1024, 425, 393);
INSERT INTO public.product_composition VALUES (1025, 425, 379);
INSERT INTO public.product_composition VALUES (1026, 426, 395);
INSERT INTO public.product_composition VALUES (1027, 426, 378);
INSERT INTO public.product_composition VALUES (1028, 427, 395);
INSERT INTO public.product_composition VALUES (1029, 427, 379);
INSERT INTO public.product_composition VALUES (1030, 428, 395);
INSERT INTO public.product_composition VALUES (1031, 428, 396);
INSERT INTO public.product_composition VALUES (1032, 429, 391);
INSERT INTO public.product_composition VALUES (1033, 429, 377);
INSERT INTO public.product_composition VALUES (1034, 429, 392);
INSERT INTO public.product_composition VALUES (1035, 430, 391);
INSERT INTO public.product_composition VALUES (1036, 430, 392);
INSERT INTO public.product_composition VALUES (1037, 430, 376);
INSERT INTO public.product_composition VALUES (1038, 431, 391);
INSERT INTO public.product_composition VALUES (1039, 431, 392);
INSERT INTO public.product_composition VALUES (1040, 431, 378);
INSERT INTO public.product_composition VALUES (1041, 432, 391);
INSERT INTO public.product_composition VALUES (1042, 432, 392);
INSERT INTO public.product_composition VALUES (1043, 432, 379);
INSERT INTO public.product_composition VALUES (1044, 433, 397);
INSERT INTO public.product_composition VALUES (1045, 433, 376);
INSERT INTO public.product_composition VALUES (1046, 434, 397);
INSERT INTO public.product_composition VALUES (1047, 434, 377);
INSERT INTO public.product_composition VALUES (1048, 435, 397);
INSERT INTO public.product_composition VALUES (1049, 435, 378);
INSERT INTO public.product_composition VALUES (1050, 436, 397);
INSERT INTO public.product_composition VALUES (1051, 436, 379);
INSERT INTO public.product_composition VALUES (1052, 437, 392);
INSERT INTO public.product_composition VALUES (1053, 437, 398);
INSERT INTO public.product_composition VALUES (1054, 437, 376);
INSERT INTO public.product_composition VALUES (1055, 438, 377);
INSERT INTO public.product_composition VALUES (1056, 438, 392);
INSERT INTO public.product_composition VALUES (1057, 438, 398);
INSERT INTO public.product_composition VALUES (1058, 439, 399);
INSERT INTO public.product_composition VALUES (1059, 439, 376);
INSERT INTO public.product_composition VALUES (1060, 440, 399);
INSERT INTO public.product_composition VALUES (1061, 440, 377);
INSERT INTO public.product_composition VALUES (1062, 441, 399);
INSERT INTO public.product_composition VALUES (1063, 441, 378);
INSERT INTO public.product_composition VALUES (1064, 442, 399);
INSERT INTO public.product_composition VALUES (1065, 442, 379);
INSERT INTO public.product_composition VALUES (1066, 443, 399);
INSERT INTO public.product_composition VALUES (1067, 443, 392);
INSERT INTO public.product_composition VALUES (1068, 443, 376);
INSERT INTO public.product_composition VALUES (1069, 444, 400);
INSERT INTO public.product_composition VALUES (1070, 444, 392);
INSERT INTO public.product_composition VALUES (1071, 444, 376);
INSERT INTO public.product_composition VALUES (1072, 445, 377);
INSERT INTO public.product_composition VALUES (1073, 445, 392);
INSERT INTO public.product_composition VALUES (1074, 445, 400);
INSERT INTO public.product_composition VALUES (1075, 446, 392);
INSERT INTO public.product_composition VALUES (1076, 446, 378);
INSERT INTO public.product_composition VALUES (1077, 446, 400);
INSERT INTO public.product_composition VALUES (1078, 447, 392);
INSERT INTO public.product_composition VALUES (1079, 447, 376);
INSERT INTO public.product_composition VALUES (1080, 447, 401);
INSERT INTO public.product_composition VALUES (1081, 448, 392);
INSERT INTO public.product_composition VALUES (1082, 448, 379);
INSERT INTO public.product_composition VALUES (1083, 448, 400);
INSERT INTO public.product_composition VALUES (1084, 449, 376);
INSERT INTO public.product_composition VALUES (1085, 449, 400);
INSERT INTO public.product_composition VALUES (1086, 450, 377);
INSERT INTO public.product_composition VALUES (1087, 450, 400);
INSERT INTO public.product_composition VALUES (1088, 451, 378);
INSERT INTO public.product_composition VALUES (1089, 451, 400);
INSERT INTO public.product_composition VALUES (1090, 452, 392);
INSERT INTO public.product_composition VALUES (1091, 452, 379);
INSERT INTO public.product_composition VALUES (1092, 452, 400);
INSERT INTO public.product_composition VALUES (1093, 453, 402);
INSERT INTO public.product_composition VALUES (1094, 453, 376);
INSERT INTO public.product_composition VALUES (1095, 454, 402);
INSERT INTO public.product_composition VALUES (1096, 454, 377);
INSERT INTO public.product_composition VALUES (1097, 455, 402);
INSERT INTO public.product_composition VALUES (1098, 455, 379);
INSERT INTO public.product_composition VALUES (1099, 456, 402);
INSERT INTO public.product_composition VALUES (1100, 456, 396);
INSERT INTO public.product_composition VALUES (1101, 457, 399);
INSERT INTO public.product_composition VALUES (1102, 457, 402);
INSERT INTO public.product_composition VALUES (1103, 458, 397);
INSERT INTO public.product_composition VALUES (1104, 458, 402);
INSERT INTO public.product_composition VALUES (1105, 459, 402);
INSERT INTO public.product_composition VALUES (1106, 459, 379);
INSERT INTO public.product_composition VALUES (1107, 460, 391);
INSERT INTO public.product_composition VALUES (1108, 460, 402);
INSERT INTO public.product_composition VALUES (1109, 460, 377);
INSERT INTO public.product_composition VALUES (1110, 461, 391);
INSERT INTO public.product_composition VALUES (1111, 461, 402);
INSERT INTO public.product_composition VALUES (1112, 461, 376);
INSERT INTO public.product_composition VALUES (1113, 462, 391);
INSERT INTO public.product_composition VALUES (1114, 462, 402);
INSERT INTO public.product_composition VALUES (1115, 462, 378);
INSERT INTO public.product_composition VALUES (1116, 463, 391);
INSERT INTO public.product_composition VALUES (1117, 463, 402);
INSERT INTO public.product_composition VALUES (1118, 463, 379);
INSERT INTO public.product_composition VALUES (1119, 464, 391);
INSERT INTO public.product_composition VALUES (1120, 464, 402);
INSERT INTO public.product_composition VALUES (1121, 464, 379);
INSERT INTO public.product_composition VALUES (1122, 465, 384);
INSERT INTO public.product_composition VALUES (1123, 465, 385);
INSERT INTO public.product_composition VALUES (1124, 465, 377);
INSERT INTO public.product_composition VALUES (1125, 465, 383);
INSERT INTO public.product_composition VALUES (1126, 465, 403);
INSERT INTO public.product_composition VALUES (1127, 466, 380);
INSERT INTO public.product_composition VALUES (1128, 466, 381);
INSERT INTO public.product_composition VALUES (1129, 466, 386);
INSERT INTO public.product_composition VALUES (1130, 467, 380);
INSERT INTO public.product_composition VALUES (1131, 467, 381);
INSERT INTO public.product_composition VALUES (1132, 468, 380);
INSERT INTO public.product_composition VALUES (1133, 468, 381);
INSERT INTO public.product_composition VALUES (1134, 468, 385);
INSERT INTO public.product_composition VALUES (1135, 469, 382);
INSERT INTO public.product_composition VALUES (1136, 469, 380);
INSERT INTO public.product_composition VALUES (1137, 469, 381);
INSERT INTO public.product_composition VALUES (1138, 469, 403);
INSERT INTO public.product_composition VALUES (1139, 470, 404);
INSERT INTO public.product_composition VALUES (1140, 470, 390);
INSERT INTO public.product_composition VALUES (1141, 470, 389);
INSERT INTO public.product_composition VALUES (1142, 471, 405);
INSERT INTO public.product_composition VALUES (1143, 471, 376);
INSERT INTO public.product_composition VALUES (1144, 471, 406);
INSERT INTO public.product_composition VALUES (1145, 472, 377);
INSERT INTO public.product_composition VALUES (1146, 472, 405);
INSERT INTO public.product_composition VALUES (1147, 472, 406);
INSERT INTO public.product_composition VALUES (1148, 473, 378);
INSERT INTO public.product_composition VALUES (1149, 473, 405);
INSERT INTO public.product_composition VALUES (1150, 473, 406);
INSERT INTO public.product_composition VALUES (1151, 474, 379);
INSERT INTO public.product_composition VALUES (1152, 474, 405);
INSERT INTO public.product_composition VALUES (1153, 474, 406);
INSERT INTO public.product_composition VALUES (1154, 475, 407);
INSERT INTO public.product_composition VALUES (1155, 475, 376);
INSERT INTO public.product_composition VALUES (1156, 475, 408);
INSERT INTO public.product_composition VALUES (1157, 476, 407);
INSERT INTO public.product_composition VALUES (1158, 476, 377);
INSERT INTO public.product_composition VALUES (1159, 476, 408);
INSERT INTO public.product_composition VALUES (1160, 477, 407);
INSERT INTO public.product_composition VALUES (1161, 477, 378);
INSERT INTO public.product_composition VALUES (1162, 477, 408);
INSERT INTO public.product_composition VALUES (1163, 478, 407);
INSERT INTO public.product_composition VALUES (1164, 478, 379);
INSERT INTO public.product_composition VALUES (1165, 478, 408);
INSERT INTO public.product_composition VALUES (1166, 479, 409);
INSERT INTO public.product_composition VALUES (1167, 479, 376);
INSERT INTO public.product_composition VALUES (1168, 480, 409);
INSERT INTO public.product_composition VALUES (1169, 480, 377);
INSERT INTO public.product_composition VALUES (1170, 481, 409);
INSERT INTO public.product_composition VALUES (1171, 481, 378);
INSERT INTO public.product_composition VALUES (1172, 482, 409);
INSERT INTO public.product_composition VALUES (1173, 482, 379);
INSERT INTO public.product_composition VALUES (1174, 483, 397);
INSERT INTO public.product_composition VALUES (1175, 483, 378);
INSERT INTO public.product_composition VALUES (1176, 483, 399);
INSERT INTO public.product_composition VALUES (1177, 483, 401);
INSERT INTO public.product_composition VALUES (1178, 484, 377);
INSERT INTO public.product_composition VALUES (1179, 484, 392);
INSERT INTO public.product_composition VALUES (1180, 484, 398);
INSERT INTO public.product_composition VALUES (1181, 485, 392);
INSERT INTO public.product_composition VALUES (1182, 485, 378);
INSERT INTO public.product_composition VALUES (1183, 485, 393);
INSERT INTO public.product_composition VALUES (1184, 486, 410);
INSERT INTO public.product_composition VALUES (1185, 487, 411);
INSERT INTO public.product_composition VALUES (1186, 487, 410);
INSERT INTO public.product_composition VALUES (1187, 488, 412);
INSERT INTO public.product_composition VALUES (1188, 488, 411);
INSERT INTO public.product_composition VALUES (1189, 488, 410);
INSERT INTO public.product_composition VALUES (1190, 489, 413);
INSERT INTO public.product_composition VALUES (1191, 489, 411);
INSERT INTO public.product_composition VALUES (1192, 489, 410);
INSERT INTO public.product_composition VALUES (1193, 490, 411);
INSERT INTO public.product_composition VALUES (1194, 490, 414);
INSERT INTO public.product_composition VALUES (1195, 490, 415);
INSERT INTO public.product_composition VALUES (1196, 491, 416);
INSERT INTO public.product_composition VALUES (1197, 491, 417);
INSERT INTO public.product_composition VALUES (1198, 491, 418);
INSERT INTO public.product_composition VALUES (1199, 491, 419);
INSERT INTO public.product_composition VALUES (1200, 491, 410);
INSERT INTO public.product_composition VALUES (1201, 492, 418);
INSERT INTO public.product_composition VALUES (1202, 492, 410);
INSERT INTO public.product_composition VALUES (1203, 492, 420);
INSERT INTO public.product_composition VALUES (1204, 493, 421);
INSERT INTO public.product_composition VALUES (1205, 493, 422);
INSERT INTO public.product_composition VALUES (1206, 493, 410);
INSERT INTO public.product_composition VALUES (1207, 494, 413);
INSERT INTO public.product_composition VALUES (1208, 494, 422);
INSERT INTO public.product_composition VALUES (1209, 494, 410);
INSERT INTO public.product_composition VALUES (1210, 494, 421);
INSERT INTO public.product_composition VALUES (1211, 495, 423);
INSERT INTO public.product_composition VALUES (1212, 495, 410);
INSERT INTO public.product_composition VALUES (1213, 495, 424);
INSERT INTO public.product_composition VALUES (1214, 495, 425);
INSERT INTO public.product_composition VALUES (1215, 496, 426);
INSERT INTO public.product_composition VALUES (1216, 496, 427);
INSERT INTO public.product_composition VALUES (1217, 496, 428);
INSERT INTO public.product_composition VALUES (1218, 496, 429);
INSERT INTO public.product_composition VALUES (1219, 496, 430);
INSERT INTO public.product_composition VALUES (1220, 496, 431);
INSERT INTO public.product_composition VALUES (1221, 497, 432);
INSERT INTO public.product_composition VALUES (1222, 497, 433);
INSERT INTO public.product_composition VALUES (1223, 497, 434);
INSERT INTO public.product_composition VALUES (1224, 498, 411);
INSERT INTO public.product_composition VALUES (1225, 498, 435);
INSERT INTO public.product_composition VALUES (1226, 499, 413);
INSERT INTO public.product_composition VALUES (1227, 499, 411);
INSERT INTO public.product_composition VALUES (1228, 499, 435);
INSERT INTO public.product_composition VALUES (1229, 500, 436);
INSERT INTO public.product_composition VALUES (1230, 501, 435);
INSERT INTO public.product_composition VALUES (1231, 502, 437);
INSERT INTO public.product_composition VALUES (1232, 503, 438);
INSERT INTO public.product_composition VALUES (1233, 504, 439);
INSERT INTO public.product_composition VALUES (1234, 505, 437);
INSERT INTO public.product_composition VALUES (1235, 505, 429);
INSERT INTO public.product_composition VALUES (1236, 506, 440);
INSERT INTO public.product_composition VALUES (1237, 506, 441);
INSERT INTO public.product_composition VALUES (1238, 507, 412);
INSERT INTO public.product_composition VALUES (1239, 507, 437);
INSERT INTO public.product_composition VALUES (1240, 507, 442);
INSERT INTO public.product_composition VALUES (1241, 508, 436);
INSERT INTO public.product_composition VALUES (1242, 508, 443);
INSERT INTO public.product_composition VALUES (1243, 509, 435);
INSERT INTO public.product_composition VALUES (1244, 509, 443);
INSERT INTO public.product_composition VALUES (1245, 510, 437);
INSERT INTO public.product_composition VALUES (1246, 510, 443);
INSERT INTO public.product_composition VALUES (1247, 511, 413);
INSERT INTO public.product_composition VALUES (1248, 511, 418);
INSERT INTO public.product_composition VALUES (1249, 511, 444);
INSERT INTO public.product_composition VALUES (1250, 512, 445);
INSERT INTO public.product_composition VALUES (1251, 512, 418);
INSERT INTO public.product_composition VALUES (1252, 512, 446);
INSERT INTO public.product_composition VALUES (1253, 512, 443);
INSERT INTO public.product_composition VALUES (1254, 512, 447);
INSERT INTO public.product_composition VALUES (1255, 512, 419);
INSERT INTO public.product_composition VALUES (1256, 512, 448);
INSERT INTO public.product_composition VALUES (1257, 512, 449);
INSERT INTO public.product_composition VALUES (1258, 513, 450);
INSERT INTO public.product_composition VALUES (1259, 513, 435);
INSERT INTO public.product_composition VALUES (1260, 513, 451);
INSERT INTO public.product_composition VALUES (1261, 513, 445);
INSERT INTO public.product_composition VALUES (1262, 514, 418);
INSERT INTO public.product_composition VALUES (1263, 514, 419);
INSERT INTO public.product_composition VALUES (1264, 514, 439);
INSERT INTO public.product_composition VALUES (1265, 515, 412);
INSERT INTO public.product_composition VALUES (1266, 515, 435);
INSERT INTO public.product_composition VALUES (1267, 515, 452);
INSERT INTO public.product_composition VALUES (1268, 515, 442);
INSERT INTO public.product_composition VALUES (1269, 516, 435);
INSERT INTO public.product_composition VALUES (1270, 516, 453);
INSERT INTO public.product_composition VALUES (1271, 517, 435);
INSERT INTO public.product_composition VALUES (1272, 517, 452);
INSERT INTO public.product_composition VALUES (1273, 518, 435);
INSERT INTO public.product_composition VALUES (1274, 518, 454);
INSERT INTO public.product_composition VALUES (1275, 518, 451);
INSERT INTO public.product_composition VALUES (1276, 519, 418);
INSERT INTO public.product_composition VALUES (1277, 519, 419);
INSERT INTO public.product_composition VALUES (1278, 519, 436);
INSERT INTO public.product_composition VALUES (1279, 519, 443);
INSERT INTO public.product_composition VALUES (1280, 520, 418);
INSERT INTO public.product_composition VALUES (1281, 520, 435);
INSERT INTO public.product_composition VALUES (1282, 520, 419);
INSERT INTO public.product_composition VALUES (1283, 520, 443);
INSERT INTO public.product_composition VALUES (1284, 521, 418);
INSERT INTO public.product_composition VALUES (1285, 521, 437);
INSERT INTO public.product_composition VALUES (1286, 521, 419);
INSERT INTO public.product_composition VALUES (1287, 521, 443);
INSERT INTO public.product_composition VALUES (1288, 522, 418);
INSERT INTO public.product_composition VALUES (1289, 522, 455);
INSERT INTO public.product_composition VALUES (1290, 522, 419);
INSERT INTO public.product_composition VALUES (1291, 522, 443);
INSERT INTO public.product_composition VALUES (1292, 523, 418);
INSERT INTO public.product_composition VALUES (1293, 523, 419);
INSERT INTO public.product_composition VALUES (1294, 523, 436);
INSERT INTO public.product_composition VALUES (1295, 524, 418);
INSERT INTO public.product_composition VALUES (1296, 524, 435);
INSERT INTO public.product_composition VALUES (1297, 524, 419);
INSERT INTO public.product_composition VALUES (1298, 525, 418);
INSERT INTO public.product_composition VALUES (1299, 525, 437);
INSERT INTO public.product_composition VALUES (1300, 525, 419);
INSERT INTO public.product_composition VALUES (1301, 526, 418);
INSERT INTO public.product_composition VALUES (1302, 526, 419);
INSERT INTO public.product_composition VALUES (1303, 526, 444);
INSERT INTO public.product_composition VALUES (1304, 527, 444);
INSERT INTO public.product_composition VALUES (1305, 527, 456);
INSERT INTO public.product_composition VALUES (1306, 528, 418);
INSERT INTO public.product_composition VALUES (1307, 528, 448);
INSERT INTO public.product_composition VALUES (1308, 528, 419);
INSERT INTO public.product_composition VALUES (1309, 528, 446);
INSERT INTO public.product_composition VALUES (1310, 529, 418);
INSERT INTO public.product_composition VALUES (1311, 529, 435);
INSERT INTO public.product_composition VALUES (1312, 530, 435);
INSERT INTO public.product_composition VALUES (1313, 530, 457);
INSERT INTO public.product_composition VALUES (1314, 531, 458);
INSERT INTO public.product_composition VALUES (1315, 531, 459);
INSERT INTO public.product_composition VALUES (1316, 531, 436);
INSERT INTO public.product_composition VALUES (1317, 532, 411);
INSERT INTO public.product_composition VALUES (1318, 532, 458);
INSERT INTO public.product_composition VALUES (1319, 532, 453);
INSERT INTO public.product_composition VALUES (1320, 532, 459);
INSERT INTO public.product_composition VALUES (1321, 533, 435);
INSERT INTO public.product_composition VALUES (1322, 533, 460);
INSERT INTO public.product_composition VALUES (1323, 534, 460);
INSERT INTO public.product_composition VALUES (1324, 534, 436);
INSERT INTO public.product_composition VALUES (1325, 535, 460);
INSERT INTO public.product_composition VALUES (1326, 535, 415);
INSERT INTO public.product_composition VALUES (1327, 535, 436);
INSERT INTO public.product_composition VALUES (1328, 536, 460);
INSERT INTO public.product_composition VALUES (1329, 536, 436);
INSERT INTO public.product_composition VALUES (1330, 536, 412);
INSERT INTO public.product_composition VALUES (1331, 536, 433);
INSERT INTO public.product_composition VALUES (1332, 536, 461);
INSERT INTO public.product_composition VALUES (1333, 537, 461);
INSERT INTO public.product_composition VALUES (1334, 537, 460);
INSERT INTO public.product_composition VALUES (1335, 537, 436);
INSERT INTO public.product_composition VALUES (1336, 538, 413);
INSERT INTO public.product_composition VALUES (1337, 538, 460);
INSERT INTO public.product_composition VALUES (1338, 538, 436);
INSERT INTO public.product_composition VALUES (1339, 539, 412);
INSERT INTO public.product_composition VALUES (1340, 539, 462);
INSERT INTO public.product_composition VALUES (1341, 539, 460);
INSERT INTO public.product_composition VALUES (1342, 539, 438);
INSERT INTO public.product_composition VALUES (1343, 540, 438);
INSERT INTO public.product_composition VALUES (1344, 540, 460);
INSERT INTO public.product_composition VALUES (1345, 541, 438);
INSERT INTO public.product_composition VALUES (1346, 541, 460);
INSERT INTO public.product_composition VALUES (1347, 541, 415);
INSERT INTO public.product_composition VALUES (1348, 542, 411);
INSERT INTO public.product_composition VALUES (1349, 542, 436);
INSERT INTO public.product_composition VALUES (1350, 543, 411);
INSERT INTO public.product_composition VALUES (1351, 543, 415);
INSERT INTO public.product_composition VALUES (1352, 543, 436);
INSERT INTO public.product_composition VALUES (1353, 544, 413);
INSERT INTO public.product_composition VALUES (1354, 544, 411);
INSERT INTO public.product_composition VALUES (1355, 544, 436);
INSERT INTO public.product_composition VALUES (1356, 545, 411);
INSERT INTO public.product_composition VALUES (1357, 545, 463);
INSERT INTO public.product_composition VALUES (1358, 546, 464);
INSERT INTO public.product_composition VALUES (1359, 546, 415);
INSERT INTO public.product_composition VALUES (1360, 547, 411);
INSERT INTO public.product_composition VALUES (1361, 547, 438);


--
-- Data for Name: store; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.store VALUES (1, 1, '功夫茶', '台北市');
INSERT INTO public.store VALUES (2, 1, '大茗本位制茶堂', '台北市');
INSERT INTO public.store VALUES (3, 1, '得正', '台北市');
INSERT INTO public.store VALUES (4, 1, '先喝道', '台北市');
INSERT INTO public.store VALUES (5, 1, '清新福全', '台北市');
INSERT INTO public.store VALUES (6, 1, '迷克夏', '台北市');
INSERT INTO public.store VALUES (7, 1, 'Comebuy', '台北市');
INSERT INTO public.store VALUES (8, 1, '龜記', '台北市');
INSERT INTO public.store VALUES (9, 1, '五十嵐', '台北市');
INSERT INTO public.store VALUES (10, 1, 'Coco都可', '台北市');


--
-- Data for Name: tenant; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tenant VALUES (1, '功夫茶', true);
INSERT INTO public.tenant VALUES (2, '大茗本位制茶堂', true);
INSERT INTO public.tenant VALUES (3, '得正', true);
INSERT INTO public.tenant VALUES (4, '先喝道', true);
INSERT INTO public.tenant VALUES (5, '清心福全', true);
INSERT INTO public.tenant VALUES (6, '迷客夏', true);
INSERT INTO public.tenant VALUES (7, 'comebuy', true);
INSERT INTO public.tenant VALUES (8, '龜記', true);
INSERT INTO public.tenant VALUES (9, '五十嵐', true);
INSERT INTO public.tenant VALUES (10, 'coco都可', true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: weather_cache; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: content_image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.content_image_id_seq', 255, true);


--
-- Name: external_trends_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.external_trends_id_seq', 1, false);


--
-- Name: holiday_calendar_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.holiday_calendar_id_seq', 1, false);


--
-- Name: ingredient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ingredient_id_seq', 464, true);


--
-- Name: marketing_content_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.marketing_content_id_seq', 397, true);


--
-- Name: price_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.price_history_id_seq', 1, false);


--
-- Name: product_composition_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_composition_id_seq', 1361, true);


--
-- Name: product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_id_seq', 547, true);


--
-- Name: tenant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tenant_id_seq', 10, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- Name: weather_cache_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.weather_cache_id_seq', 1, false);


--
-- Name: content_image content_image_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_image
    ADD CONSTRAINT content_image_pkey PRIMARY KEY (id);


--
-- Name: external_trends external_trends_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.external_trends
    ADD CONSTRAINT external_trends_pkey PRIMARY KEY (id);


--
-- Name: holiday_calendar holiday_calendar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.holiday_calendar
    ADD CONSTRAINT holiday_calendar_pkey PRIMARY KEY (id);


--
-- Name: ingredient ingredient_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingredient
    ADD CONSTRAINT ingredient_pkey PRIMARY KEY (id);


--
-- Name: marketing_content marketing_content_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.marketing_content
    ADD CONSTRAINT marketing_content_pkey PRIMARY KEY (id);


--
-- Name: price_history price_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.price_history
    ADD CONSTRAINT price_history_pkey PRIMARY KEY (id);


--
-- Name: product_composition product_composition_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_composition
    ADD CONSTRAINT product_composition_pkey PRIMARY KEY (id);


--
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);


--
-- Name: store store_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store
    ADD CONSTRAINT store_pkey PRIMARY KEY (id);


--
-- Name: tenant tenant_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tenant
    ADD CONSTRAINT tenant_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: weather_cache weather_cache_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.weather_cache
    ADD CONSTRAINT weather_cache_pkey PRIMARY KEY (id);


--
-- Name: ingredient ingredient_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingredient
    ADD CONSTRAINT ingredient_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenant(id);


--
-- Name: marketing_content marketing_content_store_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.marketing_content
    ADD CONSTRAINT marketing_content_store_id_fkey FOREIGN KEY (store_id) REFERENCES public.store(id);


--
-- Name: price_history price_history_ingredient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.price_history
    ADD CONSTRAINT price_history_ingredient_id_fkey FOREIGN KEY (ingredient_id) REFERENCES public.ingredient(id);


--
-- Name: product_composition product_composition_ingredient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_composition
    ADD CONSTRAINT product_composition_ingredient_id_fkey FOREIGN KEY (ingredient_id) REFERENCES public.ingredient(id);


--
-- Name: product_composition product_composition_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_composition
    ADD CONSTRAINT product_composition_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(id);


--
-- Name: product product_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenant(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

\unrestrict jvK3tiuGk6vPDbgsMDCA8GxecqDeazFv637A9XGfIazlidSoetGY5IqG9xZcKMR

