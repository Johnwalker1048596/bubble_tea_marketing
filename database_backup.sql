--
-- PostgreSQL database dump
--

\restrict 7Dz5mrN8YSwcfe4fbd8ueQWCDFom2GpXjdulC4bemKDcnRIzeCPDRgtjVaYeQip

-- Dumped from database version 15.15 (Debian 15.15-1.pgdg13+1)
-- Dumped by pg_dump version 15.15 (Debian 15.15-1.pgdg13+1)

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
    platform character varying(255),
    product_name character varying(255),
    final_text text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "Like" integer DEFAULT 0
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
    name character varying(255),
    location_city character varying(255)
);


ALTER TABLE public.store OWNER TO postgres;

--
-- Name: store_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.store_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.store_id_seq OWNER TO postgres;

--
-- Name: store_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.store_id_seq OWNED BY public.store.id;


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
-- Name: store id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store ALTER COLUMN id SET DEFAULT nextval('public.store_id_seq'::regclass);


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

COPY public.content_image (id, content_id, minio_url) FROM stdin;
1	1	http://localhost:9000/marketing/image_1.jpeg
2	2	http://localhost:9000/marketing/image_10.png
3	3	http://localhost:9000/marketing/image_100.png
4	4	http://localhost:9000/marketing/image_101.png
5	5	http://localhost:9000/marketing/image_102.jpeg
6	6	http://localhost:9000/marketing/image_103.png
7	7	http://localhost:9000/marketing/image_104.png
8	8	http://localhost:9000/marketing/image_105.png
9	9	http://localhost:9000/marketing/image_106.jpeg
10	10	http://localhost:9000/marketing/image_107.png
11	11	http://localhost:9000/marketing/image_108.jpeg
12	12	http://localhost:9000/marketing/image_109.png
13	13	http://localhost:9000/marketing/image_11.png
14	14	http://localhost:9000/marketing/image_110.png
15	15	http://localhost:9000/marketing/image_111.png
16	16	http://localhost:9000/marketing/image_112.png
17	17	http://localhost:9000/marketing/image_113.png
18	18	http://localhost:9000/marketing/image_114.png
19	19	http://localhost:9000/marketing/image_115.png
20	20	http://localhost:9000/marketing/image_116.jpeg
21	21	http://localhost:9000/marketing/image_117.png
22	22	http://localhost:9000/marketing/image_118.png
23	23	http://localhost:9000/marketing/image_119.png
24	24	http://localhost:9000/marketing/image_12.png
25	25	http://localhost:9000/marketing/image_120.png
26	26	http://localhost:9000/marketing/image_121.png
27	27	http://localhost:9000/marketing/image_122.png
28	28	http://localhost:9000/marketing/image_123.png
29	29	http://localhost:9000/marketing/image_124.png
30	30	http://localhost:9000/marketing/image_125.png
31	31	http://localhost:9000/marketing/image_126.png
32	32	http://localhost:9000/marketing/image_127.jpeg
33	33	http://localhost:9000/marketing/image_128.png
34	34	http://localhost:9000/marketing/image_129.jpeg
35	35	http://localhost:9000/marketing/image_13.jpeg
36	36	http://localhost:9000/marketing/image_130.jpeg
37	37	http://localhost:9000/marketing/image_131.png
38	38	http://localhost:9000/marketing/image_132.png
39	39	http://localhost:9000/marketing/image_133.png
40	40	http://localhost:9000/marketing/image_134.jpeg
41	41	http://localhost:9000/marketing/image_135.png
42	42	http://localhost:9000/marketing/image_136.png
43	43	http://localhost:9000/marketing/image_137.jpeg
44	44	http://localhost:9000/marketing/image_138.png
45	45	http://localhost:9000/marketing/image_139.png
46	46	http://localhost:9000/marketing/image_14.png
47	47	http://localhost:9000/marketing/image_140.jpeg
48	48	http://localhost:9000/marketing/image_141.png
49	49	http://localhost:9000/marketing/image_142.png
50	50	http://localhost:9000/marketing/image_143.png
51	51	http://localhost:9000/marketing/image_144.png
52	52	http://localhost:9000/marketing/image_145.png
53	53	http://localhost:9000/marketing/image_146.png
54	54	http://localhost:9000/marketing/image_147.png
55	55	http://localhost:9000/marketing/image_148.png
56	56	http://localhost:9000/marketing/image_149.png
57	57	http://localhost:9000/marketing/image_15.jpeg
58	58	http://localhost:9000/marketing/image_150.png
59	59	http://localhost:9000/marketing/image_151.jpeg
60	60	http://localhost:9000/marketing/image_152.jpeg
61	61	http://localhost:9000/marketing/image_153.png
62	62	http://localhost:9000/marketing/image_154.png
63	63	http://localhost:9000/marketing/image_155.jpeg
64	64	http://localhost:9000/marketing/image_156.png
65	65	http://localhost:9000/marketing/image_157.png
66	66	http://localhost:9000/marketing/image_158.png
67	67	http://localhost:9000/marketing/image_159.png
68	68	http://localhost:9000/marketing/image_16.png
69	69	http://localhost:9000/marketing/image_160.png
70	70	http://localhost:9000/marketing/image_161.jpeg
71	71	http://localhost:9000/marketing/image_162.jpeg
72	72	http://localhost:9000/marketing/image_163.png
73	73	http://localhost:9000/marketing/image_164.jpeg
74	74	http://localhost:9000/marketing/image_165.png
75	75	http://localhost:9000/marketing/image_166.png
76	76	http://localhost:9000/marketing/image_167.jpeg
77	77	http://localhost:9000/marketing/image_168.png
78	78	http://localhost:9000/marketing/image_169.png
79	79	http://localhost:9000/marketing/image_17.png
80	80	http://localhost:9000/marketing/image_170.png
81	81	http://localhost:9000/marketing/image_171.png
82	82	http://localhost:9000/marketing/image_172.jpeg
83	83	http://localhost:9000/marketing/image_173.jpeg
84	84	http://localhost:9000/marketing/image_174.png
85	85	http://localhost:9000/marketing/image_175.png
86	86	http://localhost:9000/marketing/image_176.jpeg
87	87	http://localhost:9000/marketing/image_177.png
88	88	http://localhost:9000/marketing/image_178.jpeg
89	89	http://localhost:9000/marketing/image_179.png
90	90	http://localhost:9000/marketing/image_18.jpeg
91	91	http://localhost:9000/marketing/image_180.png
92	92	http://localhost:9000/marketing/image_181.png
93	93	http://localhost:9000/marketing/image_182.png
94	94	http://localhost:9000/marketing/image_183.png
95	95	http://localhost:9000/marketing/image_184.png
96	96	http://localhost:9000/marketing/image_185.jpeg
97	97	http://localhost:9000/marketing/image_186.png
98	98	http://localhost:9000/marketing/image_187.png
99	99	http://localhost:9000/marketing/image_188.png
100	100	http://localhost:9000/marketing/image_189.jpeg
101	101	http://localhost:9000/marketing/image_19.jpeg
102	102	http://localhost:9000/marketing/image_190.png
103	103	http://localhost:9000/marketing/image_191.jpeg
104	1	http://localhost:9000/marketing/image_192.jpeg
105	2	http://localhost:9000/marketing/image_193.png
106	3	http://localhost:9000/marketing/image_194.png
107	4	http://localhost:9000/marketing/image_195.png
108	5	http://localhost:9000/marketing/image_196.png
109	6	http://localhost:9000/marketing/image_197.png
110	7	http://localhost:9000/marketing/image_198.jpeg
111	8	http://localhost:9000/marketing/image_199.jpeg
112	9	http://localhost:9000/marketing/image_2.png
113	10	http://localhost:9000/marketing/image_20.jpeg
114	11	http://localhost:9000/marketing/image_200.png
115	12	http://localhost:9000/marketing/image_201.png
116	13	http://localhost:9000/marketing/image_202.png
117	14	http://localhost:9000/marketing/image_203.png
118	15	http://localhost:9000/marketing/image_204.png
119	16	http://localhost:9000/marketing/image_205.png
120	17	http://localhost:9000/marketing/image_206.png
121	18	http://localhost:9000/marketing/image_207.png
122	19	http://localhost:9000/marketing/image_208.png
123	20	http://localhost:9000/marketing/image_209.jpeg
124	21	http://localhost:9000/marketing/image_21.jpeg
125	22	http://localhost:9000/marketing/image_210.jpeg
126	23	http://localhost:9000/marketing/image_211.png
127	24	http://localhost:9000/marketing/image_212.png
128	25	http://localhost:9000/marketing/image_213.jpeg
129	26	http://localhost:9000/marketing/image_214.jpeg
130	27	http://localhost:9000/marketing/image_215.png
131	28	http://localhost:9000/marketing/image_216.png
132	29	http://localhost:9000/marketing/image_217.png
133	30	http://localhost:9000/marketing/image_218.png
134	31	http://localhost:9000/marketing/image_219.png
135	32	http://localhost:9000/marketing/image_22.png
136	33	http://localhost:9000/marketing/image_220.png
137	34	http://localhost:9000/marketing/image_221.png
138	35	http://localhost:9000/marketing/image_222.jpeg
139	36	http://localhost:9000/marketing/image_223.png
140	37	http://localhost:9000/marketing/image_224.jpeg
141	38	http://localhost:9000/marketing/image_225.jpeg
142	39	http://localhost:9000/marketing/image_226.png
143	40	http://localhost:9000/marketing/image_227.png
144	41	http://localhost:9000/marketing/image_228.png
145	42	http://localhost:9000/marketing/image_229.png
146	43	http://localhost:9000/marketing/image_23.jpeg
147	44	http://localhost:9000/marketing/image_230.png
148	45	http://localhost:9000/marketing/image_231.jpeg
149	46	http://localhost:9000/marketing/image_232.png
150	47	http://localhost:9000/marketing/image_233.png
151	48	http://localhost:9000/marketing/image_234.png
152	49	http://localhost:9000/marketing/image_235.png
153	50	http://localhost:9000/marketing/image_236.png
154	51	http://localhost:9000/marketing/image_237.jpeg
155	52	http://localhost:9000/marketing/image_238.jpeg
156	53	http://localhost:9000/marketing/image_239.png
157	54	http://localhost:9000/marketing/image_24.png
158	55	http://localhost:9000/marketing/image_240.png
159	56	http://localhost:9000/marketing/image_241.jpeg
160	57	http://localhost:9000/marketing/image_242.jpeg
161	58	http://localhost:9000/marketing/image_243.png
162	59	http://localhost:9000/marketing/image_244.png
163	60	http://localhost:9000/marketing/image_245.png
164	61	http://localhost:9000/marketing/image_246.png
165	62	http://localhost:9000/marketing/image_247.jpeg
166	63	http://localhost:9000/marketing/image_248.png
167	64	http://localhost:9000/marketing/image_249.png
168	65	http://localhost:9000/marketing/image_25.png
169	66	http://localhost:9000/marketing/image_250.png
170	67	http://localhost:9000/marketing/image_251.png
171	68	http://localhost:9000/marketing/image_252.png
172	69	http://localhost:9000/marketing/image_253.jpeg
173	70	http://localhost:9000/marketing/image_254.png
174	71	http://localhost:9000/marketing/image_255.jpeg
175	72	http://localhost:9000/marketing/image_26.png
176	73	http://localhost:9000/marketing/image_27.png
177	74	http://localhost:9000/marketing/image_28.png
178	75	http://localhost:9000/marketing/image_29.png
179	76	http://localhost:9000/marketing/image_3.png
180	77	http://localhost:9000/marketing/image_30.jpeg
181	78	http://localhost:9000/marketing/image_31.png
182	79	http://localhost:9000/marketing/image_32.png
183	80	http://localhost:9000/marketing/image_33.jpeg
184	81	http://localhost:9000/marketing/image_34.png
185	82	http://localhost:9000/marketing/image_35.jpeg
186	83	http://localhost:9000/marketing/image_36.jpeg
187	84	http://localhost:9000/marketing/image_37.jpeg
188	85	http://localhost:9000/marketing/image_38.png
189	86	http://localhost:9000/marketing/image_39.png
190	87	http://localhost:9000/marketing/image_4.jpeg
191	88	http://localhost:9000/marketing/image_40.jpeg
192	89	http://localhost:9000/marketing/image_41.jpeg
193	90	http://localhost:9000/marketing/image_42.jpeg
194	91	http://localhost:9000/marketing/image_43.png
195	92	http://localhost:9000/marketing/image_44.png
196	93	http://localhost:9000/marketing/image_45.png
197	94	http://localhost:9000/marketing/image_46.png
198	95	http://localhost:9000/marketing/image_47.jpeg
199	96	http://localhost:9000/marketing/image_48.png
200	97	http://localhost:9000/marketing/image_49.jpeg
201	98	http://localhost:9000/marketing/image_5.png
202	99	http://localhost:9000/marketing/image_50.png
203	100	http://localhost:9000/marketing/image_51.png
204	101	http://localhost:9000/marketing/image_52.png
205	102	http://localhost:9000/marketing/image_53.jpeg
206	103	http://localhost:9000/marketing/image_54.png
207	1	http://localhost:9000/marketing/image_55.png
208	2	http://localhost:9000/marketing/image_56.png
209	3	http://localhost:9000/marketing/image_57.jpeg
210	4	http://localhost:9000/marketing/image_58.jpeg
211	5	http://localhost:9000/marketing/image_59.png
212	6	http://localhost:9000/marketing/image_6.png
213	7	http://localhost:9000/marketing/image_60.jpeg
214	8	http://localhost:9000/marketing/image_61.png
215	9	http://localhost:9000/marketing/image_62.png
216	10	http://localhost:9000/marketing/image_63.png
217	11	http://localhost:9000/marketing/image_64.jpeg
218	12	http://localhost:9000/marketing/image_65.jpeg
219	13	http://localhost:9000/marketing/image_66.jpeg
220	14	http://localhost:9000/marketing/image_67.jpeg
221	15	http://localhost:9000/marketing/image_68.png
222	16	http://localhost:9000/marketing/image_69.jpeg
223	17	http://localhost:9000/marketing/image_7.jpeg
224	18	http://localhost:9000/marketing/image_70.jpeg
225	19	http://localhost:9000/marketing/image_71.png
226	20	http://localhost:9000/marketing/image_72.png
227	21	http://localhost:9000/marketing/image_73.jpeg
228	22	http://localhost:9000/marketing/image_74.png
229	23	http://localhost:9000/marketing/image_75.png
230	24	http://localhost:9000/marketing/image_76.jpeg
231	25	http://localhost:9000/marketing/image_77.jpeg
232	26	http://localhost:9000/marketing/image_78.png
233	27	http://localhost:9000/marketing/image_79.png
234	28	http://localhost:9000/marketing/image_8.jpeg
235	29	http://localhost:9000/marketing/image_80.png
236	30	http://localhost:9000/marketing/image_81.png
237	31	http://localhost:9000/marketing/image_82.png
238	32	http://localhost:9000/marketing/image_83.png
239	33	http://localhost:9000/marketing/image_84.png
240	34	http://localhost:9000/marketing/image_85.jpeg
241	35	http://localhost:9000/marketing/image_86.png
242	36	http://localhost:9000/marketing/image_87.png
243	37	http://localhost:9000/marketing/image_88.jpeg
244	38	http://localhost:9000/marketing/image_89.png
245	39	http://localhost:9000/marketing/image_9.png
246	40	http://localhost:9000/marketing/image_90.png
247	41	http://localhost:9000/marketing/image_91.png
248	42	http://localhost:9000/marketing/image_92.png
249	43	http://localhost:9000/marketing/image_93.png
250	44	http://localhost:9000/marketing/image_94.png
251	45	http://localhost:9000/marketing/image_95.png
252	46	http://localhost:9000/marketing/image_96.png
253	47	http://localhost:9000/marketing/image_97.jpeg
254	48	http://localhost:9000/marketing/image_98.png
255	49	http://localhost:9000/marketing/image_99.jpeg
\.


--
-- Data for Name: external_trends; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.external_trends (id, source_type, content_summary, recorded_at) FROM stdin;
\.


--
-- Data for Name: holiday_calendar; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.holiday_calendar (id, holiday_name, target_date, countdown_days) FROM stdin;
\.


--
-- Data for Name: ingredient; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ingredient (id, tenant_id, name) FROM stdin;
1	1	阿里山高山茶葉
2	1	玫瑰鹽
3	1	茉莉綠茶
4	1	芝士奶蓋
5	1	岩葉紅茶
6	1	香草冰淇淋
7	1	蘋果
8	1	百香果
9	1	四季春青茶
10	1	葡萄柚
11	1	柳橙
12	1	綠茶
13	1	寒天晶球
14	1	柚子
15	1	波霸珍珠
16	1	黑糖
17	1	鮮乳
18	1	烏龍茶
19	1	檸檬
20	1	芭樂
21	1	紅茶
22	1	翠玉茶葉
23	1	四季春茶葉
24	1	烏龍鐵觀音茶葉
25	1	冬瓜露
26	1	蜜桃風味紅茶葉
27	1	紅玉紅茶
28	1	高山烏龍茶葉
29	1	玫瑰風味糖漿
30	1	特選基底茶
31	1	青梅
32	1	翠玉綠茶
33	1	梅子
34	1	乳酸飲料
35	1	養樂多
36	1	高山青茶
37	1	仙草凍
38	1	黑糖波霸
39	1	奶茶
40	1	蒟蒻
41	1	珍珠
42	1	奶精/奶粉
43	1	錫蘭紅茶
44	1	重焙鐵觀音
45	1	鐵觀音烏龍茶
46	1	伯爵紅茶
47	1	蜜桃風味紅茶
48	1	巧克力醬/粉
49	1	粉粿
50	1	柚子醬
51	1	柳橙汁
52	1	碧螺春綠茶
53	1	芒果醬/果泥
54	1	芒果
55	1	椰果
56	1	百香果原汁
57	1	羅勒子
58	1	青茶
59	1	冬瓜茶
60	1	檸檬原汁
61	1	優格
62	1	榴槤
63	1	椰奶
64	1	蜜紅豆
65	1	鮮奶
66	1	英式伯爵茶
67	1	薑汁
68	1	桂圓紅棗醬
69	2	高山青茶
70	2	桂花
71	2	青茶
72	2	紅玉紅茶
73	2	綠茶
74	2	蕎麥茶
75	2	冬瓜糖漿
76	2	東方美人茶葉
77	2	金萱烏龍茶
78	2	鳳梨醬
79	2	玉露青茶
80	2	蘋果
81	2	甘蔗汁
82	2	冬瓜露
83	2	檸檬
84	2	檸檬汁
85	2	養樂多
86	2	桂花釀
87	2	柳橙汁
88	2	柳橙
89	2	酪梨泥
90	2	鮮奶油
91	2	酪梨
92	2	牛奶/奶粉
93	2	烏龍茶
94	2	冬瓜茶
95	2	玉露綠茶
96	2	鮮奶
97	2	桂花糖漿
98	2	奶精/奶粉
99	2	紅茶
100	2	奶精/鮮奶
101	2	鐵觀音茶
102	2	翡翠綠茶
103	2	鮮乳
104	2	珍珠
105	2	蕎麥茶凍
106	2	烤糖
107	2	奶精/鮮乳
108	2	珈琲粉粿
109	2	咖啡粉粿
110	2	仙草凍
111	2	鮮奶/奶精
112	2	翡翠青茶
113	2	草莓奶蓋
114	2	優格
115	2	草莓
116	2	蕎麥
117	3	紅烏龍茶
118	3	莓果調味
119	3	奶精
120	3	鮮奶
121	3	芝士奶蓋
122	3	紅茶
123	3	綠茶
124	3	烏龍茶
125	3	奶精/奶粉
126	3	焙烏龍茶
127	3	珍珠
128	3	焙茶粉
129	3	檸檬
130	3	檸檬汁
131	3	春烏龍茶
132	3	柳橙
133	3	柳橙汁
134	3	甘蔗汁
135	3	青梅
136	3	梅子
137	3	可爾必思發酵乳
138	3	葡萄柚
139	3	柚子
140	3	日本柚
141	3	春烏龍
142	3	焙烏龍
143	3	阿華田麥芽飲
144	4	太妃糖糖漿
145	4	蜜桃香料
146	4	斯里蘭卡紅茶
147	4	厚奶霜
148	4	英式伯爵茶
149	4	錫蘭紅茶
150	4	蜜桃錫蘭紅茶
151	4	鮮奶
152	4	奶精/奶粉
153	4	伯爵紅茶
154	4	玫瑰花瓣
155	4	柳橙
156	4	百香果
157	4	鳳梨
158	4	四季春茶
159	4	麥子
160	4	穀物
161	4	奶蓋
162	4	佛手柑精油
163	4	冬瓜露
164	4	糯米
165	4	烏龍茶
166	4	茉莉花
167	4	綠茶
168	4	梔子花
169	4	穀麥茶
170	4	奶粉
171	4	巧克力
172	4	糯烏龍茶
173	4	蜂蜜
174	4	珍珠
175	5	奶精
176	5	杏仁粉
177	5	鮮奶
178	5	可可粉
179	5	龍眼
180	5	桂圓糖漿
181	5	黑糖
182	5	薑母
183	5	奶精/奶粉
184	5	綠茶
185	5	烏龍茶
186	5	紅茶
187	5	青茶
188	5	普洱茶
189	5	冬瓜露
190	5	檸檬
191	5	檸檬汁
192	5	百香果糖漿
193	5	珍珠
194	5	椰果
195	5	錫蘭紅茶
196	5	水蜜桃醬
197	5	水蜜桃
198	5	茉綠茶凍
199	5	話梅
200	5	梅子
201	5	蜂蜜
202	5	咖啡粉
203	5	荔枝果漿
204	5	蜂蜜蘆薈
205	5	金桔汁
206	5	金桔
207	5	柳橙
208	5	柳橙汁
209	5	甘蔗汁
210	5	鳳梨
211	5	鳳梨醬
212	5	芝麻粉
213	5	仙草凍
214	5	綠茶凍
215	5	鮮乳
216	5	草莓
217	5	草莓醬
218	5	烏龍綠茶
219	5	布丁
220	5	咖啡凍
221	5	清心優多
222	5	紅心芭樂
223	5	紅心芭樂汁
224	5	草莓糖漿
225	5	蘋果醋
226	5	藍莓醋
227	5	荔枝糖漿
228	5	Red Bull 能量飲料
229	5	Red Bull 葡萄風味能量飲料
230	6	蕎麥茶
231	6	桂花糖漿
232	6	盧哈娜紅茶
233	6	鮮奶
234	6	仙草凍
235	6	茉莉綠茶
236	6	芋頭泥
237	6	焙茶
238	6	玄米粒
239	6	八女抹茶
240	6	青梅露
241	6	檸檬汁
242	6	柚子
243	6	柚子醬
244	6	養樂多
245	6	檸檬
246	6	檸檬皮
247	6	柳丁汁
248	6	柳丁
249	6	青茶
250	6	蜂蜜
251	6	綠茶凍
252	6	珍珠
253	6	黑糖
254	6	可可粉
255	6	玄米抹茶
256	6	冬瓜露
257	6	大麥茶
258	6	決明子
259	6	決明子大麥茶
260	6	檸檬原汁
261	7	四季春茶
262	7	阿薩姆紅茶
263	7	大麥
264	7	煎茶
265	7	蜂蜜
266	7	百香果香料
267	7	高山烏龍茶
268	7	芒果香料
269	7	綠茶
270	7	烏龍茶
271	7	碧螺春
272	7	蔗糖液
273	7	金萱烏龍茶湯
274	7	紅茶
275	7	鐵觀音茶葉
276	7	玫瑰花香料
277	7	普洱茶
278	7	白桃調味液
279	7	桂花釀
280	7	奶精粉
281	7	小葉紅茶
282	7	新式奶精粉
283	7	大麥紅茶
284	7	紅蔗糖與蔗糖液
285	7	蜂蜜香氣
286	7	奶精
287	7	日本靜岡煎茶
288	7	熱帶水果香
289	7	蘭花香
290	7	四季春
291	7	玫瑰花瓣
292	7	奶精/奶粉
293	7	茉莉烏龍茶
294	7	鐵觀音烏龍
295	7	黑糖
296	7	鮮乳
297	7	烏瓦紅茶
298	7	鮮奶
299	7	玫瑰普洱茶
300	7	金萱茶
301	7	珍珠
302	7	粉條
303	7	芋圓x薯圓
304	7	錫蘭紅茶
305	7	波霸/珍珠
306	7	仙草
307	7	桂花蜜
308	7	淡奶（蒸發乳）
309	7	可可粉
310	7	抹茶粉
311	7	話梅
312	7	梅子
313	7	檸檬
314	7	荔枝
315	7	茉莉綠茶
316	7	荔枝果露
317	7	養樂多
318	7	百香果汁
319	7	百香果
320	7	椰果
321	7	蘋果風味糖漿
322	7	寒天
323	7	檸檬汁
324	7	鳳梨
325	7	鳳梨汁
326	7	芭樂汁
327	7	芭樂
328	7	金桔原汁
329	7	化應子（台灣甲仙話梅）
330	7	金桔
331	7	蘆薈
332	7	荔枝凍
333	7	玫瑰果露
334	7	愛玉
335	7	桔子汁
336	7	小紫蘇
337	7	葡萄柚
338	7	紅棗
339	7	桂圓
340	7	薑汁
341	7	紫米
342	7	可可/巧克力
343	8	紅茶
344	8	綠茶
345	8	青茶
346	8	金萱
347	8	烏龍茶
348	8	普洱茶
349	8	紅葡萄柚果肉
350	8	葡萄柚
351	8	百香果
352	8	檸檬
353	8	檸檬汁
354	8	柳橙
355	8	柳丁汁
356	8	蘋果濃縮汁
357	8	蘋果
358	8	蜜桃果肉
359	8	水蜜桃
360	8	楊桃汁
361	8	楊桃
362	8	楊桃蜜
363	8	冬瓜茶
364	8	甘蔗原汁
365	8	豆漿
366	8	鮮奶
367	8	冬瓜
368	8	可可粉
369	8	蜂蜜
370	8	四季春茶
371	8	蘆薈
372	8	奶精/奶粉
373	8	奶精粉
374	8	波霸/珍珠
375	8	薑汁
376	9	紅茶
377	9	綠茶
378	9	青茶
379	9	烏龍茶
380	9	檸檬
381	9	檸檬汁
382	9	梅醬
383	9	金桔汁
384	9	梅子醬
385	9	金桔
386	9	養樂多
387	9	鳳梨
388	9	鳳梨汁
389	9	柚子醬
390	9	柚子
391	9	麵茶粉
392	9	奶精/奶粉
393	9	鮮奶油
394	9	清查
395	9	奶精
396	9	可可粉
397	9	波霸
398	9	波霸/珍珠
399	9	珍珠
400	9	布丁
401	9	椰果
402	9	鮮奶
403	9	梅子
404	9	紅/綠/青/春茶
405	9	芒果醬
406	9	芒果
407	9	荔枝
408	9	荔枝醬
409	9	冰淇淋
410	10	咖啡濃縮液
411	10	鮮奶
412	10	珍珠
413	10	粉角
414	10	黑糖
415	10	波霸/珍珠
416	10	柚子
417	10	紅柚醬
418	10	檸檬
419	10	檸檬汁
420	10	檸檬片
421	10	椰子
422	10	生椰乳
423	10	柳丁片
424	10	柳丁汁
425	10	柳丁
426	10	玄米
427	10	六條大麥
428	10	薏仁
429	10	蕎麥
430	10	二條大麥
431	10	決明子
432	10	冬瓜露
433	10	仙草
434	10	鮮乳
435	10	綠茶
436	10	紅茶
437	10	青茶
438	10	焙茶
439	10	烏龍茶
440	10	仙草凍
441	10	糖水
442	10	椰果
443	10	蜜香凍
444	10	冬瓜
445	10	奇亞籽
446	10	金桔
447	10	話梅
448	10	金桔汁
449	10	梅子
450	10	芒果果露
451	10	芒果
452	10	百香果
453	10	葡萄柚
454	10	芒果醬
455	10	冬瓜茶
456	10	蕎麥茶
457	10	養樂多
458	10	草莓
459	10	蔓越莓
460	10	奶精/奶粉
461	10	布丁
462	10	擂茶
463	10	芋泥
464	10	芋泥；鮮奶
\.


--
-- Data for Name: marketing_content; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.marketing_content (id, store_id, platform, product_name, final_text, created_at, "Like") FROM stdin;
1	1	FB	黑霸烏龍奶	＼迎接假期！／限時 #買一送一 先開喝！\n\n年假即將來臨，忙碌中還是要懂得享受 ·͜·♡\n來杯「黑霸烏龍奶」提前進入𝐇𝐨𝐥𝐢𝐝𝐚𝐲 𝐌𝐨𝐝𝐞\n給準備放假的你，一個剛好的理由\n\n#限時優惠 𝟎𝟐.𝟎𝟗 - 𝟎𝟐.𝟏𝟑 ─── .✦.\n聯名限定．#黑霸烏龍奶 限時買❶送❶！\n烏龍奶茶暗藏火力，遇上波霸的甜蜜攻擊\n猶如出拳前的蓄勢待發！一口引爆烈焰\n\n假期來臨！就讓「黑霸烏龍奶」來開場！\n\n．活動限來店；每人限購2組。\n．本優惠不得與其他優惠併用。\n\n#電影 #功夫 #九把刀作品\n#0213全台盛大上映	2026-02-02 00:00:00	1216
2	1	FB	黑霸烏龍奶	電影的狠勁，都在 #黑霸烏龍奶 內！\n不張揚，卻很有立場 ────────.✦.\n\n九把刀執導並改編自同名小說🧨\n最擅長的熱血情感與逆襲快感\n揭開九把刀宇宙的華麗篇章 .ılı.lı.ıl\n\n把故事裝進手裡的「黑霸烏龍奶」\n燃起內心無限可能，登頂功夫之巔！\n\n一馬當先、霸氣開春！𝟎𝟐.𝟏𝟑戲院見🎞️\n\n#電影 #功夫 #九把刀作品\n#0213全台盛大上映	2026-01-21 00:00:00	38
3	1	FB	黑糖波霸秘煉𝟏𝟐𝟎分	黑糖波霸秘煉𝟏𝟐𝟎分，層層吸收黑糖精華\n與烏龍奶茶正面交鋒！沉穩茶香隨奶香釋放~\n焙香、奶香暗藏火力，濃烈不失細膩\n\n九把刀最強奇幻動作電影《功夫》\n配上用真功夫製作的「黑霸烏龍奶」\n聯手來場充滿力量的手搖體驗！\n\n𝟎𝟐.𝟏𝟑 - 𝟎𝟑.𝟎𝟖 ─.✦.───\n憑當月份《功夫》電影票根\n享「黑霸烏龍奶」#現折10元優惠 ◡̎\n\n𝟎𝟐.𝟎𝟗 - 𝟎𝟐.𝟏𝟑 ─.✦.───\n購買「黑霸烏龍奶」即享 #買1送1\n\n．每張票根限折乙杯。買一送一限購2組。\n．活動限來店；不得與其他優惠併用。\n\n#電影 #功夫 #九把刀作品\n#0213全台盛大上映	2026-01-16 00:00:00	35
4	1	FB	蜜桃胭脂紅茶	即將迎來新年第一天，好心情一起打包◡̎\n\n𝟐𝟎𝟐𝟔.𝟎𝟏.𝟎𝟏 #元旦限定 —————\n▹ ▸ 蜜桃胭脂紅茶〔買一送一〕.ᐟ\n\n#蜜桃胭脂紅茶𝐏𝐞𝐚𝐜𝐡 𝐁𝐥𝐚𝐜𝐤 𝐓𝐞𝐚\n桃香與茶香完美並存的單品紅茶\n淡淡香氣有如剛摘下的蜜桃，沿途留香\n\n新的一年，一起舉杯歡慶\n感受到茶香細膩，輕盈清爽～\n\n．每人限購乙組。活動限來店\n．優惠不得合併使用。數量有限售完為止\n\n#元旦 #新年快樂 #HappyNewYear	2025-12-31 00:00:00	570
5	1	FB	雙饗茶會	＼聖誕節快樂！／𝐌𝐞𝐫𝐫𝐲 𝐂𝐡𝐫𝐢𝐬𝐭𝐦𝐚𝐬 🎄🔔\n\n濃濃的聖誕氛圍，剛剛好就很溫暖！\n用一杯柔順的拿鐵，還有一杯清爽的茶，\n將忙碌拋在腦後，把美好留給自己吧◡̎\n\n#雙饗茶會 ❭❭❭  𝐓𝐄𝐀+𝐋𝐀𝐓𝐓𝐄 享組合優惠✨\n讓冬天過得更溫暖，以茶相聚，歡慶聖誕！\n\n．活動不得與其他優惠合併使用\n\n#KUNGFUTEA功夫茶 #功夫茶 ＃雙饗茶會	2025-12-24 00:00:00	16
6	1	FB	KUNGFUTEA功夫茶	氣溫急速下降，早晚溫差大 ❆\n回家路上，迎面而來的冷風 🌬️\n身體忍不住顫抖，寒意包裹全身\n\n來杯熱飲，身體立刻暖起來\n讓疲憊和寒意一起消散 ❤️‍🔥\n\n回家路上喝拿鐵，暖身也暖心\n到家喝原茶配上豐盛的晚餐 🥃\n雙重享受，迎接美好的夜晚 ෆ\n\n✧𝟏𝟏.𝟎𝟏-𝟎𝟏.𝟏𝟏｜雙饗茶會 組合優惠價✧\n𝐏𝐚𝐢𝐫 + 𝐒𝐡𝐚𝐫𝐞，各選一杯，幸福加倍\n\n※活動限來店、自取、外送、享什麼\n※活動不得與其他優惠併用\n\n#KUNGFUTEA功夫茶 #功夫茶 #雙響茶會	2025-11-24 00:00:00	27
7	1	FB	岩葉紅茶拿鐵	不同風味的飲料，代表不同的心情 ◡̎\n幫你找到最適合今日心情的組合 .ᐟ\n\n❣️𝟏𝟏.𝟎𝟏-𝟎𝟏.𝟏𝟏｜雙饗茶會❣️\n𝐏𝐚𝐢𝐫 + 𝐒𝐡𝐚𝐫𝐞，各選一杯，享優惠價\n\n𝐏𝐚𝐢𝐫 ｜原境茶選\n𝐒𝐡𝐚𝐫𝐞｜醇厚拿鐵\n岩葉紅茶拿鐵 ꕤ 烏龍觀音拿鐵 ꕤ 蜜桃胭脂拿鐵\n\n꒰ 隱山烏龍 × 烏龍觀音拿鐵 ꒱\n最適合想要獨處、沉澱心情的你\n沉穩安定的茶香，忙碌後優雅慢下腳步\n\n最適合缺乏活力、急需朋友慰藉的你\n與好友暢聊、釋放壞情緒的最佳能量飲品\n\n#隱山烏龍 #雙饗茶會 #優惠活動	2025-11-06 00:00:00	32
8	1	FB	38奶霸	萬聖節就喝這杯，不喝就搗蛋 .ᐟ.ᐟ\n𝑻𝒐𝒑 𝑷𝒊𝒄𝒌 ✧ 38 奶霸 ✧ 超有料\n\n最黑的夜空揉成焦糖圓球 𖣐\n點綴上晶瑩寶石、黑夜濃霧\n喝一口，幸福感爆棚，超滿足 ෆ\n\n 𝓗𝓐𝓟𝓟𝓨  𝓗𝓐𝓛𝓛𝓞𝓦𝓔𝓔𝓝 \n꒦꒷꒦꒷꒦꒷꒦꒷꒦꒷꒦꒷꒦꒷꒦꒷꒦꒷꒦꒷꒦꒷꒦꒷\n\n#KUNGFUTEA功夫茶 #功夫茶 #萬聖節	2025-10-30 00:00:00	30
9	1	FB	隱山烏龍	連假出遊，熱到快融化\n真想來杯沁涼解渴的飲料 .ᐟ\n\n꒰ 隱山烏龍 ꒱ 𝓷𝓮𝔀\n茶香四溢，順口不苦澀\n冰涼清爽，一掃身體的燥熱 ❆\n無糖限定，感受最純粹的茶香♡\n\n隱山烏龍・沁涼上市\n是你連假出遊的最佳夥伴 ✧˚.\n\n#隱山烏龍 #無糖茶 #國慶日	2025-10-09 00:00:00	406
10	1	FB	隱山烏龍	中秋節快樂𓂃⟡.·𓂃\n吃柚子、嚐月餅、烤肉一口接一口\n團員聚會好熱鬧，親朋好友共度好時光 ✦\n\n來一杯  隱山烏龍 𝒏𝒆𝒘\n回甘不苦澀，入喉沁涼解渴\n無糖限定，讓你喝得安心無負擔\n\n團圓賞月，舉杯歡聚\n清爽過中秋，就選隱山烏龍！\n\n#隱山烏龍 #中秋節快樂 #無糖也好喝	2025-10-04 00:00:00	21
11	2	FB	柳橙翡翠青	#柳橙翡翠青 #經典回歸\n剛剛好，你也還在\n剛剛好，我也沒變\n我們一起等到——\n柳橙最剛好的時刻\n這不是提早，也不是將就\n而是等到果香最飽滿、酸甜最平衡\n才願意端出的那一杯\n這份陽光下的鮮甜美好\n是去年度季節限定 No.1 的回憶\n也是今年，終於等到的完美風味\n我們再一次，回味重遊\n柳橙翡翠青\n1/26（一）全台經典回歸上市\n嚴選鮮甜柳橙\n搭配沁涼爽口的翡翠青茶\n在柳橙最佳成熟時刻榨取\n完整保留果香層次與清爽茶韻\n年度好評敲碗回歸 !\n｜大茗官方網站｜https://www.damingtea.com.tw\n#大茗本位製茶堂 #柳橙翡翠青經典回歸	2026-01-23 00:00:00	76
12	2	FB	懷舊經典奶茶	#\n#啟動年末微醺儀式 #莓醉雙奏章幸福聯乘\n#勤美誠品綠園道限定 #聯名酒精飲特調\n草莓飲品喝不夠要再來點Chill的嗎\n我們從上波爵士音樂節的茶酒特調再次昇華\n這波莓醉的幸福耶誕禮，明日起限定開喝\nDAMING X Teapsy 丨 莓醉雙奏章\n12/24(三) - 12/31(三) 限時8天\n⭓ 莓醉玉露 / 4% vol. / ★★★★★\n(玉露奶青/草莓果釀/原萃青茶茶酒)\n細緻奶青交織甜蜜草莓果香\n滿滿草莓奶酒的微醺清甜\n⭓ 莓醺奶紅 / 4% vol. / ★★★★★\n(懷舊經典奶茶/草莓果釀/原萃紅茶茶酒)\n濃郁的古早味奶紅配上草莓甜酸\n溫潤迷人～莓醉又回味的Chill\n/ / /\n* 未滿18歲禁止飲酒\n* 喝酒不開車，安全有保障\n大茗本位製茶堂丨勤美誠品綠園道店\n地址：台中市西區公益路68號B1\n電話：04-2321-0823\n｜大茗官方網站｜https://www.damingtea.com.tw\n莓醉雙奏章 丨 限定聯名酒精飲特調\n@daming_tea @teapsyco_official	2025-12-23 00:00:00	60
13	2	FB	大茗本位製茶堂	#莓光甜室\nSweet Berry Moments\n12/10(三)全台新品上市\n讓每一天，\n都有一點柔軟的甜。\n融進口裡，收在心裡\n｜大茗官方網站｜https://www.damingtea.com.tw\n#草莓要來了 #就是下周\n#大茗本位製茶堂	2025-12-02 00:00:00	309
14	2	FB	芒果青	#芒果青 #青熟感限定茗作\n熱烈加開！熱烈加開！\n這杯獻給你，用芒果的酸甜填滿日常的空隙。\n喝過才知道，大茗的味道真的上癮\n在地芒果細火慢熬出的天然熟果香，\n喝過的都驚嘆 限量開賣再擴大開催～～\n手工芒果醬 ✕ 翡翠青茶\n11/14(五)起 中區、彰化、嘉義、斗六門市限量開喝！\n｜大茗官方網站｜https://www.damingtea.com.tw/\n#芒果青 #指定區域門市開喝\n#大茗本位製茶堂	2025-11-11 00:00:00	11
15	2	FB	芫荽酪梨奶蓋	這個萬聖節，不搞怪也能很有戲\n芫荽與酪梨攜手施展綠色魔法，三款奶蓋茶限時登場，\n每一口都是萬聖夜的神秘咒語——清香、焙香、還有一點暗夜的驚喜\n萬聖限定・芫荽酪梨奶蓋系列\n2025/10/31-11/2\n綠茶｜清新登場\n清爽綠茶遇上芫荽酪梨奶蓋，淡雅香氣裡帶點意外驚喜\n蕎麥｜焙香現身\n焙香蕎麥融合草本奶蓋的柔滑，香氣溫潤，喝起來很舒服\n烏龍｜暗夜限定\n炭焙茶香交織酪梨奶香，層次豐富又細膩\n每日限量供應\n限現場購買\n可先來電門市詢問\n｜大茗官方網站｜https://www.damingtea.com.tw/\n#大茗新品上市 #萬聖節限定 #芫荽酪梨奶蓋\n#大茗本位製茶堂	2025-10-28 00:00:00	227
16	2	FB	芒果青	#芒果青 #青熟感限定茗作\n#北區南區第二波指定門市開喝🤩\n熱烈加開！熱烈加開！🎉🎉\n這杯獻給你，也許你心裡的洞能被填滿一點？\n大茗你就愛了吧！哪次不愛🫰\n在地芒果細火慢熬出的天然熟果香\n喝過的都驚嘆🔥第二波指定店限量販售開催～～\n📍手工芒果醬 ✕ 翡翠青茶\n📍10/23(四)起第二波區域門市限量開喝\n📍指定販售門市\n👉北區指定門市\n台北公館 / 台北內湖 / 桃園藝文\n新竹城隍 / 新竹金山 / 竹南博愛\n👉中區指定門市\n勤美模範 / 台中高工 / 台中水湳\n逢甲西屯 / 逢甲福星 / 漢口青海\n* 11/14(五)起中區全門市供應\n👉南區指定門市\n台南中正 / 台南中華\n高雄至聖 / 高雄自強 / 高雄裕誠\n高雄文化 / 高雄楠梓 / 高雄岡山\n｜大茗官方網站｜https://www.damingtea.com.tw/\n#芒果青 #第二波指定區域門市開喝\n#大茗本位製茶堂	2025-10-22 00:00:00	14
17	2	FB	大茗本位製茶	雙十快樂，一起乾杯吧！\n十月的陽光有點甜，\n十月的風也帶著好心情～\n在這充滿喜慶的日子裡，\n不妨停下腳步，來杯好茶放鬆一下\n我們國慶日不打烊\n手搖好茶隨時待命，\n無論是沁涼鮮果、濃郁奶香，\n都讓幸福在舌尖綻放\n秋意漸濃，早晚記得加件外套，\n祝大家都能度過溫馨的雙十連假～\n｜大茗官方網站｜https://www.damingtea.com.tw/\n#大茗本位製茶 #雙十節快樂	2025-10-10 00:00:00	22
18	2	FB	珈琲粉粿蕎麥奶	✨DAMING | Happy Moon Festival🌕🎑\n中秋烤肉聚餐，解膩神隊友必不可少🔥\n#玉露青茶 —— 清爽解膩、涼意滿滿\n#熟成油切蕎麥 —— 助你油膩OUT、暢快加倍\n想換換口味也可以點\n#珈琲粉粿蕎麥奶 —— 一口濃郁烘焙香氣，一口滑順溫柔的老派浪漫。\n\n#珍珠粉粿牛奶 ——珍珠＋粉粿＝雙重咬感爆擊！雙料大滿足\n\n聚會來上一杯，中秋就更圓滿。\n㊗️大家中秋節快樂🌝🎉\n｜大茗官方網站｜https://www.damingtea.com.tw/\n\n#大茗本位製茶堂 #中秋節快樂	2025-10-05 00:00:00	17
19	2	FB	芒果青	細火慢熬，以手作果醬入茶\n#芒果青 #青熟感限定茗作\n#台中首波指定門市上車囉👏\n嚴選台灣在地芒果，手作慢熬釋放天然果香，\n以黃金比例入茗翡翠青，果香與茶韻完美交織。\n清爽回甘、果甜不膩\n📍青熟感限定茗作 手工芒果醬✕翡翠茶\n📍9/19(五)起指定區域首波限量開喝\n📍指定販售門市\n勤美模範 / 台中高工\n台中水湳 / 逢甲西屯\n逢甲福星 / 台中大雅\n漢口青海 / 勤美誠品\n嘉義民族\n｜大茗官方網站｜https://www.damingtea.com.tw/\n#大茗新品上市 #芒果青\n#大茗本位製茶 #台中首波上市\nv	2025-09-17 00:00:00	39
20	2	FB	珈琲粉粿蕎麥奶	#七夕\n用一杯飲料，說盡我想對你說的情話\n\n#珈琲粉粿蕎麥奶\n牛郎織女一年見一次，\n我要的是和你天天共享一杯老派的浪漫。\n\n#珍珠粉粿牛奶\n你是珍珠，我是粉粿，\n我們加在一起就是最對味的愛情。\n\n今年七夕，就用Ｑ彈的「 老派浪漫」告白，\n𝘁𝗮𝗴 你最想共享一杯的他/她 ♡\n\n\n#七夕 #七夕情人節 #老派靈魂新派味道\n#大茗新品 #珈琲粉粿蕎麥奶 #珍珠粉粿牛奶\n#大茗本位製茶堂 #新品上市	2025-08-29 00:00:00	10
21	3	FB	芝士奶蓋緋烏龍	身處湧動時代📀復古卻成了新語言\n偕茶師重新對焦\n#緋烏龍系列 再次加載登場！\n全新風味升級：首次加入緋烏龍、馥莓緋烏龍🫐\n在新與舊之間\n注入靈魂播放昔日回憶\n緋紅序曲已揭幕\n邀你舉杯，共襄年末盛宴🪩✨\n.\n> .collection - "𝓡ed Oolong Tea 緋烏龍系列"\n[0]  緋烏龍........................M 35｜L 40\n[1]  馥莓緋烏龍................M 50｜L 60\n[2]  緋烏龍奶茶................M 50｜L 55\n[3]  緋烏龍鮮奶................M 60｜L 70\n[4]  芝士奶蓋緋烏龍........M 55｜L 65\nSTATUS: 全門市販售中	2025-12-17 00:00:00	50
22	3	FB	芝士奶蓋緋烏龍	𝑪𝒉𝒂𝒑𝒕𝒆𝒓 𝟎𝟒｜芝士奶蓋緋烏龍  Cheese Milk Foam 𝓡ed Oolong Tea\n收音機嗡嗡作響\n戴上耳機隔出一片自在zone\n音符在空氣跳躍\n鹹香芝士奶蓋\n佐緋烏龍獨有熟果前調及蜜香喉韻\n滋味醇厚、回甘悠長\nVolume up ! 𝓡eloading on 𝟏𝟐/𝟏𝟕 （﹙˓ 🎧˒﹚）	2025-12-12 00:00:00	49
23	3	FB	緋烏龍鮮奶	𝑪𝒉𝒂𝒑𝒕𝒆𝒓 𝟎𝟑｜緋烏龍鮮奶 𝓡ed Oolong Tea Latte\n調整焦距，緋紅身影漸漸清晰\n熟果基調揉合烏龍韻\n奶香柔潤細膩\n覆蓋舌尖\n每口都是風味的細膩映像\n帶著去年的悸動\n回憶幀幀重現，逐格展開\nKeep rolling ! 𝓡eloading on 𝟏𝟐/𝟏𝟕	2025-12-11 00:00:00	73
24	3	FB	馥莓緋烏龍	𝑪𝒉𝒂𝒑𝒕𝒆𝒓 𝟎𝟐｜馥莓緋烏龍 Berrys 𝓡ed Oolong Tea\n循電波傳遞酸甜訊號💓▶• ılıılıılılıılıılı. 0\n紫桑率先登場\n緋烏龍沉靜其後，釋放熟果木質溫潤\n再以覆盆子微酸收束\n莓緋色澤\n內斂卻蘊藏深意\n以嫣紅映照明媚冬日與土地回甘\nDon’t hang up! 𝓡eloading on 𝟏𝟐/𝟏𝟕 📆	2025-12-10 00:00:00	77
25	3	FB	緋烏龍	𝑪𝒉𝒂𝒑𝒕𝒆𝒓 𝟎𝟏｜緋烏龍 𝓡ed Oolong Tea\n指尖穿梭光影翩然敲打，緋紅色溫於膠卷顯影🎞️\n#緋烏龍 ｛ 𝖿ē𝗂 𝗐𝗎𝗅ó𝗇𝗀｝ 選用台東紅烏龍，以夏秋茶葉為本結合紅茶加工特點，採重發酵製成，果韻滋味明亮飽滿。\n因水色呈現橙紅色澤而得名，一入口就能感受熟果及木質圓潤香氣，風味甘甜且喉韻悠長，紅韻入杯紅玉香、烏龍韻，香氣縈繞層次分明。\n今年！原茶款首次加入，風味純粹卻足以撩動心弦 𝓡eloading on 𝟏𝟐/𝟏𝟕 📆	2025-12-09 00:00:00	58
26	3	FB	青檸甘蔗蕎麥綠寶	月夕初見，跨越世代的相聚🌔\n在舉杯之間\n分享澄黃如月的酸甜滋味\n🍋‍🟩青檸甘蔗蕎麥綠寶 Lemon with Cane Green Rooibos Tea\n甘蔗汁佐青檬，平衡中秋的豐盛味蕾\n#無咖啡因 在月夜輕柔裡\n大人孩童安心共飲\n𝗢𝗥𝗗𝗘𝗥 ➡︎ https://lihi.cc/QvWof/預約外送自取	2025-10-03 00:00:00	50
27	3	FB	一畝蕎麥田	一畝蕎麥田，掬起穗香與青草香\n蕎麥為引，綠國寶茶基底\n初飲入喉是自然麥香\n伴隨穀物焙炒的濃郁\n深淺流轉，隨穗浪輕伏\n在漸入回甘之際\n漫出綠國寶茶的大地青草香\n喉韻清香淡雅，悠香不息\n蕎麥綠寶 𝘎𝘳𝘦𝘦𝘯 𝘙𝘰𝘰𝘪𝘣𝘰𝘴 𝘛𝘦𝘢 𝘚𝘦𝘳𝘪𝘦𝘴\n金粹·馥莓·青檸甘蔗 ⟢全門市販售中	2025-09-18 00:00:00	173
28	3	FB	碧綠金澄	更迭沉潛，大地悄悄甦醒\n陽光鋪展金光覆滿田野、碧綠金澄\n化身不同花色地毯\n✦\n𝘎𝘳𝘦𝘦𝘯 𝘙𝘰𝘰𝘪𝘣𝘰𝘴 𝘛𝘦𝘢 𝘚𝘦𝘳𝘪𝘦𝘴 蕎麥綠寶系列\n風味穀香淡雅、溫潤回甘\n8/27 清爽上市	2025-08-25 00:00:00	66
29	3	FB	蕎麥綠寶	全新零咖啡因飲\n8.27 (三) 全門市 𝘤𝘰𝘮𝘪𝘯𝘨 𝘴𝘰𝘰𝘯\n𝘎𝘳𝘦𝘦𝘯 𝘙𝘰𝘰𝘪𝘣𝘰𝘴 𝘛𝘦𝘢 𝘚𝘦𝘳𝘪𝘦𝘴 蕎麥綠寶系列\n✦\n喚醒盛夏氣息\n以青檸鮮榨原汁，融合甘蔗自然甜韻 .ᐟ\n酸沁於舌尖、口感明亮奔放\n推薦微微糖至半糖\n酸甜恰好\n青檸甘蔗蕎麥綠寶\nLemon with Cane Green Rooibos Tea\n𝙈 𝟳𝟱・𝙇 𝟴𝟱	2025-08-22 00:00:00	53
30	3	FB	莓果嫣紅	莓果嫣紅，酸甜恰如其分💫\n桑葚馥郁揭開序幕\n藍莓柔甜綻放\n覆盆子淡淡微酸輕盈收束\n揉合蕎麥綠國寶，果韻清亮莓香沁人\n馥莓蕎麥綠寶 Berrys Green Rooibos Tea\n𝙈 𝟱𝟱・𝙇 𝟲𝟱\n🌾\n✦ 零咖啡因系列 ✦\n蕎麥綠寶 𝘎𝘳𝘦𝘦𝘯 𝘙𝘰𝘰𝘪𝘣𝘰𝘴 𝘛𝘦𝘢 𝘚𝘦𝘳𝘪𝘦𝘴\n8.27 (三)  全台同步上市	2025-08-21 00:00:00	87
31	4	FB	新年喝好茶	新的一年，願每一步都奔向更好的風景。\n用一杯好茶，陪伴大家迎接嶄新的新年時刻。\n限量設計，只為今年的相遇，\n不只是喝茶，更是一份祝福、一份陪伴。\n願馬年——\n馬到成功 茶香常在 好運滿杯\n#先喝道 #馬年限定杯 #新年喝好茶 #馬到成功 #陪你走過每一個新開始 #把世界放在一杯茶中 #嚴選世界好茶 #TAOTAOTEA #精品茶 #ITQI得獎茶 #手搖飲 #手搖推薦 #古典玫瑰園 #下午茶時間	2026-02-10 00:00:00	37
32	4	FB	英式玫瑰特調茶	💝 2/13 情人節限定｜玫瑰系必喝 💝\nHAPPY FRIDAY｜𝟮/𝟭𝟯 情人節必喝  玫瑰限定    玫瑰水、英式玫瑰拿鐵 第二杯10元\n懂茶的人，最懂怎麼說愛。\n在玫瑰盛開的季節，\n用一杯花香，替情人節加點溫柔的儀式感。\n🌹 玫瑰水｜把浪漫喝進日常\n使用 先喝道自製玫瑰露調製，無人工甜味劑、無防腐劑，\n清透順口、輕柔不膩，細緻花香在舌尖停留，為日常增添浪漫。\n\n🫖 英式玫瑰拿鐵｜專屬午後的溫柔告白\n以斯里蘭卡莊園紅茶為基底，搭配米其林ITQI 2星認證絕佳風味好茶英式玫瑰特調茶，層層融入奶香與玫瑰香，溫潤柔和，完美午後茶時光必備。\n\n快揪朋友一起喝，讓玫瑰香點亮你的週五！✨\n\n⚠️活動注意事項⚠️\n𝟭.每人限購3組\n𝟮.限現場/你訂自取 (優惠活動不合併使用)\n𝟯.各門市數量有限，售完為止\n#先喝道 #把世界放在一杯茶中 #嚴選世界好茶 #TAOTAOTEA #精品茶 #ITQI得獎茶 #手搖飲 #手搖推薦 #古典玫瑰園 #下午茶時間	2026-02-08 00:00:00	267
33	4	FB	蜂蜜四季春茶	有些茶，不需要多說，\n一入口，就知道為什麼會被反覆點名。\n\n四季春茶王\n米其林級ITQI最高3星認證絕佳風味，第一口是清亮的茶湯，接著花香慢慢在口中散開，尾韻回甘，是一杯會讓人默默一直喝下去的經典。\n\n蜂蜜四季春茶\n清新的四季春茶香先到，隨後蜂蜜的溫潤甜感，柔和不膩，口感圓順，每一口都輕盈愉悅\n好茶獻給懂喝的人，全台先喝道，隨時享受。\n\n2/6限定｜四季春茶王第二杯半價、蜂蜜四季春茶第二杯10元\n\n活動注意事項\n𝟭.每人限購3組\n𝟮.限現場/你訂自取 (優惠活動不合併使用)\n𝟯.各門市數量有限，售完為止\n#先喝道#把世界放在一杯茶中#嚴選世界好茶#TAOTAOTEA#精品茶#ITQI得獎茶#手搖飲#手搖推薦#古典玫瑰園#下午茶時間	2026-02-04 00:00:00	36
34	4	FB	蜂蜜四季春茶	HAPPY FRIDAY｜四季春系列 (ITQI 3星得獎茶) 指定飲品優惠\n\n懂喝茶的人都知道，\n四季春的魅力，在那一口清爽花香與回甘之間。\n\n先喝道-四季春茶王(ITQI 3星得獎茶)\n選用台灣優質茶葉，茶湯清透、口感輕盈，\n自然花香在舌尖綻放，回甘乾淨不厚重，\n是一杯每天都喝不膩的經典好茶。\n\n蜂蜜四季春茶\n以四季春為基底，加入香甜蜂蜜，\n茶香依舊清爽，尾韻多了一抹溫潤甜感，清新柔和、順口耐喝。\n\n2/6限定｜四季春茶王第二杯半價、蜂蜜四季春茶第二杯10元\n\n活動注意事項\n𝟭.每人限購3組\n𝟮.限現場/你訂自取 (優惠活動不合併使用)\n𝟯.各門市數量有限，售完為止\n#先喝道 #把世界放在一杯茶中 #嚴選世界好茶 #TAOTAOTEA #精品茶 #ITQI得獎茶 #手搖飲 #手搖推薦 #古典玫瑰園 #下午茶時間	2026-02-01 00:00:00	620
35	4	FB	把世界放在一茶中	馬年到，好運轉起來！\n過年就是要有儀式感\n馬年新春限定杯正式上市啦！\n旋轉木馬的童趣設計，搭配奔馳的駿馬意象，\n象徵勇往直前、好運連連、事事馬到成功\n先喝道-新年換新杯，喝的每一口都是滿滿年味～\n不管是自己收藏，還是送禮，都超有儀式感\n馬年限定・數量有限\n拿在手上，年味直接拉滿\n#馬年 #新年新品 #先喝道 #把世界放在一杯茶中 #嚴選世界好茶\n#TAOTAO_TEA #精品茶 #ITQI得獎茶 #手搖飲 #手搖推薦 #古典玫瑰園 #下午茶時間 #新春必收 #過年就是要有儀式感	2026-01-31 00:00:00	26
36	4	FB	把世界放在一茶中	當世界太吵的時候，\n不妨慢下來，\n把世界放進一杯茶裡。\n\n輕焙榖麥茶——\n像是一封焙火寫給大地的情書。穀麥在低溫中慢慢甦醒，香氣不張揚，卻在杯中繾綣不散；入口是溫柔的穀香與淡淡烘焙甜，讓心也跟著安靜下來。\n\n榮獲\n**2024 比利時布魯塞爾 iTQi 美食評鑑「最佳風味好茶」得獎茶款。\n\n#先喝道 #把世界放在一杯茶中 #輕焙榖麥茶 #嚴選世界好茶 #iTQi得獎茶 #英式下午茶 #古典玫瑰園	2026-01-29 00:00:00	20
37	4	FB	英式玫瑰拿鐵	當午後的光線變得柔軟，就讓一杯花香，慢慢展開\n🌹玫瑰水\n清透順口、輕柔不膩，細緻的玫瑰香氣，\n在入口之間輕輕停留，芬芳綻放為日常增添浪漫。\n🫖英式玫瑰拿鐵\n在溫潤茶香中，玫瑰悄然綻放，\n與柔和奶香層層相融，完美的恰到好處。\n週五讓這份剛剛好的玫瑰風味伴隨茶香陪你一起迎接浪漫午茶時光\n🎁1/30限定｜玫瑰水第二杯半價、玫瑰拿鐵中杯(Ｍ)49元第二杯半價\n⚠️活動注意事項⚠️\n𝟭.每人限購3組\n𝟮.限現場/你訂自取 (優惠活動不合併使用)\n𝟯.各門市數量有限售完為止\n#先喝道 #TAOTAOTEA #手搖飲 #好茶 #米其林 #四季春茶王 #台灣四大名茶 #嚴選世界好茶 #英式下午茶 #英國茶 #台灣茶 #手搖推薦 #古典玫瑰園	2026-01-28 00:00:00	34
38	4	FB	好茶	睽違已久，金杯烏瓦系列1/17 日起驚喜回歸\n在那段消失的日子裡，我們收到了無數敲碗與想念。\n\n這一次，經典傳奇終於再次於 18 間門市期間限定復活。\n\n選用世界三大紅茶之一的斯里蘭卡烏瓦紅茶（Uva Tea）作為基底，來自知名烏瓦高地。 在優雅的香草清香中開場，隨後是沉穩的麥芽香氣入喉， 尾韻散發出甜美的柑橘芬芳，與細緻奶香交織出如絲綢般的溫潤。\n\n這一杯，是送給老朋友最溫暖的重逢禮，\n也誠摯邀請新朋友，與我們一起開啟這場層次豐富的味覺。\n\n如果你還沒試過這份傳奇味道，這次，請別再擦肩而過。\n\n回歸日期：\n1/17 (六) 起 ，全台18間門市限定販售，數量有限，售完為止\n\n販售門市：\n台南新營、嘉義興業、台南民族、梧棲文化、台中嶺東、台中大甲、台南新市、台中向心、新竹南大、台中潭子、沙鹿中山、龍井中央、林口長庚、北投石牌、桃園青埔、中科永福、屏東廣東、仁武京吉\n\n#先喝道 #TAOTAOTEA #手搖飲 #好茶 #米其林 #金杯烏瓦 #世界三大紅茶 #嚴選世界好茶 #英式下午茶 #英國茶 #台灣茶 #手搖推薦 #古典玫瑰園	2026-01-17 00:00:00	52
39	4	FB	太妃蜜桃風味厚奶霜	期間限定！消失的驚喜味道，1/17 日起限定回歸 🏆\n還記得那口驚艷味蕾、帶有迷人香草氣息的「金杯烏瓦系列」嗎？\n在無數粉絲的敲杯後，我們決定讓它期間門店限定復活了！\n選用世界三大紅茶之一的斯里蘭卡烏瓦紅茶（Uva Tea）作為基底，來自知名烏瓦高地。\n以優雅的香草清香揭開序幕，隨後濃厚的麥芽香氣沉穩入喉，\n尾韻透出甜美的柑橘風味，與細緻奶香交織，\n層層堆疊出香醇濃郁、溫潤不膩的經典茶韻。\n\n📅 回歸日期：\n1/17 (六) 起 ，全台18間門市限定販售，數量有限，售完為止\n📍 販售門市：\n台南新營、嘉義興業、台南民族、梧棲文化、台中嶺東、台中大甲、台南新市、台中向心、新竹南大、台中潭子、沙鹿中山、龍井中央、林口長庚、北投石牌、桃園青埔、中科永福、屏東廣東、仁武京吉\n\n🎁 1/16即將登場｜買太妃蜜桃風味厚奶霜送蜜桃風味茶一杯\n\n#先喝道 #TAOTAOTEA #手搖飲 #好茶 #米其林 #金杯烏瓦 #世界三大紅茶 #嚴選世界好茶 #英式下午茶 #英國茶 #台灣茶 #手搖推薦 #古典玫瑰園	2026-01-14 00:00:00	122
40	4	FB	四季春茶王	🌿山嵐間的花香與回甘，是被米其林記住的味道 🌿\n什麼樣的茶，能讓國際評審點頭認證？\n\n從台灣優質茶園出發，茶湯清透、花香自然，\n入口輕盈不苦澀，尾韻帶著乾淨回甘，越喝越順，\n透過職人細緻的製茶工藝，把茶葉最純粹的風味完整留下。\n\n也因為這份對風味的堅持，讓它獲得國際評審一致肯定，\n榮獲食品界米其林 iTQi 三星認證。\n\n這不只是一杯日常手搖飲，而是一杯被世界記住的 台灣好茶。\n不用特地上山尋找，先喝道全台門市，就能喝到這杯嚴選世界好茶\n🍃四季春茶王\n\n#先喝道 #TAOTAOTEA #手搖飲 #好茶 #米其林 #四季春茶王 #台灣四大名茶 #嚴選世界好茶 #英式下午茶 #英國茶 #台灣茶 #手搖推薦 #古典玫瑰園\n清心福全	2026-01-13 00:00:00	23
41	4	FB	厚雪奶蓋	【厚雪奶蓋系列 新品上市 #指定門市 試賣中】\n口感綿密，像雪一樣輕柔的「厚雪奶蓋」\n讓人忍不住一口接一口，快來清心點一杯！\n厚雪‧烏龍奶蓋\n甘醇的烏龍綠茶，頂層覆蓋「厚雪」奶蓋，入口濃郁卻如初雪般輕盈不膩。\n厚雪‧頂級可可奶蓋\n頂級可可與「厚雪」奶蓋完美結合。奶蓋的淡雅奶香融入香醇可可，口感飽滿厚實。\n厚雪‧ 紅心芭樂奶蓋\n清香的紅心芭樂，頂端鋪滿一層「厚雪」奶蓋，每一口都能喝得到芭樂的香甜與柔滑綿密的奶蓋。\n只在指定門市才能喝到!!\n販售門市供應，請參見：https://reurl.cc/2lV2za\n清心福全據點搜尋：http://www.chingshin.tw/store.php	2026-01-06 00:00:00	421
42	4	FB	珍珠奶茶	告別 2025・迎接嶄新的一年\n清心福全陪你一起倒數，用熟悉的好味道迎接全新的開始\n【跨年必喝】優惠活動\n活動時間：12/31(三)～1/6(二)\n優惠內容：大杯指定飲品「第二杯折價10元」\n「珍珠奶茶」、「粉圓奶茶」、「椰果奶茶」和「錫蘭奶紅」\n活動注意事項：\n1.本優惠不得與其他優惠併用。\n2.僅適用於大杯指定飲品，且限來店自取。\n3.不適用於外送平台、外送及線上點餐。\n4.本公司保有解釋、修正與終止活動之權利。\n#清心福全 #優惠活動 #新年快樂 #手搖飲料 #2026	2025-12-29 00:00:00	2571
43	4	FB	白韻杏仁奶	冷氣團來襲，低溫拉警報，不想離開被窩就來杯能把冬天融化的「杏福滋味」吧！\n冬季新品【白韻杏仁系列】純淨的白更韻涵典雅韻味，將純淨的幸福感留在唇齒間，韻味無窮。\n#白韻杏仁頂級可可 $80：創新口味，將東方傳統風味的「杏仁粉」溶入頂級可可，雙重甜蜜滋味豪華升級。\n#白韻杏仁奶 $65：以南杏研磨的「特級杏仁粉」，搭配醇正香濃的「嚴選奶精」，每一口都是幸福細密的滑順口感。\n#白韻杏仁鮮奶 $85：以南杏研磨的「特級杏仁粉」，搭配鮮潤的「崙背鮮乳」，杏仁香與乳香完美結合，成就濃郁渾厚的極致口感。\n找回杏福，暖暖過冬，一起拒絕“冷暴力”\n更多資訊請鎖定 ：\n官方網站連結：https://www.chingshin.tw/\nInstagram連結：https://pse.is/M9RBB\nYouTube連結：https://bit.ly/2rtxr5o\n#清心福全 #手搖飲料 #新品登場 #冬季飲品 #暖暖過冬	2025-12-15 00:00:00	4353
44	4	FB	白韻杏仁奶	別讓冷空氣覆蓋了你的好精神，冬季新品上市，品嘗杏福滋味～\n冬季新品【白韻杏仁系列】純淨的白更韻涵典雅韻味，將純淨的幸福感留在唇齒間，韻味無窮。\n#白韻杏仁奶 $65：以南杏研磨的「特級杏仁粉」，搭配醇正香濃的「嚴選奶精」，每一口都是幸福細密的滑順口感。\n#白韻杏仁頂級可可 $80：創新口味，將東方傳統風味的「杏仁粉」溶入頂級可可，雙重甜蜜滋味豪華升級。\n同步推薦【經典冬季不敗飲品】 #珍珠琥珀黑糖鮮奶 #芝麻奶茶 #桂圓鮮奶茶\n找回杏福，暖暖過冬，一起拒絕“冷暴力”\n更多資訊請鎖定 ：\n官方網站連結：https://www.chingshin.tw/\nInstagram連結：https://pse.is/M9RBB\nYouTube連結：https://bit.ly/2rtxr5o\n#清心福全 #手搖飲料 #新品登場 #冬季飲品 #暖暖過冬	2025-11-18 00:00:00	3830
45	4	FB	茉綠茶凍拿鐵	清心福全×變種吉娃娃 連假超吉美食推薦\n連假少不了的吃吃喝喝，「超吉」搭配超過癮！\n吉凍套餐：脆皮吉排＆茉綠茶凍拿鐵，一口酥脆一口Q嗲嗲的絕妙搭配（￣︶￣）\n#清心福全 #手搖飲料 #變種吉娃娃 #連假限定 #茉綠茶凍拿鐵	2025-10-23 00:00:00	333
46	4	FB	荔枝蘋果醋	#雙十節快樂 十月連假第二彈\n又是一個三天連假，千萬別把好時光蹉跎掉了，\n來杯清心福全的 #荔枝蘋果醋 慶祝連假萬睡。\n更多變種吉娃娃資訊請鎖定 ：\n官方網站連結：https://www.chingshin.tw/\nInstagram連結：https://pse.is/M9RBB\nYouTube連結：https://bit.ly/2rtxr5o\n#變種吉娃娃 #清心福全 #手搖飲料 #小狗 #聯名活動	2025-10-09 00:00:00	433
47	4	FB	咖啡凍奶茶	#教師節快樂\n謝謝老師的用心教誨，在特別的日子裡加碼作業，\n來杯大人的滋味 #咖啡凍奶茶，苦甜苦甜才是人生。\n更多變種吉娃娃資訊請鎖定 ：\n官方網站連結：https://www.chingshin.tw/\nInstagram連結：https://pse.is/M9RBB\nYouTube連結：https://bit.ly/2rtxr5o\n#變種吉娃娃 #清心福全 #手搖飲料 #小狗 #聯名活動	2025-09-26 00:00:00	216
48	4	FB	珍珠琥珀黑糖鮮奶	來杯甜甜的，讀書就不會那麼辛苦了 ₊˚⊹♡\n#珍珠琥珀黑糖鮮奶 黑糖香氣滿滿～Q彈珍珠咬一口就超幸福\n#隱藏版 (珍珠蜂蜜鮮奶普洱) 甜而不膩～給你滿滿好心情\n讓清心飲料＆變種吉娃娃陪你收穫好成績！！\n#變種吉娃娃 #清心福全 #聯名活動 #手搖飲料 #小狗勾療癒陪伴	2025-09-23 00:00:00	279
49	4	FB	柳橙綠	這個夏天超吉喜歡喝涼涼的飲料～～\n香甜清爽的 #柳橙綠、 甜Q爽口的 #蜜桃凍紅茶、 酸甜活力的 #紅心芭樂優多，快來清心一口喝下你的新學期元氣，讓開學大吉大利！\n持續關注⇩⇩⇩\n官方網站連結：https://www.chingshin.tw/\nInstagram連結：https://pse.is/M9RBB\nYouTube連結：https://bit.ly/2rtxr5o\n#變種吉娃娃 #清心福全 #聯名活動 #手搖飲料 #可愛的小狗勾	2025-08-19 00:00:00	408
50	4	FB	情人茶	520 「莓」你不行的戀愛滋味\n#粉戀莓莓 像是她微笑時的甜\n#情人茶 像戀愛一樣清爽又讓人心動\n清心福全×三麗鷗男團 給你表白的勇氣\n今天不來一杯怎麼行？讓我們在清心一起心動！\n小編今天只幫你助攻到這～剩下的，就靠你自己加油啦\n更多資訊 ：\n官方網站連結：https://www.chingshin.tw/\nInstagram: https://reurl.cc/67Rn3Z\nYouTube連結：https://bit.ly/2rtxr5o\n#清心福全 #手搖飲料 #三麗鷗男團 #飲料推薦 #520莓你不行	2025-05-20 00:00:00	374
51	6	FB	香芋仙草綠茶拿鐵	涼涼的天適合暖暖的那一杯🥤\n冬天，就該給自己一杯迷客夏的暖心系熱飲👇\n🍫法芙娜可可鮮奶｜𝟭𝟬𝟬%法芙娜可可粉，入口滑順✨\n🤎靜岡焙焙鮮奶｜焙香濃郁，暖到心坎裡~\n🧋珍珠紅茶拿鐵｜𝗤 彈香甜，冬天熱熱喝更對味\n🌿香芋仙草綠茶拿鐵｜芋頭 x 仙草凍 x 綠茶，暖甜飽足感滿滿\n✨暖暖喝，好運暖暖暖~起來✨\n🔹現在買𝟮杯還能抽𝗶𝗣𝗵𝗼𝗻𝗲 𝟭𝟳等豪禮🍎\n🔹現場門市限定：熱門指定單茶&茶拿鐵組合價只要$𝟳𝟵(南)／$𝟴𝟵(北)\n🔹迷點自取限定：滿𝟮杯即贈「愛茶的牛」指定飲品電子兌換券乙張\n現在下單給自己一個暖心飲品👉https://reurl.cc/R9GaXZ\n活動詳見官網👉 https://reurl.cc/gnyg7X\n#迷客夏 #milksha #為了你嚴選每一杯\n#雀蘋中選週週抽 #iPhone抽獎\n#雙週門市驚喜第二彈 #迷點自取買二送一	2026-01-23 00:00:00	82
52	6	FB	茉莉原淬綠茶	你的迷客夏新春大禮包第二彈來襲🎁\n✨𝟭月份雙週限定驚喜✨𝗽𝗮𝗿𝘁 𝟮\n𝟭/𝟮𝟭 (三)~𝟮/𝟯(二)\n<門市現場購買>✨𝗔＋𝗕限定好康✨\n🔥𝗔 區 醇濃鮮奶茶(𝗟) ＋ 𝗕 區 愛茶的牛🔥\n組合價 $𝟳𝟵(南)／$𝟴𝟵(北)\n✨ 一次喝到 濃郁奶香 × 清爽茶韻\n鮮奶控＆茶控都滿足的雙杯組合 ✨\n醇濃鮮奶茶/愛茶的牛適用茶底：\n大正醇香紅茶/英倫伯爵紅茶/茉莉原淬綠茶/原片初露青茶/琥珀高峰烏龍\n新年好康連連~雙倍幸福一次喝😍\n📍 查詢鄰近門市享好康 https://reurl.cc/7Kr7bQ\n🔍 活動詳情請見官網 https://reurl.cc/EbaKAn\n#迷客夏 #milksha #為了你嚴選每一杯 #雙週門市驚喜第二彈	2026-01-20 00:00:00	166
53	6	FB	茉香綠茶拿鐵	你的迷客夏新春大禮包已送達\n𝟭月份雙週限定驚喜第一彈\n即日起~𝟭/𝟮𝟬(二)\n<門市現場購買>任𝟮杯全系列飲品\n即可享加購$𝟯𝟵茶拿鐵(𝗠)𝟭杯\n𝟯𝟵元就能享受迷人的奶香茶韻\n活動加購茶拿鐵適用品項：\n大正紅茶拿鐵/伯爵紅茶拿鐵/茉香綠茶拿鐵/原片青茶拿鐵/琥珀烏龍拿鐵\n新年好康連連，別錯過這一杯\n立即前往鄰近門市享優惠 https://reurl.cc/7Kr7bQ\n活動詳情請見官網 https://reurl.cc/EbaKAn\n#迷客夏 #milksha #為了你嚴選每一杯 #雙週門市驚喜第一彈	2026-01-09 00:00:00	78
54	6	FB	醇濃茶拿鐵派	迎接 𝟮𝟬𝟮𝟲 倒數計時！誰陪你跨年?!\n在煙火綻放的那一刻，\n手裡拿的是哪一杯最愛的迷客夏？\n快在下方用「表情符號」投出你的最愛\n看看哪一派粉絲軍團最強大！\n醇濃茶拿鐵派：迷客夏人氣必喝，最對味！\n清爽單茶派：解膩神助攻，清爽回甘\n特調果香派：果香明亮，層次迷人\n香醇鮮奶派：濃郁順口，暖心首選\n現在就預約你的跨年小夥伴！\nhttps://miniapp.line.me/1657225662-ARnXEvKb\n#迷客夏 #milksha #為了你嚴選每一杯 #2025年度TOP10 #年度推薦 #2026新年快樂	2025-12-31 00:00:00	96
55	6	FB	輕纖蕎麥茶	回顧𝟮𝟬𝟮𝟱年，大家最愛的迷客夏飲料有哪些?!(下集)\n快看你的迷客夏必喝有沒有上榜！\n拿起你最愛的那杯，一起看年度旁行榜 https://milksha.nidin.shop/\n𝗧𝗢𝗣𝟭 #珍珠大正紅茶拿鐵\n融合錫蘭 × 阿薩姆紅茶的多層次茶香\n加上醇濃綠光鮮奶與蜜漬白玉珍珠\n𝗤 彈香甜、冬天必喝\n𝗧𝗢𝗣𝟮 #輕纖蕎麥茶\n無咖啡因首選\n蕎麥穀香濃而不澀，溫潤順口、自然回甘\n獨家製程，讓香氣更純粹\n給想減少咖啡因的小迷人\n𝗧𝗢𝗣𝟯 #伯爵紅茶拿鐵\n釋放獨特佛手柑優雅果香\n完美調和綠光鮮奶\n口感醇厚柔順無人不愛\n𝗧𝗢𝗣𝟰 #原片初露青茶\n單茶控的清爽心頭好\n選用台灣原片青茶\n滋味淡雅清香、圓潤清甜\n𝗧𝗢𝗣𝟱 #芋頭鮮奶\n持續擔綱迷客夏「鎮店之寶」寶座\n選用高雄一號芋頭精心製作\n保留精華中段，手工壓製成綿密芋泥\n搭配綠光鮮奶，每口都有濃濃芋頭香氣和顆粒\n#迷客夏 #milksha #為了你嚴選每一杯 #2025年度TOP10 #年度推薦	2025-12-21 00:00:00	64
56	6	FB	法芙娜可可鮮奶	回顧𝟮𝟬𝟮𝟱年，大家最愛的迷客夏飲料有哪些?!(上集)\n快看你的迷客夏必喝有沒有上榜！\n拿起你最愛的那杯，一起看年度排行榜👉 https://milksha.nidin.shop/\n𝗧𝗢𝗣𝟲 #手炒黑糖鮮奶\n門市手工炒製的黑糖，清甜焦香不膩口\n搭配綠光鮮奶，醇香可口🤎✨\n𝗧𝗢𝗣𝟳 #柳丁綠茶\n迷客夏經典不敗清爽滋味🍊\n𝟭𝟬𝟬%柳丁原汁融合茉莉原淬綠茶\n清新花香襯托柑橘果香，喝得到柳丁果肉\n𝗧𝗢𝗣𝟴 #琥珀高峰烏龍\n榮獲𝟮𝟬𝟮𝟯 𝗜𝗧𝗜風味絕佳二星獎章🎖️\n獨特烤焙工藝，於嗅覺評分項目獲最高肯定\n琥珀色烏龍茶湯，炭焙香氣回甘留香✨\n𝗧𝗢𝗣𝟵 #靜岡焙焙鮮奶\n冬日療癒，「焙」感幸福✨\n採用嚴選靜岡直送茶葉\n獨特烘烤香氣搭配濃醇的綠光鮮奶💚\n口感醇厚滑順，完美融合焙茶＆奶香🫶\n𝗧𝗢𝗣𝟭𝟬 #法芙娜可可鮮奶\n𝗧𝗵𝗿𝗲𝗮𝗱𝘀爆紅回歸款🍫\n𝟭𝟬𝟬%法芙娜純可可粉 × 綠光鮮奶\n可可香氣細緻濃香，入口滑順有層次✨\n💗 微糖熱飲必點 💗\n#迷客夏 #milksha #為了你嚴選每一杯 #2025年度TOP10 #年度推薦	2025-12-20 00:00:00	93
57	6	FB	靜岡焙焙鮮奶	\\齁齁齁~~聖誕加「焙」幸福已抵達/\n𝟭𝟮/𝟮𝟰、𝟭𝟮/𝟮𝟱\n門市現場購買 #𝟮杯靜岡焙焙鮮奶 (𝗠) 只要 $𝟵𝟵\n溫暖加焙、幸福加倍\n現在就 @想一起喝迷客夏的小寶焙\n一起過暖暖聖誕節\n活動詳情請見官網https://reurl.cc/xKWqKV\n#迷客夏 #milksha #為了你嚴選每一杯 #靜岡焙焙鮮奶 #聖誕節快樂	2025-12-19 00:00:00	153
58	6	FB	香芋仙草綠茶拿鐵	𝟮𝟬𝟮𝟱 冬日暖心熱飲，你喝過哪些了呢？\n一起收藏最療癒的冬季 𝗧𝗢𝗣 清單！\n𝗧𝗢𝗣𝟭 #靜岡焙焙鮮奶\n冬日療癒，「焙」感幸福✨\n嚴選自靜岡的特選製茶名家，焙香濃郁\n搭配綠光鮮奶，滑順醇厚、暖心必喝🤎\n𝗧𝗢𝗣𝟮 #珍珠大正紅茶拿鐵\n大正紅茶融合錫蘭 × 阿薩姆紅茶的多層次茶香\n加上醇濃綠光鮮奶與蜜漬白玉珍珠\n𝗤 彈香甜、冬天必喝✨\n𝗧𝗢𝗣𝟯 #法芙娜可可鮮奶\n網友敲碗~重磅回歸刮起法芙娜可可旋風🍫🤎\n選用可可屆愛馬仕的𝟭𝟬𝟬%頂級法芙娜純可可粉\n高雅的苦甜香氣搭配滑順濃香的綠光鮮奶💚\n入口時可可香氣層次明顯🍫✨\n💗推薦微糖熱飲最美味💗\n𝗧𝗢𝗣𝟰 #琥珀烏龍拿鐵\n🤎炭焙香氣 × 綠光鮮奶💚\n柔順口感、層次豐富的冬日暖意\n𝗧𝗢𝗣𝟱 #香芋仙草綠茶拿鐵\n延續榮獲 𝗔.𝗔. 純粹品味三星獎的芋頭鮮奶口碑\n創新結合綠茶與嫩仙草凍\n仙草甘味與滑順奶香蔓延口中💗\n𝗧𝗢𝗣𝟲 #白甘蔗青茶\n選用台灣𝟭𝟬𝟬%白甘蔗原汁\n搭配清新青茶，滋味圓潤清甜🫶\n最療癒的冬季，需要最暖心的熱飲👉 https://milksha.nidin.shop/\n#迷客夏 #milksha #為了你嚴選每一杯 #2025冬日暖心推薦 #冬日必喝	2025-12-10 00:00:00	143
59	6	FB	法芙娜可可鮮奶	大家敲破碗的 #冬季限定 人氣飲品回歸啦！\n靜岡焙焙鮮奶、靜岡焙焙烏龍拿鐵 濃郁登場\n嚴選靜岡製茶名家精工研磨，細緻茶粉完整釋放焙香茶韻\n#靜岡焙焙鮮奶 迷編最推薦\n靜岡焙茶烤焙香氣 × 綠光鮮奶的醇厚滑順\n一口享受高品質的飲茶體驗\n#靜岡焙焙烏龍拿鐵\n榮獲𝗜𝗧𝗜風味絕佳二星獎章的 #琥珀高峰烏龍茶 x #綠光鮮奶\n炭焙茶香交織濃郁奶香，清爽甘醇不膩口\n同場加映\n#法芙娜可可鮮奶 重磅歸隊！\n法國 𝗩𝗮𝗹𝗿𝗵𝗼𝗻𝗮 頂級純可可 × 綠光鮮奶\n苦甜香氣細緻升級，滑順濃郁更迷人\n回味「焙」感溫暖的懷抱 ➜ https://milksha.nidin.shop/\n#迷客夏 #milksha #為了你嚴選每一杯 #濃焙茶 #重磅回歸	2025-11-13 00:00:00	146
60	6	FB	娜杯桂香拿鐵	花香與茶香的邂逅\n\\首款花香基調 —「桂香茶境」𝟭𝟭/𝟱 桂香四溢/\n#娜杯桂香拿鐵\n花香、茶香、奶香交織出圓潤細滑的優雅風味\n#桂香青檸粉粿\n桂花香氣融合青茶與檸檬微酸\n搭配𝗤彈粉粿，一口沁香爽感\n#桂香原片青\n嚴選台灣原片青茶結合金桂甜韻\n清爽甘醇如微風拂過花園\n#桂香輕蕎麥\n蕎麥穀香交織桂花柔香\n溫潤回甘、無咖啡因的療癒系飲品\n#桂香粉粿\n迷客夏首款花香系𝗤彈粉粿登場.ᐟ\n每一口都散發柔香餘韻，搭配各式茶飲都超加分\n立即沉浸在桂香茶境中\nhttps://reurl.cc/pKd0mx\n#迷客夏 #milksha #喝一口繼續走 #桂香茶境	2025-11-04 00:00:00	111
61	7	FB	冬片比賽茶包	過年送什麼，才不會被放在角落？\n懂喝的人都知道——答案是這包\n一年只回來一次的【冬片比賽茶包】\n邁入第 𝟱 年 #COMEBUY 持續限量熱銷中\n嚴選鬥茶協會認證的比賽茶\n茶湯清香、甘甜醇厚、不苦不澀\n超值 𝟱𝗴 茶包，冷泡熱泡都好喝！\n為什麼過年送它剛剛好？\n精緻包裝，送禮有面子\n𝟱𝗴 立體三角茶包，香氣更完整\n可回沖多次，在家慢慢喝也很可以\n價格親切，自用送人都適合\n今年過年，送一份「懂喝的心意」\n也替自己留一包，好好喝一杯\n一年一次，錯過真的要等明年了～\n數量有限，售完為止！\n冬片比賽茶包｜𝟱𝗴 x 𝟭𝟬入裝｜𝟭𝟵𝟵元\n#冬片比賽茶包 #一年一次 #過年送禮首選	2026-02-09 00:00:00	15
62	7	FB	雙黑糖堆疊	把看似平凡的事做到不平凡\n才是真正的高度\n世界級的舞台\n來自每天不妥協的基本功\n就像 #COMEBUY 把每一杯茶\n都當成最重要的一杯\n#把日常做到世界級\n#現萃不是口號 #每一杯都很重要\n2026/01/08 (fb) 按讚數:\n#COMEBUY 黑糖特別在…\n不是更甜，而是更「真」\n—— #半糖 以上風味完整好喝\n黑糖的香、甘、厚一次到位\n甜度剛好，也喝出黑糖的層次口感\n沖繩 × 台灣 雙重黑糖堆疊\n一個給你焦糖香的厚度\n一個留下甘蔗清甜的尾韻～\n飲品甜度來自黑糖本身\n不是比例堆疊，是經熬煮產生的自然焦糖香\n層次深厚卻不膩，喝得到溫潤也喝得到乾淨\n未經高度精製保留完整營養\n黑糖沒有走繁複提煉流程\n保留更多礦物質與原始風味\n甜得剛好，也喝得安心！\n一杯好喝現萃搭配黑糖\n才是冬天最耐喝的暖呼呼 ☕︎\n#雙黑糖堆疊 #OnlyBlackSugar\n#黑糖不是都一樣 #無可取代的單杯現萃	2026-01-26 00:00:00	34
63	7	FB	沖繩黑糖奶茶	𝟮𝟬𝟮𝟱 → 𝟮𝟬𝟮𝟲 倒數啦\n跨年夜一定要來點「咀嚼系幸福」(〃∀〃)\n今年最後一杯＆新年第一杯——\n#COMEBUY #沖繩黑糖奶茶\n—— 甜度僅靠黑糖半糖以上最有味 ♡\n雙𝗤𝟭號（珍珠＋粉條）\n𝗤彈、軟糯、焦香、濃奶一次登場\n比煙火還療癒的口感衝擊就在這刻炸開\n跨年的願望不一定要很偉大：\n喝到好喝的\n心情甜一點\n明年更順一點\n這杯就能全包辦 (๑˃ᴗ˂)و♡\n迎向 𝟮𝟬𝟮𝟲，讓暖甜先替你開個好頭吧～\n#跨年 #新年必喝 #雙Q咀嚼控集合\n#黑糖不另外加糖 #半糖以上最有味	2025-12-31 00:00:00	35
64	7	FB	黑糖紅茶拿鐵	𝗠𝗲𝗿𝗿𝘆 𝗖𝗵𝗿𝗶𝘀𝘁𝗺𝗮𝘀\n聖誕快樂呀大家 (ﾉ>▽<)ﾉ\n今天就讓一杯暖甜的 #沖繩黑糖系列\n陪你一起度過最閃亮的節日吧～\n透過完美比例與台灣黑糖蔗香融合\n焦香 × 奶香 × 茶香 層層堆疊\n喝一口直接：天啊也太幸福了吧 (๑´ڡ`๑)\n和最重要的朋友在這一天相聚\n一杯暖暖黑糖飲＝完美儀式感 ♡\n#沖繩黑糖奶茶 #沖繩黑糖奶綠\n#黑糖紅茶拿鐵 #黑糖港式厚奶\n#聖誕節快樂 #暖心必喝 #無可取代的單杯現萃	2025-12-25 00:00:00	23
65	7	FB	黑糖紅茶拿鐵	\\\\ 期盼の新品來了 //\n熬煮香氣升級的【沖繩黑糖系列】全新上市\n融合台灣黑糖蔗香，堆疊出馥郁焦糖香氣\n喝一口就知道——這次真的很可以 (*´∀`)ﾉ\n#沖繩黑糖奶茶 $𝟲𝟬(𝗟)\n台灣黑糖 × 沖繩黑糖，融入錫蘭紅茶與醇厚奶香，\n馥郁焦糖香交織甜潤奶茶，香濃不膩、飽滿順口！\n#沖繩黑糖奶綠 $𝟲𝟬(𝗟)\n雙黑糖結合醺香綠茶與奶香，\n散發焦糖香氣，茶感清爽、奶韻柔和的完美平衡！\n#黑糖紅茶拿鐵 $𝟳𝟱(𝗟)\n現泡烏瓦紅茶＋鮮乳，茶香濃厚香醇；\n雙黑糖提味，焦香迷人卻不膩口，是鮮奶茶愛好者首選！\n#黑糖港式厚奶 $𝟴𝟬(𝗠)\n現泡錫蘭紅茶混淡奶打造港式厚實口感，\n搭配雙黑糖提升焦甜層次，濃郁茶香與滑順奶韻一次到位！\n#新品上市 #沖繩融合台灣黑糖 #馥郁焦糖香\n#無可取代的單杯現萃 #半糖以上風味最佳 #暖心登場\n—\n⧁ 加入官方𝗟𝗜𝗡𝗘點連結拿𝟵折券 ➙ https://comebuy.pse.is/74g326\n⧁ 全台門市據點 ➙ https://lihi1.com/9IiXS\n⧁ 門市菜單 ➙ https://lihi1.com/xbX73	2025-12-19 00:00:00	30
66	7	FB	小葉紅奶茶	\\ 葉~~~~~~~~真的回來了.ᐟ.ᐟ /\n國際連鎖品牌中 #COMEBUY 全球首賣\n限量嫩採的《小葉紅茶》重磅回歸🍁\n在地好茶就是要 #現萃 才好喝 (✪ω✪)\n一起品味頂級紅茶、享受質感生活✨\n#小葉紅茶 $𝟱𝟬(𝗟)\n嚴選南投縣名間鄉嫩採的四季春重發酵製成\n擁有獨特果蜜香，茶湯溫潤、細緻高雅、不苦不澀！\n#小葉紅奶茶 $𝟳𝟬(𝗟)\n滋味柔順、甘甜順口的小葉紅茶混入奶精粉\n昇華香醇豐厚口感，奶茶控必喝！\n#小葉紅拿鐵 $𝟳𝟱(𝗟)\n順口回甘小葉紅茶加入香醇鮮奶\n成為健康族群最愛的頂級鮮奶茶！\n#季節限定 #四季春 #高品質 #紅茶 #限量嫩採\n#無可取代的單杯現萃 #限來店購買 #售完為止\n—\n⧁ 加入官方𝗟𝗜𝗡𝗘點連結拿𝟵折券 ➙ https://comebuy.pse.is/74g326\n⧁ 全台門市據點 ➙ https://lihi1.com/9IiXS\n⧁ 門市菜單 ➙ https://lihi1.com/xbX73	2025-11-06 00:00:00	41
67	7	FB	玩火	萬聖節最「火」裝扮出爐\n南瓜人都來 #COMEBUY 報到啦\n玩火不只好喝～還能當配件（誤）\n擁有熱帶水果風味的黃金茶湯\n讓你成為派對裡最亮眼的焦點\n今年萬聖節 ——\n不喝茶就搗蛋 ლ(>д< ლ)\n#萬聖節快樂 #無可取代的單杯現萃 #現萃驚艷\n—\n⧁ 全台門市據點 ➙ https://lihi1.com/9IiXS\n⧁ 門市菜單 ➙ https://lihi1.com/xbX73	2025-10-29 00:00:00	19
68	7	FB	玩火奶茶	中秋節不只要烤肉更要 #玩火\n一家烤肉萬家香一杯 #現萃 超沁爽.ᐟ.ᐟ\n嚴選甘甜煎茶與清香烏龍\n混拼百香果、芒果等熱帶水果風味烘製\n果香四溢中透著淡淡蘭花香(๑´ڡ`๑)\n門市現場限量活動\n𝟭𝟬/𝟭𝟱前至全台 𝗖𝗢𝗠𝗘𝗕𝗨𝗬 門市\n現場消費【玩火/玩火奶茶】任一杯即可獲得...\n免費加入 #船井生醫 FIP100纖維粉𝟭包（升級纖萃）\n再加碼送完整𝗣𝗘包裝𝟭包帶回家\n（詳細活動說明 ➙ https://reurl.cc/yAVYpq ）\n不管你是牛小排派還是香腸控\n這杯果香 × 清爽 × 纖維滿分\n能完美收尾你的烤肉大餐ヽ(●´∀`●)ﾉ\n今年就讓 #COMEBUY 陪你「火」力全開！\n#纖萃玩火 #纖萃玩火奶茶\n#中秋節 #中秋烤肉配好茶\n—\n⧁ 詳細FIP100纖維粉說明 ➙ https://www.funaicare.com/products/burner-bv15\n⧁ 全台門市據點 ➙ https://lihi1.com/9IiXS\n⧁ 門市菜單 ➙ https://lihi1.com/xbX73	2025-10-03 00:00:00	44
69	7	FB	玩火奶茶	❝火❞了𝟮𝟬年的經典現萃\n沒時間飛就喝這杯\n外面找不到的獨特風味——\n喝一口彷彿置身❝熱帶❞島嶼\n建議半糖以上最好喝\n#玩火 $𝟰𝟱(𝗟)\n嚴選甘甜煎茶與產自春天高山上的清香烏龍茶\n混拼百香果、芒果等熱帶水果風味烘製而成\n獨家黃金茶湯喝得到水果香氣與淡淡蘭花香！\n#玩火奶茶 $𝟲𝟱(𝗟)\n嚴選甘甜煎茶與清香烏龍茶調製奶茶\n帶有熱帶水果香氣與淡淡蘭花香\n讓奶茶風味獨特又清爽不膩！\n#無可取代的單杯現萃 就在 #COMEBUY\n—\n⧁ 加入官方𝗟𝗜𝗡𝗘點連結拿𝟵折券 ➙ https://comebuy.pse.is/74g326\n⧁ 全台門市據點 ➙ https://lihi1.com/9IiXS\n⧁ 門市菜單 ➙ https://lihi1.com/xbX73	2025-09-19 00:00:00	20
70	8	FB	蘋果紅萱	茶香遇上果香的溫柔調性，\n是日常裡隨手可得的療癒感。\n透亮的琥珀茶湯、伴隨自然柔和的蘋果香，\n不論是在門市現泡、或是便利商店，\n都希望你能在不同的生活片刻裡，\n#龜記 #GUIJI #蘋果紅萱 #SevenEleven	2025-11-21 00:00:00	76
71	8	FB	普洱咖啡奶茶	普洱咖啡奶茶、普洱咖啡鮮乳\n今日上市\n呈現秋冬限定新品\n碎銀普洱厚韻×義式濃醇咖啡\n交織出溫暖成熟的獨特風味\n季節限定不要錯過( ˶ˊᵕˋ)੭♡\n↟.｡.:*･↟\n本產品以 100% 純咖啡液製成，咖啡液中含有多酚類等活性成分，在儲存過程中可能產生微量沉澱，屬於正常現象不影響品質，為天然純咖啡的特徵之一。\n#龜記 #GUIJI #樂步 #lebrewlife #普洱 #咖啡 #普洱咖啡奶茶 #普洱咖啡鮮乳	2025-11-01 00:00:00	30
72	8	FB	普洱咖啡奶茶	🧡龜記茗品×  樂步le brewlife💙\n當茶遇上咖啡，碰撞出這個秋冬最獨特的香氣🍂\n龜記攜手不斷挑戰與創新的樂步 le brewlife，\n雙品牌貫徹重視的「品質」與「生活感」，\n打破手搖飲的傳統框架。\n結合樂步的義式濃醇咖啡☕️\n融合順滑奶感，帶出濃郁溫暖的冬季限定特調。\n驚喜又充滿細節與質感的風味，\n完美展現兩個品牌的堅持與講究。\n溫馨提醒：本產品以 100% 純咖啡液製成，咖啡液中含有多酚類等活性成分，在儲存過程中可能產生微量沉澱，屬於正常現象不影響品質，為天然純咖啡的特徵之一。\n#龜記 #GUIJI #樂步 #lebrewlife #普洱 #咖啡 #普洱咖啡奶茶 #普洱咖啡鮮乳	2025-10-28 00:00:00	99
73	8	FB	蜂蜜花沫烏龍	中秋烤肉聚會多🥮🍖\n就是清爽的飲料該登場的時候😋\n10/3 (五)~10/6（一）\n中秋節限定活動，\n🌸購買兩杯蜂蜜花沫烏龍，就送一杯花沫烏龍🌸\n活動注意事項☆.｡.😘\n🌕限龜記門市現場+電話自取、龜記線上點自取享有\n🌕一般外送與外送平台皆不適用此活動\n🌕單筆消費可累贈（買2送1、買4送2，依此類推）\n#龜記 #GUIJI #中秋 #烏龍 #花沫烏龍 #蜂蜜 #蜂蜜花沫烏龍	2025-10-01 00:00:00	53
74	8	FB	三十三茶王	💗荔枝茶王今日上市💗\n-\n荔枝果肉＋茶王茶湯＝完美組合🍃\n一起夏末的微風裡，品嚐酸甜滋味☀️\n季節限定不要錯過٩꒰｡•◡•｡꒱۶\n-\n⧁ 圖為示意參考，請以現場實物為準\n#龜記 #GUIJI #新品 #荔枝 #三十三茶王 #荔枝茶王	2025-09-15 00:00:00	52
75	8	FB	功夫茶	召喚神龍的時刻到來！\n龜記推出夏季聯名限定補氣飲品：『星桃樂翡翠』\n加入功夫茶清爽芭樂果泥與龜記古早味楊桃蜜🌟\n層層果香堆疊，酸甜中帶茶香回甘\n一口喝下如氣流直擊味蕾⚡️\n還有聯名限定熱血周邊🎁\n從飲料杯身到保冷袋，從吸管塞到水壺提帶，\n每一樣都值得粉絲們「集氣收藏」⚡️\n限定活動第➊波：滿額贈禮\n活動期間｜𝟐𝟎𝟐𝟓/𝟎𝟕/𝟎𝟏 - 𝟐𝟎𝟐𝟓/𝟎𝟖/𝟑𝟏\n購買『星桃樂翡翠』 乙杯＋任一龜記飲品乙杯\n即可獲得【七龍珠 大魔 ✕ 龜記 ✕ 功夫茶 保冷袋】乙個\n☑數量有限，每人每筆限贈一次\n☑電話預訂、外送及外送平台不適用\n這個夏天，集氣開喝、召喚神龍，\n＃龜記 #GUIJI #功夫茶 #聯名活動 #星桃樂翡翠 #楊桃 ＃芭樂 ＃期間限定企劃 #七龍珠大魔	2025-07-01 00:00:00	120
76	8	FB	紅柚翡翠	龜蜜相揪過端午限時優惠別錯過\n-\n𝟓 / 𝟑𝟎 ( 五 ) ～ 𝟔 / 𝟏 ( 日 )\n⋯紅柚翡翠 2 杯 100 元⋯\n粽子吃多了難免油膩，搭配清爽解膩的紅柚\n絕對是最強儀式感組合\n限時 3 天優惠，每單限購 3 組\n⊱ 門市據點：https://lihi.cc/q8S7v\n⊱ 加入會員：https://lihi.cc/sDRhG\n⊱ 線上點餐：https://lihi.cc/xuJqa\n-\n⧁ 龜記桃園機場店、臺大醫院店不參與此活動\n⧁ 龜記全台門市「現場購買」與「現場自取」適用\n⧁ 不適用於龜記線上點餐/龜記線上點自取/Uber Eats/foodpanda/你訂 外送平台\n⧁ 各行銷活動、折扣、優惠、龜蜜卡點數折抵不合併使用（環保杯折抵5元不在此限）\n#龜記 #GUIJI #紅柚翡翠 #端午節 #優惠 #手搖	2025-05-29 00:00:00	93
77	8	FB	巨峰葡薈青	魅力新品、炫風來襲！\n巨峰葡薈青⋯𝟓/𝟏 上市.* ﾟ\n限量販售錯過不薈來\n融合四季春青茶＋巨峰葡萄汁＋蘆薈 ˊ˗\n年度必試的細膩質感風味\n⊱ 門市據點：https://lihi.cc/q8S7v\n⊱ 加入會員：https://lihi.cc/BKWoU\n⊱ 線上點餐：https://lihi.cc/BKWoU\n-\n⧁ 圖為示意參考，請以現場實物為準\n⧁ 實際販售情況依各門店為主完售不補貨\n#龜記 #GUIJI #新品 #限量販售 #巨峰葡薈青	2025-04-30 00:00:00	63
78	8	FB	三十三茶王	冬天是想瘦身最有效的季節（啪！\n-\n想解膩又怕小肚肚累積脂肪 ˃̶͈ ˂̶͈ ？\n整理三支小清新飲品給大家⇣\n花沫烏龍\n很多人不知道～今年夏天超受歡迎的蜜桃烏龍就是以花沫為茶底喔味道很清新、順口，有膩口食物需要搭配的話非常推薦！\n蜂蜜綠茶／四季春\n龜記使用蜜蜂工坊真蜂蜜除了是天然糖漿外，蜂蜜還有潤喉、保護心血管等附加價值，可以依照個人口味挑選茶底\n三十三茶王\n說到茶系列的熱銷單品33絕對榜上有名！老師傅獨家訂製的烘培法，口感回甘、韻味豐富，重點是喝完不會心悸呀～（龜小編心中 TOP 1 ）\n圖片奉上最新的熱量、咖啡因含量表呦\n⊱ 門市據點：https://bit.ly/40G8McA\n⊱ 加入會員：https://bit.ly/3O0e5vV\n⊱ 線上點餐：https://bit.ly/3AwFvGB\n#龜記 #GUIJI #推薦 #飲品推薦 #茶飲 #蜂蜜	2024-12-03 00:00:00	53
79	8	FB	品牌日常/無特定飲品	藍波萬啦！No.1 !!!!\n-\n昨晚真的創造了歷史性的一刻\n謝謝你們締造「烏」與倫比的佳績\n慶祝中華隊勇奪冠軍！\n用細膩的醇粹與花香\n感受「烏」與倫比的光榮\n-\n⧁ 單筆限購一組\n⧁ 限來店臨櫃現場購買，不適用各大外送平台、龜記線上點餐或電話自取\n⧁ 活動品項加料需另付費，恕無法更換其他商品\n⧁ 部分門店不參與：板橋環球店、新竹SOGO店、南港中信店、汐止遠雄店、大巨蛋店、臺大醫院店、台北車站店、統一時代店、南港CITYLINK店\n#龜記 #GUIJI #小人物大生活 #世界12強棒球錦標賽 #中華隊 #冠軍 #台灣之光	2024-11-25 00:00:00	200
80	9	FB	四季春青茶	「梅醬出任務，酸甜接力棒！」\n#旺來系列臨時缺席，梅醬來HOLD場囉 ^w^\n門市QA排行榜：50嵐 #梅の綠，到底怎麼唸？\n梅子綠？ 梅之綠？ 梅綠？ 梅什麼綠？ 那個綠？\n不論怎麼唸，喝過就忍不住心心念念！\n梅の綠：清爽系\n酸甜梅汁配上茉莉花香綠茶，先酸甜後茶香，\n多層風味口感，滿滿戀愛好滋味。\n梅の紅：復古系\n香氣細緻的紅茶遇上梅汁，酸甜帶點回甘，\n一秒回到以前柑仔店配話梅的年代～\n梅の青：淡雅系\n清香且淡雅的四季春青茶，加入酸甜梅汁，\n連員工都愛的私房搭配，喝得出層次又不會膩！\n梅の烏：成熟系\n有焙火香氣的黃金烏龍搭配微酸解膩的梅汁，\n酸甜解膩、茶味相宜，大人味首選非他莫屬！\n心動不如馬上行動，找到你的夏日專屬酸甜\n#50嵐 #50嵐中區 #好茶陪伴你的日常 #手搖 #飲料\n#梅の綠 #梅の紅 #梅の青 #梅の烏	2025-05-28 00:00:00	41
81	9	FB	四季春青茶	【時令鮮果首選～情人茶！】\n阿嵐發現近期因應氣候關係，金桔常常請假～\n為了嵐粉們的酸甜愛戀，真心推薦 #情人茶\n鮮榨檸檬×獨家梅醬×茉莉綠茶 黃金組合，\n酸得剛好，甜得迷人，清爽不膩，一喝就愛上\n那種鮮酸甜蜜回甘的層次感，就是戀愛的味道！\n阿嵐私房喝法，今天就試試吧 (*´∀`)~\n甜度三分糖以上～戀愛心情百分百！\n冰塊微冰或少冰～冰沁入魂包你愛！\n偷偷宣傳當月詢問度破表的隱藏飲品 #多多青\n養樂多×四季春青茶 酸甜控的你也一定會喜歡！\n#50嵐 #50嵐中區 #好茶陪伴你的日常 #手搖 #飲料\n#情人茶 #8冰綠 #檸檬 #金桔 #梅醬	2025-05-07 00:00:00	92
82	9	FB	阿薩姆紅茶	號外號外📣嵐冰友家族擴編中！\n嵐氏冰淇淋三種口味～香草/芒果/荔枝\n#你最喜歡哪個><\n阿嵐大推✨冰淇淋系列\n①荔枝烏龍\n使用細緻荔枝義式雪酪\n搭配焙火香氣黃金烏龍\n濃郁甘甜 層次再升級🤍\n②芒果青\n濃郁芒果香甜鮮果雪酪\n與四季春青茶完美交織\n網友敲網 超經典回歸🧡\n③冰淇淋紅茶\n綿密香濃的香草冰淇淋\n加香醇陳韻阿薩姆紅茶\n極品絕配 一口就上癮❤️\n#50嵐 #中區50嵐 #好茶陪伴你的日常 #手搖 #飲料 #新品 #嵐冰友 #荔枝烏龍 #芒果青	2024-08-05 00:00:00	41
83	9	FB	荔枝烏龍	新品 #嵐冰友 強勢來襲！\n嵐粉們喝過了嗎？σ`∀´)σ\n必喝的3個秘密！ #快來看看\n全新飲品 #嵐冰友🧊\n1. 冰淇淋基底茶可更換～芒果青/綠/紅/烏，荔枝烏龍/綠/青/紅 #任你選\n2. 配料自由加～珍珠、波霸、椰果或燕麥 #全免費\n3. 杯身貼紙小秘密～荔枝、芒果、香草每個口味都不一樣❣️\n#荔枝烏龍 #芒果青 你喜歡哪個？\n阿嵐兩個都超喜歡！\n入口感受雪酪的沁心透涼，\n再品嚐基底茶的質感回甘，\n是夏天的一大救贖🤍\n#50嵐 #中區50嵐 #好茶陪伴你的日常 #手搖 #飲料\n#新品 #嵐冰友 #荔枝烏龍 #芒果青	2024-08-03 00:00:00	50
84	9	FB	冰淇淋綠茶	夏季主打 #綠茶專賣店 登場(*´∀`)~\n十級嵐粉在哪裡～發現招牌的小秘密了嗎？\n真正的 #招牌 #茉莉綠茶 到來！\n本次主視覺以超元氣的日漫風格\n強調我們滿滿的熱情與專業的搖茶技巧\n綠茶喝一下 清爽喝一夏！\n三款經典 #綠茶系 飲品～ 必喝！\n▷波霸綠茶拿鐵\n典雅奶香加綠茶 尾韻豐厚又清香\nQ彈口感大滿足 微甜波霸一級棒\n▷冰淇淋綠茶\n茉綠尬香草冰淇淋 清爽暢快透心涼\n多重層次超幸福 夏日必喝人氣款\n▷多多綠茶\n經典多多配綠茶 微酸微甜超解膩\n炎熱夏日喝一口 完美療癒笑開懷\n#50嵐 #中區50嵐 #好茶陪伴你的日常 #手搖 #飲料 #夏季主打 #綠茶專賣店 #波霸綠茶拿鐵	2024-05-31 00:00:00	98
85	9	FB	好茶陪伴你的	柚，是你～ ！你回來了♡\n#葡萄柚系列 COME BACK！\n少女紅橘色的經典葡萄柚\n譜出如夏日戀歌般的滋味\n屬於這個季節的限定飲品\n是520 不可不喝酸甜滋味♡\n季節限定\n►鮮柚綠\n►葡萄柚汁\n►葡萄柚多多\n#50嵐 #50嵐中區 #葡萄柚系列 #季節限定 #好茶陪伴你的日常	2024-05-20 00:00:00	95
86	9	FB	好茶陪伴你的	什麼！竟然還可以這樣喝？！\n珍波椰青茶升級小祕技d(`･∀･)b\n布丁/燕麥/瑪奇朵 加上去超好喝♡\n幸福指數大大大提升！\n快相揪朋友一起來喝～\n#50嵐 #50嵐中區 #好茶陪伴你的日常 #手搖 #飲料\n#春季主打 #嵐a青春 #珍波椰青茶	2024-05-18 00:00:00	62
87	9	FB	阿華田	「阿華田」120歲生日快樂🎉🎉\n嵐粉們喜歡在「阿華田」裡加哪些配料呢？\n阿嵐最喜歡在裡面加滿滿的燕麥和珍珠了！！\n喝完超有飽足感～營養滿點！\n🤫 聽說阿華田歡慶抽獎活動誠意滿滿！\n\\\\ 完整內容請參閱活動網站說明 //\nhttps://www.ovaltine.com.tw/ovaltine_120celebration/\n#50嵐 #50嵐中區 #好茶陪伴你的日常 #手搖 #飲料\n#歡慶阿華田120周年瑞士經典不斷電 #阿華田橘色潮食尚美味大探索	2024-05-08 00:00:00	157
88	9	FB	四季春青茶	本月主打 #珍波椰青茶ヽ(●´∀`●)ﾉ\n季主打嵐a青春～必喝品項\n#超值組合 滿滿配料珍波椰直接抵一餐\n#清爽暢飲 經典四季春青茶清香又回甘\n不說了！阿嵐要手刀去買一杯～\n#50嵐 #50嵐中區 #好茶陪伴你的日常 #手搖 #飲料 #春季主打 #嵐a青春 #珍波椰青茶	2024-05-06 00:00:00	50
89	9	FB	奶茶	春秋戰國時代百家爭鳴，\n現在奶茶也有四大門派擁護者\n奶茶派、奶青派、烏龍奶派、奶綠派\n各派系擁護者眾多～你屬於哪一派呢？\n歡迎嵐粉們分享 #最愛奶類\n阿嵐最近偏好 #珍珠奶青\n獨特奶香味搭配四季青茶的滿口清香\n再感受滑順的小珍珠，超級好喝～\n#50嵐 #50嵐中區 #春季主打 #嵐a青春 #珍珠奶青 #好茶陪伴你的日常 #手搖 #飲料	2024-04-09 00:00:00	71
90	10	FB	羽衣蘋安	#二月最後一次 超級星期一優惠把握啦\n被譽為超級食物的羽衣甘藍，營養滿滿!!\n中午來一杯現榨 #羽衣蘋安杯 讓你開啟元氣滿滿的星期一\n2/9臨櫃限定 | 羽衣蘋安杯（M）只要49元\n*羽衣甘藍屬高鉀蔬菜，腎功能不良或低血壓族群請酌量食用\n*商場、外島等部分門市無販售，請以現場公告為準\n*優惠不併用\n#CoCo #羽衣甘藍 #優惠活動 #超級星期一	2026-02-08 00:00:00	51
91	10	FB	珍珠黑糖拿鐵(14oz)	嚼對很紓壓!手搖咖啡新登場!\n珍珠黑糖拿鐵(14oz)是咖啡也是手搖!\nQ彈珍珠在黑糖拿鐵裡翻滾，越嚼越香越過癮!冷熱都超好喝全台門市陸續開賣先點再取 maac.io/1HR0Q\n#CoCo都可 #珍珠黑糖拿鐵	2026-02-06 00:00:00	121
92	10	FB	莓好雙果茶	近期紅什麼就紅這杯明天來場莓好約會\n美樂蒂最愛草莓肯定要整組的啦～\n用美樂蒂聯名紙杯裝莓好雙果飲夢幻可愛\n𝟮/𝟰 都可訂限定優惠\n莓好雙果茶(L)\n憑券第二杯 #0元\n2杯只要75元\n每個人有2張券\n點我領券 https://maac.io/1HR0Q\n注意事項\n限使用「CoCo都可訂」線上點單，優惠不併用\n𝟮/𝟰 𝟎𝟎:𝟎𝟎 開始領券，第2、4杯可享折扣\n領券後，在確認明細時點選’’點我使用折價券’’帶入折扣\n限 𝟮/𝟰 當日使用，數量有限，售完為止\n商場門市/部分門市不適用本活動\n#好友日 #都可好友日 #CoCo都可	2026-02-03 00:00:00	110
93	10	FB	28茉輕乳茶	2月開始的每一天都在開心倒數過年٩(๑> ₃ <)۶з\n天天都是喝飲料的好日子 當然也要優惠喝 心情更加分👍\n全區任選2杯99\n🍓莓好雙果茶 草莓蔓越莓與紅茶的超幸福搭配🩷\n🧋冬韻擂焙珍奶 天冷喝這杯最暖心\n✔ 28茉輕乳茶✔ 21歲輕檸烏龍✔日焙珍珠奶茶\n🏠小湯圓奶茶(門市臨櫃限定)\n全部任選、自由搭配！\n📍 全台門市臨櫃＆都可訂平台同步優惠\n📍 活動品項及販售依各門市公告為主\n📍 外送平台及部分門市不適用\n#CoCo都可 #2杯99	2026-02-03 00:00:00	114
94	10	FB	生椰職人拿鐵(14oz)	週二咖啡日又要到啦!\n來杯西西里手搗檸檬美式\n鮮檸檬現搗出檸檬特有的精油香氣\n搭配職人金獎現磨咖啡\n感受鮮果的清新 品味咖啡的香醇\n隨心暢飲 加料更有勁\n每週二限定\n生椰職人拿鐵/職人美式/果咖美式 同價位買一送一\n 臨櫃 / 都可訂 同步開喝\n準時開點 https://maac.io/1HR0Q\n活動品項\n生椰職人拿鐵(14oz)（街邊) 原價$70\n粉角生椰拿鐵(14oz)（街邊) 原價$80\n職人美式(14oz)（街邊）原價$45\n西西里手搗檸檬美式 /紅柚香檸美式(L)（街邊）原價$75\n台灣柳丁美式( L) (街邊) 原價$85\n活動優惠以原價計，優惠不併用\n商場及部分門市不適用，詳情請洽現場公告\n#CoCo都可 #週二咖啡日 #買一送一 #職人咖啡 #CoCoCoffee	2026-02-02 00:00:00	33
95	10	FB	紅柚香檸美式	⌛OOO優惠倒數⌛\n(內個不要TAG我老闆😆喝就對了)\n有人跟小編一樣嗎?🛏️每天的開局就是果咖(西西里手搗香檸美式/紅柚香檸美式/香橙美式)，再加一份粉角或珍珠，醒腦又療癒RRRR!\n小編小桑心劇透…優惠倒數…快把握!\n☕️天天果咖日：各店指定美式、果咖系列同價位買一送一!\n☕️週二咖啡日：各店指定美式、果咖、生椰拿鐵系列買一送一!\n👉臨櫃買、線上點👉 https://maac.io/1HR0Q\n⚠️活動優惠以原價計，優惠不併用\n⚠️商場及部分門市不適用，詳洽各店現況\n#coco都可 #咖啡 #優惠 #買一送一	2026-01-30 00:00:00	113
96	10	FB	百香雙響炮	全民喝百香雙響炮第二杯10元\n快找那個願意幫你出10元的人 ~\n𝟭/𝟮𝟴 都可訂限定優惠\n百香雙響炮(L)\n憑券第二杯 #10元\n2杯80元帶走\n每個人有2張券\n點我領券 https://maac.io/1HR0Q\n注意事項\n限使用「CoCo都可訂」線上點單，優惠不併用\n𝟭/𝟮𝟴 𝟎𝟎:𝟎𝟎 開始領券，第2、4杯可享折扣\n領券後，在確認明細時點選’’點我使用折價券’’帶入折扣\n限𝟭/𝟮𝟴 當日使用，數量有限，售完為止\n商場門市/部分門市不適用本活動\n#好友日 #都可好友日 #CoCo都可	2026-01-27 00:00:00	185
97	10	FB	莓好雙果牛乳	🍓My Melody 莓好限定!莓好雙果系列甜美開喝！\n🍓酸甜草莓 ✕ 鮮香蔓越莓\n💗\n在紅茶與鮮奶的襯托下，開啟最療癒的莓果時刻～\n不只「好喝」，更「喝得安心」！\n採用尖端 HPP冷高壓滅菌技術 製作💡\n保留草莓與蔓越莓的營養、果香 ꙳⸌♡⸍꙳\n同時以超高壓力鎖住新鮮、遠離細菌\n讓每一口都是滿滿自然甜味與健康能量💪\n🍓 莓好雙果茶\n融合草莓、蔓越莓與紅茶香氣～\n酸甜交織、沁涼爽口，超適合下午來一杯✨\n🥛 莓好雙果牛乳\n莓果的酸甜搭上濃醇鮮奶\n柔滑香濃、無咖啡因，大人小孩都能喝！💗\n酸甜莓果 × 健康科技\n一起來喝下雙倍「莓」好的幸福！🫶\n1/26開始購買任一大杯飲品還有美樂蒂聯名紙杯喔💗\n#CoCo都可 #莓好雙果系列 #莓好雙果茶 #莓好雙果牛乳 #HPP冷高壓滅菌	2026-01-24 00:00:00	233
98	10	FB	冬韻擂焙珍奶	不得不愛天氣冷喝暖暖! 暖暖喝!\n#冬日奶茶天花板 開喝\n嚴選14種營養穀物\n手工煮製日式鹿兒島焙奶茶\n𝟭/𝟮𝟭 都可訂限定優惠\n冬韻擂焙珍奶(L)\n憑券第二杯 #0元\n2杯70元帶走\n每個人有2張券\n點我領券 https://maac.io/1HR0Q\n注意事項\n限使用「CoCo都可訂」線上點單，優惠不併用\n𝟭/𝟮𝟭 𝟎𝟎:𝟎𝟎 開始領券，第2、4杯可享折扣\n領券後，在確認明細時點選’’點我使用折價券’’帶入折扣\n限𝟭/𝟮𝟭當日使用，數量有限，售完為止\n商場門市/部分門市不適用本活動\n#好友日 #都可好友日 #CoCo都可	2026-01-20 00:00:00	222
99	10	FB	28茉輕乳茶	各位觀眾🎤\n周末不管你有什麼會\n都不能忘了2杯$99優惠!\n體感冷就喝冬韻擂焙珍奶溫的三分糖\n體感熱就喝莓好雙果茶少冰半糖\n是不是妥妥的周末戰備!!\n🧋2杯99必喝無悔🧋\n✔ 28茉輕乳茶✔ 日焙珍珠奶茶✔ 21歲輕檸烏龍✔ 冬韻擂焙珍奶✔ 莓好雙果茶\n✔小湯圓奶茶（臨櫃限定）  任選自由配！\n📍 門市臨櫃＆都可訂平台同步優惠\n📍 活動品項及販售依各門市公告為主\n📍 非全門市活動，，請以門市現場公告為準\n#CoCo都可 #2杯99 #尾牙 #周末	2026-01-16 00:00:00	182
100	1	IG	黑霸烏龍奶	＼迎接假期！／限時 #買一送一 先開喝！\n\n年假即將來臨，忙碌中還是要懂得享受 ·͜·♡\n來杯「黑霸烏龍奶」提前進入𝐇𝐨𝐥𝐢𝐝𝐚𝐲 𝐌𝐨𝐝𝐞\n給準備放假的你，一個剛好的理由\n\n#限時優惠 𝟎𝟐.𝟎𝟗 - 𝟎𝟐.𝟏𝟑 ─── .✦.\n聯名限定．#黑霸烏龍奶 限時買❶送❶！\n烏龍奶茶暗藏火力，遇上波霸的甜蜜攻擊\n猶如出拳前的蓄勢待發！一口引爆烈焰\n\n假期來臨！就讓「黑霸烏龍奶」來開場！\n\n．活動限來店；每人限購2組。\n．本優惠不得與其他優惠併用。\n\n#電影 #功夫 #九把刀作品\n#0213全台盛大上映	2026-02-02 00:00:00	80
101	1	IG	黑霸烏龍奶	電影的狠勁，都在 #黑霸烏龍奶 內！\n不張揚，卻很有立場 ────────.✦.\n\n九把刀執導並改編自同名小說🧨\n最擅長的熱血情感與逆襲快感\n揭開九把刀宇宙的華麗篇章 .ılı.lı.ıl\n\n把故事裝進手裡的「黑霸烏龍奶」\n燃起內心無限可能，登頂功夫之巔！\n\n一馬當先、霸氣開春！𝟎𝟐.𝟏𝟑戲院見🎞️\n\n#電影 #功夫 #九把刀作品\n#0213全台盛大上映	2026-01-21 00:00:00	40
102	1	IG	黑糖波霸秘煉𝟏𝟐𝟎分	黑糖波霸秘煉𝟏𝟐𝟎分，層層吸收黑糖精華\n與烏龍奶茶正面交鋒！沉穩茶香隨奶香釋放~\n焙香、奶香暗藏火力，濃烈不失細膩\n\n九把刀最強奇幻動作電影《功夫》\n配上用真功夫製作的「黑霸烏龍奶」\n聯手來場充滿力量的手搖體驗！\n\n𝟎𝟐.𝟏𝟑 - 𝟎𝟑.𝟎𝟖 ─.✦.───\n憑當月份《功夫》電影票根\n享「黑霸烏龍奶」#現折10元優惠 ◡̎\n\n𝟎𝟐.𝟎𝟗 - 𝟎𝟐.𝟏𝟑 ─.✦.───\n購買「黑霸烏龍奶」即享 #買1送1\n\n．每張票根限折乙杯。買一送一限購2組。\n．活動限來店；不得與其他優惠併用。\n\n#電影 #功夫 #九把刀作品\n#0213全台盛大上映	2026-01-16 00:00:00	19
103	1	IG	蜜桃胭脂紅茶	即將迎來新年第一天，好心情一起打包◡̎\n\n𝟐𝟎𝟐𝟔.𝟎𝟏.𝟎𝟏 #元旦限定 —————\n▹ ▸ 蜜桃胭脂紅茶〔買一送一〕.ᐟ\n\n#蜜桃胭脂紅茶𝐏𝐞𝐚𝐜𝐡 𝐁𝐥𝐚𝐜𝐤 𝐓𝐞𝐚\n桃香與茶香完美並存的單品紅茶\n淡淡香氣有如剛摘下的蜜桃，沿途留香\n\n新的一年，一起舉杯歡慶\n感受到茶香細膩，輕盈清爽～\n\n．每人限購乙組。活動限來店\n．優惠不得合併使用。數量有限售完為止\n\n#元旦 #新年快樂 #HappyNewYear	2025-12-31 00:00:00	13
104	1	IG	雙饗茶會	＼聖誕節快樂！／𝐌𝐞𝐫𝐫𝐲 𝐂𝐡𝐫𝐢𝐬𝐭𝐦𝐚𝐬 🎄🔔\n\n濃濃的聖誕氛圍，剛剛好就很溫暖！\n用一杯柔順的拿鐵，還有一杯清爽的茶，\n將忙碌拋在腦後，把美好留給自己吧◡̎\n\n#雙饗茶會 ❭❭❭  𝐓𝐄𝐀+𝐋𝐀𝐓𝐓𝐄 享組合優惠✨\n讓冬天過得更溫暖，以茶相聚，歡慶聖誕！\n\n．活動不得與其他優惠合併使用\n\n#KUNGFUTEA功夫茶 #功夫茶 ＃雙饗茶會	2025-12-24 00:00:00	8
105	1	IG	KUNGFUTEA功夫茶	氣溫急速下降，早晚溫差大 ❆\n回家路上，迎面而來的冷風 🌬️\n身體忍不住顫抖，寒意包裹全身\n\n來杯熱飲，身體立刻暖起來\n讓疲憊和寒意一起消散 ❤️‍🔥\n\n回家路上喝拿鐵，暖身也暖心\n到家喝原茶配上豐盛的晚餐 🥃\n雙重享受，迎接美好的夜晚 ෆ\n\n✧𝟏𝟏.𝟎𝟏-𝟎𝟏.𝟏𝟏｜雙饗茶會 組合優惠價✧\n𝐏𝐚𝐢𝐫 + 𝐒𝐡𝐚𝐫𝐞，各選一杯，幸福加倍\n\n※活動限來店、自取、外送、享什麼\n※活動不得與其他優惠併用\n\n#KUNGFUTEA功夫茶 #功夫茶 #雙響茶會	2025-11-24 00:00:00	9
106	1	IG	岩葉紅茶拿鐵	不同風味的飲料，代表不同的心情 ◡̎\n幫你找到最適合今日心情的組合 .ᐟ\n\n❣️𝟏𝟏.𝟎𝟏-𝟎𝟏.𝟏𝟏｜雙饗茶會❣️\n𝐏𝐚𝐢𝐫 + 𝐒𝐡𝐚𝐫𝐞，各選一杯，享優惠價\n\n𝐏𝐚𝐢𝐫 ｜原境茶選\n𝐒𝐡𝐚𝐫𝐞｜醇厚拿鐵\n岩葉紅茶拿鐵 ꕤ 烏龍觀音拿鐵 ꕤ 蜜桃胭脂拿鐵\n\n꒰ 隱山烏龍 × 烏龍觀音拿鐵 ꒱\n最適合想要獨處、沉澱心情的你\n沉穩安定的茶香，忙碌後優雅慢下腳步\n\n最適合缺乏活力、急需朋友慰藉的你\n與好友暢聊、釋放壞情緒的最佳能量飲品\n\n#隱山烏龍 #雙饗茶會 #優惠活動	2025-11-06 00:00:00	5
107	1	IG	38奶霸	萬聖節就喝這杯，不喝就搗蛋 .ᐟ.ᐟ\n𝑻𝒐𝒑 𝑷𝒊𝒄𝒌 ✧ 38 奶霸 ✧ 超有料\n\n最黑的夜空揉成焦糖圓球 𖣐\n點綴上晶瑩寶石、黑夜濃霧\n喝一口，幸福感爆棚，超滿足 ෆ\n\n 𝓗𝓐𝓟𝓟𝓨  𝓗𝓐𝓛𝓛𝓞𝓦𝓔𝓔𝓝 \n꒦꒷꒦꒷꒦꒷꒦꒷꒦꒷꒦꒷꒦꒷꒦꒷꒦꒷꒦꒷꒦꒷꒦꒷\n\n#KUNGFUTEA功夫茶 #功夫茶 #萬聖節	2025-10-30 00:00:00	10
108	1	IG	隱山烏龍	連假出遊，熱到快融化\n真想來杯沁涼解渴的飲料 .ᐟ\n\n꒰ 隱山烏龍 ꒱ 𝓷𝓮𝔀\n茶香四溢，順口不苦澀\n冰涼清爽，一掃身體的燥熱 ❆\n無糖限定，感受最純粹的茶香♡\n\n隱山烏龍・沁涼上市\n是你連假出遊的最佳夥伴 ✧˚.\n\n#隱山烏龍 #無糖茶 #國慶日	2025-10-09 00:00:00	9
109	1	IG	品牌日常/無特定飲品	＼買一送一 ✫ 中秋連假限定 .ᐟ	2025-10-03 00:00:00	7
110	2	IG	柳橙翡翠青	#柳橙翡翠青 #經典回歸\n剛剛好，你也還在\n剛剛好，我也沒變\n我們一起等到——\n柳橙最剛好的時刻\n這不是提早，也不是將就\n而是等到果香最飽滿、酸甜最平衡\n才願意端出的那一杯\n這份陽光下的鮮甜美好\n是去年度季節限定 No.1 的回憶\n也是今年，終於等到的完美風味\n我們再一次，回味重遊\n柳橙翡翠青\n1/26（一）全台經典回歸上市\n嚴選鮮甜柳橙\n搭配沁涼爽口的翡翠青茶\n在柳橙最佳成熟時刻榨取\n完整保留果香層次與清爽茶韻\n年度好評敲碗回歸 !\n｜大茗官方網站｜https://www.damingtea.com.tw\n#大茗本位製茶堂 #柳橙翡翠青經典回歸	2026-01-23 00:00:00	573
111	2	IG	懷舊經典奶茶	#\n#啟動年末微醺儀式 #莓醉雙奏章幸福聯乘\n#勤美誠品綠園道限定 #聯名酒精飲特調\n草莓飲品喝不夠要再來點Chill的嗎\n我們從上波爵士音樂節的茶酒特調再次昇華\n這波莓醉的幸福耶誕禮，明日起限定開喝\nDAMING X Teapsy 丨 莓醉雙奏章\n12/24(三) - 12/31(三) 限時8天\n⭓ 莓醉玉露 / 4% vol. / ★★★★★\n(玉露奶青/草莓果釀/原萃青茶茶酒)\n細緻奶青交織甜蜜草莓果香\n滿滿草莓奶酒的微醺清甜\n⭓ 莓醺奶紅 / 4% vol. / ★★★★★\n(懷舊經典奶茶/草莓果釀/原萃紅茶茶酒)\n濃郁的古早味奶紅配上草莓甜酸\n溫潤迷人～莓醉又回味的Chill\n/ / /\n* 未滿18歲禁止飲酒\n* 喝酒不開車，安全有保障\n大茗本位製茶堂丨勤美誠品綠園道店\n地址：台中市西區公益路68號B1\n電話：04-2321-0823\n｜大茗官方網站｜https://www.damingtea.com.tw\n莓醉雙奏章 丨 限定聯名酒精飲特調\n@daming_tea @teapsyco_official	2025-12-23 00:00:00	205
112	2	IG	大茗本位製茶堂	#莓光甜室\nSweet Berry Moments\n12/10(三)全台新品上市\n讓每一天，\n都有一點柔軟的甜。\n融進口裡，收在心裡\n｜大茗官方網站｜https://www.damingtea.com.tw\n#草莓要來了 #就是下周\n#大茗本位製茶堂	2025-12-02 00:00:00	164
113	2	IG	芒果青	#芒果青 #青熟感限定茗作\n熱烈加開！熱烈加開！\n這杯獻給你，用芒果的酸甜填滿日常的空隙。\n喝過才知道，大茗的味道真的上癮\n在地芒果細火慢熬出的天然熟果香，\n喝過的都驚嘆 限量開賣再擴大開催～～\n手工芒果醬 ✕ 翡翠青茶\n11/14(五)起 中區、彰化、嘉義、斗六門市限量開喝！\n｜大茗官方網站｜https://www.damingtea.com.tw/\n#芒果青 #指定區域門市開喝\n#大茗本位製茶堂	2025-11-11 00:00:00	52
114	2	IG	芫荽酪梨奶蓋	這個萬聖節，不搞怪也能很有戲\n芫荽與酪梨攜手施展綠色魔法，三款奶蓋茶限時登場，\n每一口都是萬聖夜的神秘咒語——清香、焙香、還有一點暗夜的驚喜\n萬聖限定・芫荽酪梨奶蓋系列\n2025/10/31-11/2\n綠茶｜清新登場\n清爽綠茶遇上芫荽酪梨奶蓋，淡雅香氣裡帶點意外驚喜\n蕎麥｜焙香現身\n焙香蕎麥融合草本奶蓋的柔滑，香氣溫潤，喝起來很舒服\n烏龍｜暗夜限定\n炭焙茶香交織酪梨奶香，層次豐富又細膩\n每日限量供應\n限現場購買\n可先來電門市詢問\n｜大茗官方網站｜https://www.damingtea.com.tw/\n#大茗新品上市 #萬聖節限定 #芫荽酪梨奶蓋\n#大茗本位製茶堂	2025-10-28 00:00:00	1651
115	2	IG	芒果青	#芒果青 #青熟感限定茗作\n#北區南區第二波指定門市開喝🤩\n熱烈加開！熱烈加開！🎉🎉\n這杯獻給你，也許你心裡的洞能被填滿一點？\n大茗你就愛了吧！哪次不愛🫰\n在地芒果細火慢熬出的天然熟果香\n喝過的都驚嘆🔥第二波指定店限量販售開催～～\n📍手工芒果醬 ✕ 翡翠青茶\n📍10/23(四)起第二波區域門市限量開喝\n📍指定販售門市\n👉北區指定門市\n台北公館 / 台北內湖 / 桃園藝文\n新竹城隍 / 新竹金山 / 竹南博愛\n👉中區指定門市\n勤美模範 / 台中高工 / 台中水湳\n逢甲西屯 / 逢甲福星 / 漢口青海\n* 11/14(五)起中區全門市供應\n👉南區指定門市\n台南中正 / 台南中華\n高雄至聖 / 高雄自強 / 高雄裕誠\n高雄文化 / 高雄楠梓 / 高雄岡山\n｜大茗官方網站｜https://www.damingtea.com.tw/\n#芒果青 #第二波指定區域門市開喝\n#大茗本位製茶堂	2025-10-22 00:00:00	63
116	2	IG	大茗本位製茶	雙十快樂，一起乾杯吧！\n十月的陽光有點甜，\n十月的風也帶著好心情～\n在這充滿喜慶的日子裡，\n不妨停下腳步，來杯好茶放鬆一下\n我們國慶日不打烊\n手搖好茶隨時待命，\n無論是沁涼鮮果、濃郁奶香，\n都讓幸福在舌尖綻放\n秋意漸濃，早晚記得加件外套，\n祝大家都能度過溫馨的雙十連假～\n｜大茗官方網站｜https://www.damingtea.com.tw/\n#大茗本位製茶 #雙十節快樂	2025-10-10 00:00:00	44
117	2	IG	珈琲粉粿蕎麥奶	✨DAMING | Happy Moon Festival🌕🎑\n中秋烤肉聚餐，解膩神隊友必不可少🔥\n#玉露青茶 —— 清爽解膩、涼意滿滿\n#熟成油切蕎麥 —— 助你油膩OUT、暢快加倍\n想換換口味也可以點\n#珈琲粉粿蕎麥奶 —— 一口濃郁烘焙香氣，一口滑順溫柔的老派浪漫。\n\n#珍珠粉粿牛奶 ——珍珠＋粉粿＝雙重咬感爆擊！雙料大滿足\n\n聚會來上一杯，中秋就更圓滿。\n㊗️大家中秋節快樂🌝🎉\n｜大茗官方網站｜https://www.damingtea.com.tw/\n\n#大茗本位製茶堂 #中秋節快樂	2025-10-05 00:00:00	47
118	2	IG	芒果青	細火慢熬，以手作果醬入茶\n#芒果青 #青熟感限定茗作\n#台中首波指定門市上車囉👏\n嚴選台灣在地芒果，手作慢熬釋放天然果香，\n以黃金比例入茗翡翠青，果香與茶韻完美交織。\n清爽回甘、果甜不膩\n📍青熟感限定茗作 手工芒果醬✕翡翠茶\n📍9/19(五)起指定區域首波限量開喝\n📍指定販售門市\n勤美模範 / 台中高工\n台中水湳 / 逢甲西屯\n逢甲福星 / 台中大雅\n漢口青海 / 勤美誠品\n嘉義民族\n｜大茗官方網站｜https://www.damingtea.com.tw/\n#大茗新品上市 #芒果青\n#大茗本位製茶 #台中首波上市\nv	2025-09-17 00:00:00	149
119	2	IG	珈琲粉粿蕎麥奶	#七夕\n用一杯飲料，說盡我想對你說的情話\n\n#珈琲粉粿蕎麥奶\n牛郎織女一年見一次，\n我要的是和你天天共享一杯老派的浪漫。\n\n#珍珠粉粿牛奶\n你是珍珠，我是粉粿，\n我們加在一起就是最對味的愛情。\n\n今年七夕，就用Ｑ彈的「 老派浪漫」告白，\n𝘁𝗮𝗴 你最想共享一杯的他/她 ♡\n\n\n#七夕 #七夕情人節 #老派靈魂新派味道\n#大茗新品 #珈琲粉粿蕎麥奶 #珍珠粉粿牛奶\n#大茗本位製茶堂 #新品上市	2025-08-29 00:00:00	57
120	3	IG	芝士奶蓋緋烏龍	身處湧動時代📀復古卻成了新語言\n偕茶師重新對焦\n#緋烏龍系列 再次加載登場！\n全新風味升級：首次加入緋烏龍、馥莓緋烏龍🫐\n在新與舊之間\n注入靈魂播放昔日回憶\n緋紅序曲已揭幕\n邀你舉杯，共襄年末盛宴🪩✨\n.\n> .collection - "𝓡ed Oolong Tea 緋烏龍系列"\n[0]  緋烏龍........................M 35｜L 40\n[1]  馥莓緋烏龍................M 50｜L 60\n[2]  緋烏龍奶茶................M 50｜L 55\n[3]  緋烏龍鮮奶................M 60｜L 70\n[4]  芝士奶蓋緋烏龍........M 55｜L 65\nSTATUS: 全門市販售中	2025-12-17 00:00:00	98
121	3	IG	芝士奶蓋緋烏龍	𝑪𝒉𝒂𝒑𝒕𝒆𝒓 𝟎𝟒｜芝士奶蓋緋烏龍  Cheese Milk Foam 𝓡ed Oolong Tea\n收音機嗡嗡作響\n戴上耳機隔出一片自在zone\n音符在空氣跳躍\n鹹香芝士奶蓋\n佐緋烏龍獨有熟果前調及蜜香喉韻\n滋味醇厚、回甘悠長\nVolume up ! 𝓡eloading on 𝟏𝟐/𝟏𝟕 （﹙˓ 🎧˒﹚）	2025-12-12 00:00:00	109
122	3	IG	緋烏龍鮮奶	𝑪𝒉𝒂𝒑𝒕𝒆𝒓 𝟎𝟑｜緋烏龍鮮奶 𝓡ed Oolong Tea Latte\n調整焦距，緋紅身影漸漸清晰\n熟果基調揉合烏龍韻\n奶香柔潤細膩\n覆蓋舌尖\n每口都是風味的細膩映像\n帶著去年的悸動\n回憶幀幀重現，逐格展開\nKeep rolling ! 𝓡eloading on 𝟏𝟐/𝟏𝟕	2025-12-11 00:00:00	89
123	3	IG	馥莓緋烏龍	𝑪𝒉𝒂𝒑𝒕𝒆𝒓 𝟎𝟐｜馥莓緋烏龍 Berrys 𝓡ed Oolong Tea\n循電波傳遞酸甜訊號💓▶• ılıılıılılıılıılı. 0\n紫桑率先登場\n緋烏龍沉靜其後，釋放熟果木質溫潤\n再以覆盆子微酸收束\n莓緋色澤\n內斂卻蘊藏深意\n以嫣紅映照明媚冬日與土地回甘\nDon’t hang up! 𝓡eloading on 𝟏𝟐/𝟏𝟕 📆	2025-12-10 00:00:00	90
124	3	IG	緋烏龍	𝑪𝒉𝒂𝒑𝒕𝒆𝒓 𝟎𝟏｜緋烏龍 𝓡ed Oolong Tea\n指尖穿梭光影翩然敲打，緋紅色溫於膠卷顯影🎞️\n#緋烏龍 ｛ 𝖿ē𝗂 𝗐𝗎𝗅ó𝗇𝗀｝ 選用台東紅烏龍，以夏秋茶葉為本結合紅茶加工特點，採重發酵製成，果韻滋味明亮飽滿。\n因水色呈現橙紅色澤而得名，一入口就能感受熟果及木質圓潤香氣，風味甘甜且喉韻悠長，紅韻入杯紅玉香、烏龍韻，香氣縈繞層次分明。\n今年！原茶款首次加入，風味純粹卻足以撩動心弦 𝓡eloading on 𝟏𝟐/𝟏𝟕 📆	2025-12-09 00:00:00	71
125	3	IG	青檸甘蔗蕎麥綠寶	月夕初見，跨越世代的相聚🌔\n在舉杯之間\n分享澄黃如月的酸甜滋味\n🍋‍🟩青檸甘蔗蕎麥綠寶 Lemon with Cane Green Rooibos Tea\n甘蔗汁佐青檬，平衡中秋的豐盛味蕾\n#無咖啡因 在月夜輕柔裡\n大人孩童安心共飲\n𝗢𝗥𝗗𝗘𝗥 ➡︎ https://lihi.cc/QvWof/預約外送自取	2025-10-03 00:00:00	131
126	3	IG	一畝蕎麥田	一畝蕎麥田，掬起穗香與青草香\n蕎麥為引，綠國寶茶基底\n初飲入喉是自然麥香\n伴隨穀物焙炒的濃郁\n深淺流轉，隨穗浪輕伏\n在漸入回甘之際\n漫出綠國寶茶的大地青草香\n喉韻清香淡雅，悠香不息\n蕎麥綠寶 𝘎𝘳𝘦𝘦𝘯 𝘙𝘰𝘰𝘪𝘣𝘰𝘴 𝘛𝘦𝘢 𝘚𝘦𝘳𝘪𝘦𝘴\n金粹·馥莓·青檸甘蔗 ⟢全門市販售中	2025-09-18 00:00:00	237
127	3	IG	碧綠金澄	更迭沉潛，大地悄悄甦醒\n陽光鋪展金光覆滿田野、碧綠金澄\n化身不同花色地毯\n✦\n𝘎𝘳𝘦𝘦𝘯 𝘙𝘰𝘰𝘪𝘣𝘰𝘴 𝘛𝘦𝘢 𝘚𝘦𝘳𝘪𝘦𝘴 蕎麥綠寶系列\n風味穀香淡雅、溫潤回甘\n8/27 清爽上市	2025-08-25 00:00:00	157
128	3	IG	蕎麥綠寶	全新零咖啡因飲\n8.27 (三) 全門市 𝘤𝘰𝘮𝘪𝘯𝘨 𝘴𝘰𝘰𝘯\n𝘎𝘳𝘦𝘦𝘯 𝘙𝘰𝘰𝘪𝘣𝘰𝘴 𝘛𝘦𝘢 𝘚𝘦𝘳𝘪𝘦𝘴 蕎麥綠寶系列\n✦\n喚醒盛夏氣息\n以青檸鮮榨原汁，融合甘蔗自然甜韻 .ᐟ\n酸沁於舌尖、口感明亮奔放\n推薦微微糖至半糖\n酸甜恰好\n青檸甘蔗蕎麥綠寶\nLemon with Cane Green Rooibos Tea\n𝙈 𝟳𝟱・𝙇 𝟴𝟱	2025-08-22 00:00:00	156
129	3	IG	莓果嫣紅	莓果嫣紅，酸甜恰如其分💫\n桑葚馥郁揭開序幕\n藍莓柔甜綻放\n覆盆子淡淡微酸輕盈收束\n揉合蕎麥綠國寶，果韻清亮莓香沁人\n馥莓蕎麥綠寶 Berrys Green Rooibos Tea\n𝙈 𝟱𝟱・𝙇 𝟲𝟱\n🌾\n✦ 零咖啡因系列 ✦\n蕎麥綠寶 𝘎𝘳𝘦𝘦𝘯 𝘙𝘰𝘰𝘪𝘣𝘰𝘴 𝘛𝘦𝘢 𝘚𝘦𝘳𝘪𝘦𝘴\n8.27 (三)  全台同步上市	2025-08-21 00:00:00	216
130	4	IG	新年喝好茶	新的一年，願每一步都奔向更好的風景。\n用一杯好茶，陪伴大家迎接嶄新的新年時刻。\n限量設計，只為今年的相遇，\n不只是喝茶，更是一份祝福、一份陪伴。\n願馬年——\n馬到成功 茶香常在 好運滿杯\n#先喝道 #馬年限定杯 #新年喝好茶 #馬到成功 #陪你走過每一個新開始 #把世界放在一杯茶中 #嚴選世界好茶 #TAOTAOTEA #精品茶 #ITQI得獎茶 #手搖飲 #手搖推薦 #古典玫瑰園 #下午茶時間	2026-02-10 00:00:00	24
131	4	IG	英式玫瑰特調茶	💝 2/13 情人節限定｜玫瑰系必喝 💝\nHAPPY FRIDAY｜𝟮/𝟭𝟯 情人節必喝  玫瑰限定    玫瑰水、英式玫瑰拿鐵 第二杯10元\n懂茶的人，最懂怎麼說愛。\n在玫瑰盛開的季節，\n用一杯花香，替情人節加點溫柔的儀式感。\n🌹 玫瑰水｜把浪漫喝進日常\n使用 先喝道自製玫瑰露調製，無人工甜味劑、無防腐劑，\n清透順口、輕柔不膩，細緻花香在舌尖停留，為日常增添浪漫。\n\n🫖 英式玫瑰拿鐵｜專屬午後的溫柔告白\n以斯里蘭卡莊園紅茶為基底，搭配米其林ITQI 2星認證絕佳風味好茶英式玫瑰特調茶，層層融入奶香與玫瑰香，溫潤柔和，完美午後茶時光必備。\n\n快揪朋友一起喝，讓玫瑰香點亮你的週五！✨\n\n⚠️活動注意事項⚠️\n𝟭.每人限購3組\n𝟮.限現場/你訂自取 (優惠活動不合併使用)\n𝟯.各門市數量有限，售完為止\n#先喝道 #把世界放在一杯茶中 #嚴選世界好茶 #TAOTAOTEA #精品茶 #ITQI得獎茶 #手搖飲 #手搖推薦 #古典玫瑰園 #下午茶時間	2026-02-08 00:00:00	118
132	4	IG	蜂蜜四季春茶	有些茶，不需要多說，\n一入口，就知道為什麼會被反覆點名。\n\n四季春茶王\n米其林級ITQI最高3星認證絕佳風味，第一口是清亮的茶湯，接著花香慢慢在口中散開，尾韻回甘，是一杯會讓人默默一直喝下去的經典。\n\n蜂蜜四季春茶\n清新的四季春茶香先到，隨後蜂蜜的溫潤甜感，柔和不膩，口感圓順，每一口都輕盈愉悅\n好茶獻給懂喝的人，全台先喝道，隨時享受。\n\n2/6限定｜四季春茶王第二杯半價、蜂蜜四季春茶第二杯10元\n\n活動注意事項\n𝟭.每人限購3組\n𝟮.限現場/你訂自取 (優惠活動不合併使用)\n𝟯.各門市數量有限，售完為止\n#先喝道#把世界放在一杯茶中#嚴選世界好茶#TAOTAOTEA#精品茶#ITQI得獎茶#手搖飲#手搖推薦#古典玫瑰園#下午茶時間	2026-02-04 00:00:00	7
133	4	IG	蜂蜜四季春茶	HAPPY FRIDAY｜四季春系列 (ITQI 3星得獎茶) 指定飲品優惠\n\n懂喝茶的人都知道，\n四季春的魅力，在那一口清爽花香與回甘之間。\n\n先喝道-四季春茶王(ITQI 3星得獎茶)\n選用台灣優質茶葉，茶湯清透、口感輕盈，\n自然花香在舌尖綻放，回甘乾淨不厚重，\n是一杯每天都喝不膩的經典好茶。\n\n蜂蜜四季春茶\n以四季春為基底，加入香甜蜂蜜，\n茶香依舊清爽，尾韻多了一抹溫潤甜感，清新柔和、順口耐喝。\n\n2/6限定｜四季春茶王第二杯半價、蜂蜜四季春茶第二杯10元\n\n活動注意事項\n𝟭.每人限購3組\n𝟮.限現場/你訂自取 (優惠活動不合併使用)\n𝟯.各門市數量有限，售完為止\n#先喝道 #把世界放在一杯茶中 #嚴選世界好茶 #TAOTAOTEA #精品茶 #ITQI得獎茶 #手搖飲 #手搖推薦 #古典玫瑰園 #下午茶時間	2026-02-01 00:00:00	20
134	4	IG	把世界放在一茶中	馬年到，好運轉起來！\n過年就是要有儀式感\n馬年新春限定杯正式上市啦！\n旋轉木馬的童趣設計，搭配奔馳的駿馬意象，\n象徵勇往直前、好運連連、事事馬到成功\n先喝道-新年換新杯，喝的每一口都是滿滿年味～\n不管是自己收藏，還是送禮，都超有儀式感\n馬年限定・數量有限\n拿在手上，年味直接拉滿\n#馬年 #新年新品 #先喝道 #把世界放在一杯茶中 #嚴選世界好茶\n#TAOTAO_TEA #精品茶 #ITQI得獎茶 #手搖飲 #手搖推薦 #古典玫瑰園 #下午茶時間 #新春必收 #過年就是要有儀式感	2026-01-31 00:00:00	73
135	4	IG	把世界放在一茶中	當世界太吵的時候，\n不妨慢下來，\n把世界放進一杯茶裡。\n\n輕焙榖麥茶——\n像是一封焙火寫給大地的情書。穀麥在低溫中慢慢甦醒，香氣不張揚，卻在杯中繾綣不散；入口是溫柔的穀香與淡淡烘焙甜，讓心也跟著安靜下來。\n\n榮獲\n**2024 比利時布魯塞爾 iTQi 美食評鑑「最佳風味好茶」得獎茶款。\n\n#先喝道 #把世界放在一杯茶中 #輕焙榖麥茶 #嚴選世界好茶 #iTQi得獎茶 #英式下午茶 #古典玫瑰園	2026-01-29 00:00:00	28
136	4	IG	英式玫瑰拿鐵	當午後的光線變得柔軟，就讓一杯花香，慢慢展開\n🌹玫瑰水\n清透順口、輕柔不膩，細緻的玫瑰香氣，\n在入口之間輕輕停留，芬芳綻放為日常增添浪漫。\n🫖英式玫瑰拿鐵\n在溫潤茶香中，玫瑰悄然綻放，\n與柔和奶香層層相融，完美的恰到好處。\n週五讓這份剛剛好的玫瑰風味伴隨茶香陪你一起迎接浪漫午茶時光\n🎁1/30限定｜玫瑰水第二杯半價、玫瑰拿鐵中杯(Ｍ)49元第二杯半價\n⚠️活動注意事項⚠️\n𝟭.每人限購3組\n𝟮.限現場/你訂自取 (優惠活動不合併使用)\n𝟯.各門市數量有限售完為止\n#先喝道 #TAOTAOTEA #手搖飲 #好茶 #米其林 #四季春茶王 #台灣四大名茶 #嚴選世界好茶 #英式下午茶 #英國茶 #台灣茶 #手搖推薦 #古典玫瑰園	2026-01-28 00:00:00	28
187	9	IG	四季春青茶	本月主打 #珍波椰青茶ヽ(●´∀`●)ﾉ\n季主打嵐a青春～必喝品項\n#超值組合 滿滿配料珍波椰直接抵一餐\n#清爽暢飲 經典四季春青茶清香又回甘\n不說了！阿嵐要手刀去買一杯～\n#50嵐 #50嵐中區 #好茶陪伴你的日常 #手搖 #飲料 #春季主打 #嵐a青春 #珍波椰青茶	2024-05-06 00:00:00	167
137	4	IG	好茶	睽違已久，金杯烏瓦系列1/17 日起驚喜回歸\n在那段消失的日子裡，我們收到了無數敲碗與想念。\n\n這一次，經典傳奇終於再次於 18 間門市期間限定復活。\n\n選用世界三大紅茶之一的斯里蘭卡烏瓦紅茶（Uva Tea）作為基底，來自知名烏瓦高地。 在優雅的香草清香中開場，隨後是沉穩的麥芽香氣入喉， 尾韻散發出甜美的柑橘芬芳，與細緻奶香交織出如絲綢般的溫潤。\n\n這一杯，是送給老朋友最溫暖的重逢禮，\n也誠摯邀請新朋友，與我們一起開啟這場層次豐富的味覺。\n\n如果你還沒試過這份傳奇味道，這次，請別再擦肩而過。\n\n回歸日期：\n1/17 (六) 起 ，全台18間門市限定販售，數量有限，售完為止\n\n販售門市：\n台南新營、嘉義興業、台南民族、梧棲文化、台中嶺東、台中大甲、台南新市、台中向心、新竹南大、台中潭子、沙鹿中山、龍井中央、林口長庚、北投石牌、桃園青埔、中科永福、屏東廣東、仁武京吉\n\n#先喝道 #TAOTAOTEA #手搖飲 #好茶 #米其林 #金杯烏瓦 #世界三大紅茶 #嚴選世界好茶 #英式下午茶 #英國茶 #台灣茶 #手搖推薦 #古典玫瑰園	2026-01-17 00:00:00	48
138	4	IG	太妃蜜桃風味厚奶霜	期間限定！消失的驚喜味道，1/17 日起限定回歸 🏆\n還記得那口驚艷味蕾、帶有迷人香草氣息的「金杯烏瓦系列」嗎？\n在無數粉絲的敲杯後，我們決定讓它期間門店限定復活了！\n選用世界三大紅茶之一的斯里蘭卡烏瓦紅茶（Uva Tea）作為基底，來自知名烏瓦高地。\n以優雅的香草清香揭開序幕，隨後濃厚的麥芽香氣沉穩入喉，\n尾韻透出甜美的柑橘風味，與細緻奶香交織，\n層層堆疊出香醇濃郁、溫潤不膩的經典茶韻。\n\n📅 回歸日期：\n1/17 (六) 起 ，全台18間門市限定販售，數量有限，售完為止\n📍 販售門市：\n台南新營、嘉義興業、台南民族、梧棲文化、台中嶺東、台中大甲、台南新市、台中向心、新竹南大、台中潭子、沙鹿中山、龍井中央、林口長庚、北投石牌、桃園青埔、中科永福、屏東廣東、仁武京吉\n\n🎁 1/16即將登場｜買太妃蜜桃風味厚奶霜送蜜桃風味茶一杯\n\n#先喝道 #TAOTAOTEA #手搖飲 #好茶 #米其林 #金杯烏瓦 #世界三大紅茶 #嚴選世界好茶 #英式下午茶 #英國茶 #台灣茶 #手搖推薦 #古典玫瑰園	2026-01-14 00:00:00	193
139	4	IG	四季春茶王	🌿山嵐間的花香與回甘，是被米其林記住的味道 🌿\n什麼樣的茶，能讓國際評審點頭認證？\n\n從台灣優質茶園出發，茶湯清透、花香自然，\n入口輕盈不苦澀，尾韻帶著乾淨回甘，越喝越順，\n透過職人細緻的製茶工藝，把茶葉最純粹的風味完整留下。\n\n也因為這份對風味的堅持，讓它獲得國際評審一致肯定，\n榮獲食品界米其林 iTQi 三星認證。\n\n這不只是一杯日常手搖飲，而是一杯被世界記住的 台灣好茶。\n不用特地上山尋找，先喝道全台門市，就能喝到這杯嚴選世界好茶\n🍃四季春茶王\n\n#先喝道 #TAOTAOTEA #手搖飲 #好茶 #米其林 #四季春茶王 #台灣四大名茶 #嚴選世界好茶 #英式下午茶 #英國茶 #台灣茶 #手搖推薦 #古典玫瑰園\n清心福全	2026-01-13 00:00:00	12
140	4	IG	厚雪奶蓋	【厚雪奶蓋系列 新品上市 #指定門市 試賣中】\n口感綿密，像雪一樣輕柔的「厚雪奶蓋」\n讓人忍不住一口接一口，快來清心點一杯！\n厚雪‧烏龍奶蓋\n甘醇的烏龍綠茶，頂層覆蓋「厚雪」奶蓋，入口濃郁卻如初雪般輕盈不膩。\n厚雪‧頂級可可奶蓋\n頂級可可與「厚雪」奶蓋完美結合。奶蓋的淡雅奶香融入香醇可可，口感飽滿厚實。\n厚雪‧ 紅心芭樂奶蓋\n清香的紅心芭樂，頂端鋪滿一層「厚雪」奶蓋，每一口都能喝得到芭樂的香甜與柔滑綿密的奶蓋。\n只在指定門市才能喝到!!\n販售門市供應，請參見：https://reurl.cc/2lV2za\n清心福全據點搜尋：http://www.chingshin.tw/store.php	2026-01-06 00:00:00	421
141	4	IG	珍珠奶茶	告別 2025・迎接嶄新的一年\n清心福全陪你一起倒數，用熟悉的好味道迎接全新的開始\n【跨年必喝】優惠活動\n活動時間：12/31(三)～1/6(二)\n優惠內容：大杯指定飲品「第二杯折價10元」\n「珍珠奶茶」、「粉圓奶茶」、「椰果奶茶」和「錫蘭奶紅」\n活動注意事項：\n1.本優惠不得與其他優惠併用。\n2.僅適用於大杯指定飲品，且限來店自取。\n3.不適用於外送平台、外送及線上點餐。\n4.本公司保有解釋、修正與終止活動之權利。\n#清心福全 #優惠活動 #新年快樂 #手搖飲料 #2026	2025-12-29 00:00:00	2571
142	4	IG	白韻杏仁奶	冷氣團來襲，低溫拉警報，不想離開被窩就來杯能把冬天融化的「杏福滋味」吧！\n冬季新品【白韻杏仁系列】純淨的白更韻涵典雅韻味，將純淨的幸福感留在唇齒間，韻味無窮。\n#白韻杏仁頂級可可 $80：創新口味，將東方傳統風味的「杏仁粉」溶入頂級可可，雙重甜蜜滋味豪華升級。\n#白韻杏仁奶 $65：以南杏研磨的「特級杏仁粉」，搭配醇正香濃的「嚴選奶精」，每一口都是幸福細密的滑順口感。\n#白韻杏仁鮮奶 $85：以南杏研磨的「特級杏仁粉」，搭配鮮潤的「崙背鮮乳」，杏仁香與乳香完美結合，成就濃郁渾厚的極致口感。\n找回杏福，暖暖過冬，一起拒絕“冷暴力”\n更多資訊請鎖定 ：\n官方網站連結：https://www.chingshin.tw/\nInstagram連結：https://pse.is/M9RBB\nYouTube連結：https://bit.ly/2rtxr5o\n#清心福全 #手搖飲料 #新品登場 #冬季飲品 #暖暖過冬	2025-12-15 00:00:00	4353
143	4	IG	白韻杏仁奶	別讓冷空氣覆蓋了你的好精神，冬季新品上市，品嘗杏福滋味～\n冬季新品【白韻杏仁系列】純淨的白更韻涵典雅韻味，將純淨的幸福感留在唇齒間，韻味無窮。\n#白韻杏仁奶 $65：以南杏研磨的「特級杏仁粉」，搭配醇正香濃的「嚴選奶精」，每一口都是幸福細密的滑順口感。\n#白韻杏仁頂級可可 $80：創新口味，將東方傳統風味的「杏仁粉」溶入頂級可可，雙重甜蜜滋味豪華升級。\n同步推薦【經典冬季不敗飲品】 #珍珠琥珀黑糖鮮奶 #芝麻奶茶 #桂圓鮮奶茶\n找回杏福，暖暖過冬，一起拒絕“冷暴力”\n更多資訊請鎖定 ：\n官方網站連結：https://www.chingshin.tw/\nInstagram連結：https://pse.is/M9RBB\nYouTube連結：https://bit.ly/2rtxr5o\n#清心福全 #手搖飲料 #新品登場 #冬季飲品 #暖暖過冬	2025-11-18 00:00:00	3830
144	4	IG	茉綠茶凍拿鐵	清心福全×變種吉娃娃 連假超吉美食推薦\n連假少不了的吃吃喝喝，「超吉」搭配超過癮！\n吉凍套餐：脆皮吉排＆茉綠茶凍拿鐵，一口酥脆一口Q嗲嗲的絕妙搭配（￣︶￣）\n#清心福全 #手搖飲料 #變種吉娃娃 #連假限定 #茉綠茶凍拿鐵	2025-10-23 00:00:00	333
145	4	IG	荔枝蘋果醋	#雙十節快樂 十月連假第二彈\n又是一個三天連假，千萬別把好時光蹉跎掉了，\n來杯清心福全的 #荔枝蘋果醋 慶祝連假萬睡。\n更多變種吉娃娃資訊請鎖定 ：\n官方網站連結：https://www.chingshin.tw/\nInstagram連結：https://pse.is/M9RBB\nYouTube連結：https://bit.ly/2rtxr5o\n#變種吉娃娃 #清心福全 #手搖飲料 #小狗 #聯名活動	2025-10-09 00:00:00	433
146	4	IG	咖啡凍奶茶	#教師節快樂\n謝謝老師的用心教誨，在特別的日子裡加碼作業，\n來杯大人的滋味 #咖啡凍奶茶，苦甜苦甜才是人生。\n更多變種吉娃娃資訊請鎖定 ：\n官方網站連結：https://www.chingshin.tw/\nInstagram連結：https://pse.is/M9RBB\nYouTube連結：https://bit.ly/2rtxr5o\n#變種吉娃娃 #清心福全 #手搖飲料 #小狗 #聯名活動	2025-09-26 00:00:00	216
147	4	IG	珍珠琥珀黑糖鮮奶	來杯甜甜的，讀書就不會那麼辛苦了 ₊˚⊹♡\n#珍珠琥珀黑糖鮮奶 黑糖香氣滿滿～Q彈珍珠咬一口就超幸福\n#隱藏版 (珍珠蜂蜜鮮奶普洱) 甜而不膩～給你滿滿好心情\n讓清心飲料＆變種吉娃娃陪你收穫好成績！！\n#變種吉娃娃 #清心福全 #聯名活動 #手搖飲料 #小狗勾療癒陪伴	2025-09-23 00:00:00	279
148	4	IG	柳橙綠	這個夏天超吉喜歡喝涼涼的飲料～～\n香甜清爽的 #柳橙綠、 甜Q爽口的 #蜜桃凍紅茶、 酸甜活力的 #紅心芭樂優多，快來清心一口喝下你的新學期元氣，讓開學大吉大利！\n持續關注⇩⇩⇩\n官方網站連結：https://www.chingshin.tw/\nInstagram連結：https://pse.is/M9RBB\nYouTube連結：https://bit.ly/2rtxr5o\n#變種吉娃娃 #清心福全 #聯名活動 #手搖飲料 #可愛的小狗勾	2025-08-19 00:00:00	408
149	4	IG	情人茶	520 「莓」你不行的戀愛滋味\n#粉戀莓莓 像是她微笑時的甜\n#情人茶 像戀愛一樣清爽又讓人心動\n清心福全×三麗鷗男團 給你表白的勇氣\n今天不來一杯怎麼行？讓我們在清心一起心動！\n小編今天只幫你助攻到這～剩下的，就靠你自己加油啦\n更多資訊 ：\n官方網站連結：https://www.chingshin.tw/\nInstagram: https://reurl.cc/67Rn3Z\nYouTube連結：https://bit.ly/2rtxr5o\n#清心福全 #手搖飲料 #三麗鷗男團 #飲料推薦 #520莓你不行	2025-05-20 00:00:00	374
150	6	IG	香芋仙草綠茶拿鐵	涼涼的天適合暖暖的那一杯🥤\n冬天，就該給自己一杯迷客夏的暖心系熱飲👇\n🍫法芙娜可可鮮奶｜𝟭𝟬𝟬%法芙娜可可粉，入口滑順✨\n🤎靜岡焙焙鮮奶｜焙香濃郁，暖到心坎裡~\n🧋珍珠紅茶拿鐵｜𝗤 彈香甜，冬天熱熱喝更對味\n🌿香芋仙草綠茶拿鐵｜芋頭 x 仙草凍 x 綠茶，暖甜飽足感滿滿\n✨暖暖喝，好運暖暖暖~起來✨\n🔹現在買𝟮杯還能抽𝗶𝗣𝗵𝗼𝗻𝗲 𝟭𝟳等豪禮🍎\n🔹現場門市限定：熱門指定單茶&茶拿鐵組合價只要$𝟳𝟵(南)／$𝟴𝟵(北)\n🔹迷點自取限定：滿𝟮杯即贈「愛茶的牛」指定飲品電子兌換券乙張\n現在下單給自己一個暖心飲品👉https://reurl.cc/R9GaXZ\n活動詳見官網👉 https://reurl.cc/gnyg7X\n#迷客夏 #milksha #為了你嚴選每一杯\n#雀蘋中選週週抽 #iPhone抽獎\n#雙週門市驚喜第二彈 #迷點自取買二送一	2026-01-23 00:00:00	82
151	6	IG	茉莉原淬綠茶	你的迷客夏新春大禮包第二彈來襲🎁\n✨𝟭月份雙週限定驚喜✨𝗽𝗮𝗿𝘁 𝟮\n𝟭/𝟮𝟭 (三)~𝟮/𝟯(二)\n<門市現場購買>✨𝗔＋𝗕限定好康✨\n🔥𝗔 區 醇濃鮮奶茶(𝗟) ＋ 𝗕 區 愛茶的牛🔥\n組合價 $𝟳𝟵(南)／$𝟴𝟵(北)\n✨ 一次喝到 濃郁奶香 × 清爽茶韻\n鮮奶控＆茶控都滿足的雙杯組合 ✨\n醇濃鮮奶茶/愛茶的牛適用茶底：\n大正醇香紅茶/英倫伯爵紅茶/茉莉原淬綠茶/原片初露青茶/琥珀高峰烏龍\n新年好康連連~雙倍幸福一次喝😍\n📍 查詢鄰近門市享好康 https://reurl.cc/7Kr7bQ\n🔍 活動詳情請見官網 https://reurl.cc/EbaKAn\n#迷客夏 #milksha #為了你嚴選每一杯 #雙週門市驚喜第二彈	2026-01-20 00:00:00	166
152	6	IG	茉香綠茶拿鐵	你的迷客夏新春大禮包已送達\n𝟭月份雙週限定驚喜第一彈\n即日起~𝟭/𝟮𝟬(二)\n<門市現場購買>任𝟮杯全系列飲品\n即可享加購$𝟯𝟵茶拿鐵(𝗠)𝟭杯\n𝟯𝟵元就能享受迷人的奶香茶韻\n活動加購茶拿鐵適用品項：\n大正紅茶拿鐵/伯爵紅茶拿鐵/茉香綠茶拿鐵/原片青茶拿鐵/琥珀烏龍拿鐵\n新年好康連連，別錯過這一杯\n立即前往鄰近門市享優惠 https://reurl.cc/7Kr7bQ\n活動詳情請見官網 https://reurl.cc/EbaKAn\n#迷客夏 #milksha #為了你嚴選每一杯 #雙週門市驚喜第一彈	2026-01-09 00:00:00	78
153	6	IG	醇濃茶拿鐵派	迎接 𝟮𝟬𝟮𝟲 倒數計時！誰陪你跨年?!\n在煙火綻放的那一刻，\n手裡拿的是哪一杯最愛的迷客夏？\n快在下方用「表情符號」投出你的最愛\n看看哪一派粉絲軍團最強大！\n醇濃茶拿鐵派：迷客夏人氣必喝，最對味！\n清爽單茶派：解膩神助攻，清爽回甘\n特調果香派：果香明亮，層次迷人\n香醇鮮奶派：濃郁順口，暖心首選\n現在就預約你的跨年小夥伴！\nhttps://miniapp.line.me/1657225662-ARnXEvKb\n#迷客夏 #milksha #為了你嚴選每一杯 #2025年度TOP10 #年度推薦 #2026新年快樂	2025-12-31 00:00:00	96
154	6	IG	輕纖蕎麥茶	回顧𝟮𝟬𝟮𝟱年，大家最愛的迷客夏飲料有哪些?!(下集)\n快看你的迷客夏必喝有沒有上榜！\n拿起你最愛的那杯，一起看年度旁行榜 https://milksha.nidin.shop/\n𝗧𝗢𝗣𝟭 #珍珠大正紅茶拿鐵\n融合錫蘭 × 阿薩姆紅茶的多層次茶香\n加上醇濃綠光鮮奶與蜜漬白玉珍珠\n𝗤 彈香甜、冬天必喝\n𝗧𝗢𝗣𝟮 #輕纖蕎麥茶\n無咖啡因首選\n蕎麥穀香濃而不澀，溫潤順口、自然回甘\n獨家製程，讓香氣更純粹\n給想減少咖啡因的小迷人\n𝗧𝗢𝗣𝟯 #伯爵紅茶拿鐵\n釋放獨特佛手柑優雅果香\n完美調和綠光鮮奶\n口感醇厚柔順無人不愛\n𝗧𝗢𝗣𝟰 #原片初露青茶\n單茶控的清爽心頭好\n選用台灣原片青茶\n滋味淡雅清香、圓潤清甜\n𝗧𝗢𝗣𝟱 #芋頭鮮奶\n持續擔綱迷客夏「鎮店之寶」寶座\n選用高雄一號芋頭精心製作\n保留精華中段，手工壓製成綿密芋泥\n搭配綠光鮮奶，每口都有濃濃芋頭香氣和顆粒\n#迷客夏 #milksha #為了你嚴選每一杯 #2025年度TOP10 #年度推薦	2025-12-21 00:00:00	64
155	6	IG	法芙娜可可鮮奶	回顧𝟮𝟬𝟮𝟱年，大家最愛的迷客夏飲料有哪些?!(上集)\n快看你的迷客夏必喝有沒有上榜！\n拿起你最愛的那杯，一起看年度排行榜👉 https://milksha.nidin.shop/\n𝗧𝗢𝗣𝟲 #手炒黑糖鮮奶\n門市手工炒製的黑糖，清甜焦香不膩口\n搭配綠光鮮奶，醇香可口🤎✨\n𝗧𝗢𝗣𝟳 #柳丁綠茶\n迷客夏經典不敗清爽滋味🍊\n𝟭𝟬𝟬%柳丁原汁融合茉莉原淬綠茶\n清新花香襯托柑橘果香，喝得到柳丁果肉\n𝗧𝗢𝗣𝟴 #琥珀高峰烏龍\n榮獲𝟮𝟬𝟮𝟯 𝗜𝗧𝗜風味絕佳二星獎章🎖️\n獨特烤焙工藝，於嗅覺評分項目獲最高肯定\n琥珀色烏龍茶湯，炭焙香氣回甘留香✨\n𝗧𝗢𝗣𝟵 #靜岡焙焙鮮奶\n冬日療癒，「焙」感幸福✨\n採用嚴選靜岡直送茶葉\n獨特烘烤香氣搭配濃醇的綠光鮮奶💚\n口感醇厚滑順，完美融合焙茶＆奶香🫶\n𝗧𝗢𝗣𝟭𝟬 #法芙娜可可鮮奶\n𝗧𝗵𝗿𝗲𝗮𝗱𝘀爆紅回歸款🍫\n𝟭𝟬𝟬%法芙娜純可可粉 × 綠光鮮奶\n可可香氣細緻濃香，入口滑順有層次✨\n💗 微糖熱飲必點 💗\n#迷客夏 #milksha #為了你嚴選每一杯 #2025年度TOP10 #年度推薦	2025-12-20 00:00:00	93
156	6	IG	靜岡焙焙鮮奶	\\齁齁齁~~聖誕加「焙」幸福已抵達/\n𝟭𝟮/𝟮𝟰、𝟭𝟮/𝟮𝟱\n門市現場購買 #𝟮杯靜岡焙焙鮮奶 (𝗠) 只要 $𝟵𝟵\n溫暖加焙、幸福加倍\n現在就 @想一起喝迷客夏的小寶焙\n一起過暖暖聖誕節\n活動詳情請見官網https://reurl.cc/xKWqKV\n#迷客夏 #milksha #為了你嚴選每一杯 #靜岡焙焙鮮奶 #聖誕節快樂	2025-12-19 00:00:00	153
157	6	IG	香芋仙草綠茶拿鐵	𝟮𝟬𝟮𝟱 冬日暖心熱飲，你喝過哪些了呢？\n一起收藏最療癒的冬季 𝗧𝗢𝗣 清單！\n𝗧𝗢𝗣𝟭 #靜岡焙焙鮮奶\n冬日療癒，「焙」感幸福✨\n嚴選自靜岡的特選製茶名家，焙香濃郁\n搭配綠光鮮奶，滑順醇厚、暖心必喝🤎\n𝗧𝗢𝗣𝟮 #珍珠大正紅茶拿鐵\n大正紅茶融合錫蘭 × 阿薩姆紅茶的多層次茶香\n加上醇濃綠光鮮奶與蜜漬白玉珍珠\n𝗤 彈香甜、冬天必喝✨\n𝗧𝗢𝗣𝟯 #法芙娜可可鮮奶\n網友敲碗~重磅回歸刮起法芙娜可可旋風🍫🤎\n選用可可屆愛馬仕的𝟭𝟬𝟬%頂級法芙娜純可可粉\n高雅的苦甜香氣搭配滑順濃香的綠光鮮奶💚\n入口時可可香氣層次明顯🍫✨\n💗推薦微糖熱飲最美味💗\n𝗧𝗢𝗣𝟰 #琥珀烏龍拿鐵\n🤎炭焙香氣 × 綠光鮮奶💚\n柔順口感、層次豐富的冬日暖意\n𝗧𝗢𝗣𝟱 #香芋仙草綠茶拿鐵\n延續榮獲 𝗔.𝗔. 純粹品味三星獎的芋頭鮮奶口碑\n創新結合綠茶與嫩仙草凍\n仙草甘味與滑順奶香蔓延口中💗\n𝗧𝗢𝗣𝟲 #白甘蔗青茶\n選用台灣𝟭𝟬𝟬%白甘蔗原汁\n搭配清新青茶，滋味圓潤清甜🫶\n最療癒的冬季，需要最暖心的熱飲👉 https://milksha.nidin.shop/\n#迷客夏 #milksha #為了你嚴選每一杯 #2025冬日暖心推薦 #冬日必喝	2025-12-10 00:00:00	143
158	6	IG	法芙娜可可鮮奶	大家敲破碗的 #冬季限定 人氣飲品回歸啦！\n靜岡焙焙鮮奶、靜岡焙焙烏龍拿鐵 濃郁登場\n嚴選靜岡製茶名家精工研磨，細緻茶粉完整釋放焙香茶韻\n#靜岡焙焙鮮奶 迷編最推薦\n靜岡焙茶烤焙香氣 × 綠光鮮奶的醇厚滑順\n一口享受高品質的飲茶體驗\n#靜岡焙焙烏龍拿鐵\n榮獲𝗜𝗧𝗜風味絕佳二星獎章的 #琥珀高峰烏龍茶 x #綠光鮮奶\n炭焙茶香交織濃郁奶香，清爽甘醇不膩口\n同場加映\n#法芙娜可可鮮奶 重磅歸隊！\n法國 𝗩𝗮𝗹𝗿𝗵𝗼𝗻𝗮 頂級純可可 × 綠光鮮奶\n苦甜香氣細緻升級，滑順濃郁更迷人\n回味「焙」感溫暖的懷抱 ➜ https://milksha.nidin.shop/\n#迷客夏 #milksha #為了你嚴選每一杯 #濃焙茶 #重磅回歸	2025-11-13 00:00:00	146
159	6	IG	娜杯桂香拿鐵	花香與茶香的邂逅\n\\首款花香基調 —「桂香茶境」𝟭𝟭/𝟱 桂香四溢/\n#娜杯桂香拿鐵\n花香、茶香、奶香交織出圓潤細滑的優雅風味\n#桂香青檸粉粿\n桂花香氣融合青茶與檸檬微酸\n搭配𝗤彈粉粿，一口沁香爽感\n#桂香原片青\n嚴選台灣原片青茶結合金桂甜韻\n清爽甘醇如微風拂過花園\n#桂香輕蕎麥\n蕎麥穀香交織桂花柔香\n溫潤回甘、無咖啡因的療癒系飲品\n#桂香粉粿\n迷客夏首款花香系𝗤彈粉粿登場.ᐟ\n每一口都散發柔香餘韻，搭配各式茶飲都超加分\n立即沉浸在桂香茶境中\nhttps://reurl.cc/pKd0mx\n#迷客夏 #milksha #喝一口繼續走 #桂香茶境	2025-11-04 00:00:00	111
160	7	IG	冬片比賽茶包	過年送什麼，才不會被放在角落？\n懂喝的人都知道——答案是這包\n一年只回來一次的【冬片比賽茶包】\n邁入第 𝟱 年 #COMEBUY 持續限量熱銷中\n嚴選鬥茶協會認證的比賽茶\n茶湯清香、甘甜醇厚、不苦不澀\n超值 𝟱𝗴 茶包，冷泡熱泡都好喝！\n為什麼過年送它剛剛好？\n精緻包裝，送禮有面子\n𝟱𝗴 立體三角茶包，香氣更完整\n可回沖多次，在家慢慢喝也很可以\n價格親切，自用送人都適合\n今年過年，送一份「懂喝的心意」\n也替自己留一包，好好喝一杯\n一年一次，錯過真的要等明年了～\n數量有限，售完為止！\n冬片比賽茶包｜𝟱𝗴 x 𝟭𝟬入裝｜𝟭𝟵𝟵元\n#冬片比賽茶包 #一年一次 #過年送禮首選	2026-02-09 00:00:00	13
161	7	IG	把每一茶	把看似平凡的事做到不平凡\n才是真正的高度\n世界級的舞台\n來自每天不妥協的基本功\n就像 #COMEBUY 把每一杯茶\n都當成最重要的一杯\n#把日常做到世界級\n#現萃不是口號 #每一杯都很重要	2026-01-26 00:00:00	62
162	7	IG	雙黑糖堆疊	#COMEBUY 黑糖特別在…\n不是更甜，而是更「真」\n—— #半糖 以上風味完整好喝\n黑糖的香、甘、厚一次到位\n甜度剛好，也喝出黑糖的層次口感\n沖繩 × 台灣 雙重黑糖堆疊\n一個給你焦糖香的厚度\n一個留下甘蔗清甜的尾韻～\n飲品甜度來自黑糖本身\n不是比例堆疊，是經熬煮產生的自然焦糖香\n層次深厚卻不膩，喝得到溫潤也喝得到乾淨\n未經高度精製保留完整營養\n黑糖沒有走繁複提煉流程\n保留更多礦物質與原始風味\n甜得剛好，也喝得安心！\n一杯好喝現萃搭配黑糖\n才是冬天最耐喝的暖呼呼 ☕︎\n#雙黑糖堆疊 #OnlyBlackSugar\n#黑糖不是都一樣 #無可取代的單杯現萃	2026-01-08 00:00:00	37
163	7	IG	沖繩黑糖奶茶	𝟮𝟬𝟮𝟱 → 𝟮𝟬𝟮𝟲 倒數啦\n跨年夜一定要來點「咀嚼系幸福」(〃∀〃)\n今年最後一杯＆新年第一杯——\n#COMEBUY #沖繩黑糖奶茶\n—— 甜度僅靠黑糖半糖以上最有味 ♡\n雙𝗤𝟭號（珍珠＋粉條）\n𝗤彈、軟糯、焦香、濃奶一次登場\n比煙火還療癒的口感衝擊就在這刻炸開\n跨年的願望不一定要很偉大：\n喝到好喝的\n心情甜一點\n明年更順一點\n這杯就能全包辦 (๑˃ᴗ˂)و♡\n迎向 𝟮𝟬𝟮𝟲，讓暖甜先替你開個好頭吧～\n#跨年 #新年必喝 #雙Q咀嚼控集合\n#黑糖不另外加糖 #半糖以上最有味	2025-12-31 00:00:00	20
164	7	IG	黑糖紅茶拿鐵	𝗠𝗲𝗿𝗿𝘆 𝗖𝗵𝗿𝗶𝘀𝘁𝗺𝗮𝘀\n聖誕快樂呀大家 (ﾉ>▽<)ﾉ\n今天就讓一杯暖甜的 #沖繩黑糖系列\n陪你一起度過最閃亮的節日吧～\n透過完美比例與台灣黑糖蔗香融合\n焦香 × 奶香 × 茶香 層層堆疊\n喝一口直接：天啊也太幸福了吧 (๑´ڡ`๑)\n和最重要的朋友在這一天相聚\n一杯暖暖黑糖飲＝完美儀式感 ♡\n#沖繩黑糖奶茶 #沖繩黑糖奶綠\n#黑糖紅茶拿鐵 #黑糖港式厚奶\n#聖誕節快樂 #暖心必喝 #無可取代的單杯現萃	2025-12-25 00:00:00	15
175	8	IG	紅柚翡翠	龜蜜相揪過端午限時優惠別錯過\n-\n𝟓 / 𝟑𝟎 ( 五 ) ～ 𝟔 / 𝟏 ( 日 )\n⋯紅柚翡翠 2 杯 100 元⋯\n粽子吃多了難免油膩，搭配清爽解膩的紅柚\n絕對是最強儀式感組合\n限時 3 天優惠，每單限購 3 組\n⊱ 門市據點：https://lihi.cc/q8S7v\n⊱ 加入會員：https://lihi.cc/sDRhG\n⊱ 線上點餐：https://lihi.cc/xuJqa\n-\n⧁ 龜記桃園機場店、臺大醫院店不參與此活動\n⧁ 龜記全台門市「現場購買」與「現場自取」適用\n⧁ 不適用於龜記線上點餐/龜記線上點自取/Uber Eats/foodpanda/你訂 外送平台\n⧁ 各行銷活動、折扣、優惠、龜蜜卡點數折抵不合併使用（環保杯折抵5元不在此限）\n#龜記 #GUIJI #紅柚翡翠 #端午節 #優惠 #手搖	2025-05-29 00:00:00	93
165	7	IG	黑糖紅茶拿鐵	\\\\ 期盼の新品來了 //\n熬煮香氣升級的【沖繩黑糖系列】全新上市\n融合台灣黑糖蔗香，堆疊出馥郁焦糖香氣\n喝一口就知道——這次真的很可以 (*´∀`)ﾉ\n#沖繩黑糖奶茶 $𝟲𝟬(𝗟)\n台灣黑糖 × 沖繩黑糖，融入錫蘭紅茶與醇厚奶香，\n馥郁焦糖香交織甜潤奶茶，香濃不膩、飽滿順口！\n#沖繩黑糖奶綠 $𝟲𝟬(𝗟)\n雙黑糖結合醺香綠茶與奶香，\n散發焦糖香氣，茶感清爽、奶韻柔和的完美平衡！\n#黑糖紅茶拿鐵 $𝟳𝟱(𝗟)\n現泡烏瓦紅茶＋鮮乳，茶香濃厚香醇；\n雙黑糖提味，焦香迷人卻不膩口，是鮮奶茶愛好者首選！\n#黑糖港式厚奶 $𝟴𝟬(𝗠)\n現泡錫蘭紅茶混淡奶打造港式厚實口感，\n搭配雙黑糖提升焦甜層次，濃郁茶香與滑順奶韻一次到位！\n#新品上市 #沖繩融合台灣黑糖 #馥郁焦糖香\n#無可取代的單杯現萃 #半糖以上風味最佳 #暖心登場\n—\n⧁ 加入官方𝗟𝗜𝗡𝗘點連結拿𝟵折券 ➙ https://comebuy.pse.is/74g326\n⧁ 全台門市據點 ➙ https://lihi1.com/9IiXS\n⧁ 門市菜單 ➙ https://lihi1.com/xbX73	2025-12-19 00:00:00	26
166	7	IG	小葉紅奶茶	\\ 葉~~~~~~~~真的回來了.ᐟ.ᐟ /\n國際連鎖品牌中 #COMEBUY 全球首賣\n限量嫩採的《小葉紅茶》重磅回歸🍁\n在地好茶就是要 #現萃 才好喝 (✪ω✪)\n一起品味頂級紅茶、享受質感生活✨\n#小葉紅茶 $𝟱𝟬(𝗟)\n嚴選南投縣名間鄉嫩採的四季春重發酵製成\n擁有獨特果蜜香，茶湯溫潤、細緻高雅、不苦不澀！\n#小葉紅奶茶 $𝟳𝟬(𝗟)\n滋味柔順、甘甜順口的小葉紅茶混入奶精粉\n昇華香醇豐厚口感，奶茶控必喝！\n#小葉紅拿鐵 $𝟳𝟱(𝗟)\n順口回甘小葉紅茶加入香醇鮮奶\n成為健康族群最愛的頂級鮮奶茶！\n#季節限定 #四季春 #高品質 #紅茶 #限量嫩採\n#無可取代的單杯現萃 #限來店購買 #售完為止\n—\n⧁ 加入官方𝗟𝗜𝗡𝗘點連結拿𝟵折券 ➙ https://comebuy.pse.is/74g326\n⧁ 全台門市據點 ➙ https://lihi1.com/9IiXS\n⧁ 門市菜單 ➙ https://lihi1.com/xbX73	2025-11-06 00:00:00	28
167	7	IG	玩火	萬聖節最「火」裝扮出爐\n南瓜人都來 #COMEBUY 報到啦\n玩火不只好喝～還能當配件（誤）\n擁有熱帶水果風味的黃金茶湯\n讓你成為派對裡最亮眼的焦點\n今年萬聖節 ——\n不喝茶就搗蛋 ლ(>д< ლ)\n#萬聖節快樂 #無可取代的單杯現萃 #現萃驚艷\n—\n⧁ 全台門市據點 ➙ https://lihi1.com/9IiXS\n⧁ 門市菜單 ➙ https://lihi1.com/xbX73	2025-10-29 00:00:00	10
168	7	IG	玩火奶茶	中秋節不只要烤肉更要 #玩火\n一家烤肉萬家香一杯 #現萃 超沁爽.ᐟ.ᐟ\n嚴選甘甜煎茶與清香烏龍\n混拼百香果、芒果等熱帶水果風味烘製\n果香四溢中透著淡淡蘭花香(๑´ڡ`๑)\n門市現場限量活動\n𝟭𝟬/𝟭𝟱前至全台 𝗖𝗢𝗠𝗘𝗕𝗨𝗬 門市\n現場消費【玩火/玩火奶茶】任一杯即可獲得...\n免費加入 #船井生醫 FIP100纖維粉𝟭包（升級纖萃）\n再加碼送完整𝗣𝗘包裝𝟭包帶回家\n（詳細活動說明 ➙ https://reurl.cc/yAVYpq ）\n不管你是牛小排派還是香腸控\n這杯果香 × 清爽 × 纖維滿分\n能完美收尾你的烤肉大餐ヽ(●´∀`●)ﾉ\n今年就讓 #COMEBUY 陪你「火」力全開！\n#纖萃玩火 #纖萃玩火奶茶\n#中秋節 #中秋烤肉配好茶\n—\n⧁ 詳細FIP100纖維粉說明 ➙ https://www.funaicare.com/products/burner-bv15\n⧁ 全台門市據點 ➙ https://lihi1.com/9IiXS\n⧁ 門市菜單 ➙ https://lihi1.com/xbX73	2025-10-03 00:00:00	31
169	7	IG	玩火奶茶	❝火❞了𝟮𝟬年的經典現萃\n沒時間飛就喝這杯\n外面找不到的獨特風味——\n喝一口彷彿置身❝熱帶❞島嶼\n建議半糖以上最好喝\n#玩火 $𝟰𝟱(𝗟)\n嚴選甘甜煎茶與產自春天高山上的清香烏龍茶\n混拼百香果、芒果等熱帶水果風味烘製而成\n獨家黃金茶湯喝得到水果香氣與淡淡蘭花香！\n#玩火奶茶 $𝟲𝟱(𝗟)\n嚴選甘甜煎茶與清香烏龍茶調製奶茶\n帶有熱帶水果香氣與淡淡蘭花香\n讓奶茶風味獨特又清爽不膩！\n#無可取代的單杯現萃 就在 #COMEBUY\n—\n⧁ 加入官方𝗟𝗜𝗡𝗘點連結拿𝟵折券 ➙ https://comebuy.pse.is/74g326\n⧁ 全台門市據點 ➙ https://lihi1.com/9IiXS\n⧁ 門市菜單 ➙ https://lihi1.com/xbX73	2025-09-19 00:00:00	21
170	8	IG	普洱咖啡奶茶	普洱咖啡奶茶、普洱咖啡鮮乳\n今日上市\n呈現秋冬限定新品\n碎銀普洱厚韻×義式濃醇咖啡\n交織出溫暖成熟的獨特風味\n季節限定不要錯過( ˶ˊᵕˋ)੭♡\n↟.｡.:*･↟\n本產品以 100% 純咖啡液製成，咖啡液中含有多酚類等活性成分，在儲存過程中可能產生微量沉澱，屬於正常現象不影響品質，為天然純咖啡的特徵之一。\n#龜記 #GUIJI #樂步 #lebrewlife #普洱 #咖啡 #普洱咖啡奶茶 #普洱咖啡鮮乳	2025-11-01 00:00:00	54
171	8	IG	普洱咖啡奶茶	🧡龜記茗品×  樂步le brewlife💙\n當茶遇上咖啡，碰撞出這個秋冬最獨特的香氣🍂\n龜記攜手不斷挑戰與創新的樂步 le brewlife，\n雙品牌貫徹重視的「品質」與「生活感」，\n打破手搖飲的傳統框架。\n結合樂步的義式濃醇咖啡☕️\n融合順滑奶感，帶出濃郁溫暖的冬季限定特調。\n驚喜又充滿細節與質感的風味，\n完美展現兩個品牌的堅持與講究。\n溫馨提醒：本產品以 100% 純咖啡液製成，咖啡液中含有多酚類等活性成分，在儲存過程中可能產生微量沉澱，屬於正常現象不影響品質，為天然純咖啡的特徵之一。\n#龜記 #GUIJI #樂步 #lebrewlife #普洱 #咖啡 #普洱咖啡奶茶 #普洱咖啡鮮乳	2025-10-28 00:00:00	110
172	8	IG	蜂蜜花沫烏龍	中秋烤肉聚會多🥮🍖\n就是清爽的飲料該登場的時候😋\n10/3 (五)~10/6（一）\n中秋節限定活動，\n🌸購買兩杯蜂蜜花沫烏龍，就送一杯花沫烏龍🌸\n活動注意事項☆.｡.😘\n🌕限龜記門市現場+電話自取、龜記線上點自取享有\n🌕一般外送與外送平台皆不適用此活動\n🌕單筆消費可累贈（買2送1、買4送2，依此類推）\n#龜記 #GUIJI #中秋 #烏龍 #花沫烏龍 #蜂蜜 #蜂蜜花沫烏龍	2025-10-01 00:00:00	55
173	8	IG	三十三茶王	💗荔枝茶王今日上市💗\n-\n荔枝果肉＋茶王茶湯＝完美組合🍃\n一起夏末的微風裡，品嚐酸甜滋味☀️\n季節限定不要錯過٩꒰｡•◡•｡꒱۶\n-\n⧁ 圖為示意參考，請以現場實物為準\n#龜記 #GUIJI #新品 #荔枝 #三十三茶王 #荔枝茶王	2025-09-15 00:00:00	51
174	8	IG	功夫茶	召喚神龍的時刻到來！\n龜記推出夏季聯名限定補氣飲品：『星桃樂翡翠』\n加入功夫茶清爽芭樂果泥與龜記古早味楊桃蜜🌟\n層層果香堆疊，酸甜中帶茶香回甘\n一口喝下如氣流直擊味蕾⚡️\n還有聯名限定熱血周邊🎁\n從飲料杯身到保冷袋，從吸管塞到水壺提帶，\n每一樣都值得粉絲們「集氣收藏」⚡️\n限定活動第➊波：滿額贈禮\n活動期間｜𝟐𝟎𝟐𝟓/𝟎𝟕/𝟎𝟏 - 𝟐𝟎𝟐𝟓/𝟎𝟖/𝟑𝟏\n購買『星桃樂翡翠』 乙杯＋任一龜記飲品乙杯\n即可獲得【七龍珠 大魔 ✕ 龜記 ✕ 功夫茶 保冷袋】乙個\n☑數量有限，每人每筆限贈一次\n☑電話預訂、外送及外送平台不適用\n這個夏天，集氣開喝、召喚神龍，\n＃龜記 #GUIJI #功夫茶 #聯名活動 #星桃樂翡翠 #楊桃 ＃芭樂 ＃期間限定企劃 #七龍珠大魔	2025-07-01 00:00:00	96
176	8	IG	巨峰葡薈青	魅力新品、炫風來襲！\n巨峰葡薈青⋯𝟓/𝟏 上市.* ﾟ\n限量販售錯過不薈來\n融合四季春青茶＋巨峰葡萄汁＋蘆薈 ˊ˗\n年度必試的細膩質感風味\n⊱ 門市據點：https://lihi.cc/q8S7v\n⊱ 加入會員：https://lihi.cc/BKWoU\n⊱ 線上點餐：https://lihi.cc/BKWoU\n-\n⧁ 圖為示意參考，請以現場實物為準\n⧁ 實際販售情況依各門店為主完售不補貨\n#龜記 #GUIJI #新品 #限量販售 #巨峰葡薈青	2025-04-30 00:00:00	793
177	8	IG	三十三茶王	冬天是想瘦身最有效的季節（啪！\n-\n想解膩又怕小肚肚累積脂肪 ˃̶͈ ˂̶͈ ？\n整理三支小清新飲品給大家⇣\n花沫烏龍\n很多人不知道～今年夏天超受歡迎的蜜桃烏龍就是以花沫為茶底喔味道很清新、順口，有膩口食物需要搭配的話非常推薦！\n蜂蜜綠茶／四季春\n龜記使用蜜蜂工坊真蜂蜜除了是天然糖漿外，蜂蜜還有潤喉、保護心血管等附加價值，可以依照個人口味挑選茶底\n三十三茶王\n說到茶系列的熱銷單品33絕對榜上有名！老師傅獨家訂製的烘培法，口感回甘、韻味豐富，重點是喝完不會心悸呀～（龜小編心中 TOP 1 ）\n圖片奉上最新的熱量、咖啡因含量表呦\n⊱ 門市據點：https://bit.ly/40G8McA\n⊱ 加入會員：https://bit.ly/3O0e5vV\n⊱ 線上點餐：https://bit.ly/3AwFvGB\n#龜記 #GUIJI #推薦 #飲品推薦 #茶飲 #蜂蜜	2024-12-03 00:00:00	53
178	8	IG	品牌日常/無特定飲品	藍波萬啦！No.1 !!!!\n-\n昨晚真的創造了歷史性的一刻\n謝謝你們締造「烏」與倫比的佳績\n慶祝中華隊勇奪冠軍！\n用細膩的醇粹與花香\n感受「烏」與倫比的光榮\n-\n⧁ 單筆限購一組\n⧁ 限來店臨櫃現場購買，不適用各大外送平台、龜記線上點餐或電話自取\n⧁ 活動品項加料需另付費，恕無法更換其他商品\n⧁ 部分門店不參與：板橋環球店、新竹SOGO店、南港中信店、汐止遠雄店、大巨蛋店、臺大醫院店、台北車站店、統一時代店、南港CITYLINK店\n#龜記 #GUIJI #小人物大生活 #世界12強棒球錦標賽 #中華隊 #冠軍 #台灣之光	2024-11-25 00:00:00	200
179	9	IG	四季春青茶	「梅醬出任務，酸甜接力棒！」\n#旺來系列臨時缺席，梅醬來HOLD場囉 ^w^\n門市QA排行榜：50嵐 #梅の綠，到底怎麼唸？\n梅子綠？ 梅之綠？ 梅綠？ 梅什麼綠？ 那個綠？\n不論怎麼唸，喝過就忍不住心心念念！\n梅の綠：清爽系\n酸甜梅汁配上茉莉花香綠茶，先酸甜後茶香，\n多層風味口感，滿滿戀愛好滋味。\n梅の紅：復古系\n香氣細緻的紅茶遇上梅汁，酸甜帶點回甘，\n一秒回到以前柑仔店配話梅的年代～\n梅の青：淡雅系\n清香且淡雅的四季春青茶，加入酸甜梅汁，\n連員工都愛的私房搭配，喝得出層次又不會膩！\n梅の烏：成熟系\n有焙火香氣的黃金烏龍搭配微酸解膩的梅汁，\n酸甜解膩、茶味相宜，大人味首選非他莫屬！\n心動不如馬上行動，找到你的夏日專屬酸甜\n#50嵐 #50嵐中區 #好茶陪伴你的日常 #手搖 #飲料\n#梅の綠 #梅の紅 #梅の青 #梅の烏	2025-05-28 00:00:00	124
180	9	IG	四季春青茶	【時令鮮果首選～情人茶！】\n阿嵐發現近期因應氣候關係，金桔常常請假～\n為了嵐粉們的酸甜愛戀，真心推薦 #情人茶\n鮮榨檸檬×獨家梅醬×茉莉綠茶 黃金組合，\n酸得剛好，甜得迷人，清爽不膩，一喝就愛上\n那種鮮酸甜蜜回甘的層次感，就是戀愛的味道！\n阿嵐私房喝法，今天就試試吧 (*´∀`)~\n甜度三分糖以上～戀愛心情百分百！\n冰塊微冰或少冰～冰沁入魂包你愛！\n偷偷宣傳當月詢問度破表的隱藏飲品 #多多青\n養樂多×四季春青茶 酸甜控的你也一定會喜歡！\n#50嵐 #50嵐中區 #好茶陪伴你的日常 #手搖 #飲料\n#情人茶 #8冰綠 #檸檬 #金桔 #梅醬	2025-05-07 00:00:00	1119
181	9	IG	阿薩姆紅茶	號外號外📣嵐冰友家族擴編中！\n嵐氏冰淇淋三種口味～香草/芒果/荔枝\n#你最喜歡哪個><\n阿嵐大推✨冰淇淋系列\n①荔枝烏龍\n使用細緻荔枝義式雪酪\n搭配焙火香氣黃金烏龍\n濃郁甘甜 層次再升級🤍\n②芒果青\n濃郁芒果香甜鮮果雪酪\n與四季春青茶完美交織\n網友敲網 超經典回歸🧡\n③冰淇淋紅茶\n綿密香濃的香草冰淇淋\n加香醇陳韻阿薩姆紅茶\n極品絕配 一口就上癮❤️\n#50嵐 #中區50嵐 #好茶陪伴你的日常 #手搖 #飲料 #新品 #嵐冰友 #荔枝烏龍 #芒果青	2024-08-05 00:00:00	188
182	9	IG	荔枝烏龍	新品 #嵐冰友 強勢來襲！\n嵐粉們喝過了嗎？σ`∀´)σ\n必喝的3個秘密！ #快來看看\n全新飲品 #嵐冰友🧊\n1. 冰淇淋基底茶可更換～芒果青/綠/紅/烏，荔枝烏龍/綠/青/紅 #任你選\n2. 配料自由加～珍珠、波霸、椰果或燕麥 #全免費\n3. 杯身貼紙小秘密～荔枝、芒果、香草每個口味都不一樣❣️\n#荔枝烏龍 #芒果青 你喜歡哪個？\n阿嵐兩個都超喜歡！\n入口感受雪酪的沁心透涼，\n再品嚐基底茶的質感回甘，\n是夏天的一大救贖🤍\n#50嵐 #中區50嵐 #好茶陪伴你的日常 #手搖 #飲料\n#新品 #嵐冰友 #荔枝烏龍 #芒果青	2024-08-03 00:00:00	248
183	9	IG	冰淇淋綠茶	夏季主打 #綠茶專賣店 登場(*´∀`)~\n十級嵐粉在哪裡～發現招牌的小秘密了嗎？\n真正的 #招牌 #茉莉綠茶 到來！\n本次主視覺以超元氣的日漫風格\n強調我們滿滿的熱情與專業的搖茶技巧\n綠茶喝一下 清爽喝一夏！\n三款經典 #綠茶系 飲品～ 必喝！\n▷波霸綠茶拿鐵\n典雅奶香加綠茶 尾韻豐厚又清香\nQ彈口感大滿足 微甜波霸一級棒\n▷冰淇淋綠茶\n茉綠尬香草冰淇淋 清爽暢快透心涼\n多重層次超幸福 夏日必喝人氣款\n▷多多綠茶\n經典多多配綠茶 微酸微甜超解膩\n炎熱夏日喝一口 完美療癒笑開懷\n#50嵐 #中區50嵐 #好茶陪伴你的日常 #手搖 #飲料 #夏季主打 #綠茶專賣店 #波霸綠茶拿鐵	2024-05-31 00:00:00	98
184	9	IG	好茶陪伴你的	柚，是你～ ！你回來了♡\n#葡萄柚系列 COME BACK！\n少女紅橘色的經典葡萄柚\n譜出如夏日戀歌般的滋味\n屬於這個季節的限定飲品\n是520 不可不喝酸甜滋味♡\n季節限定\n►鮮柚綠\n►葡萄柚汁\n►葡萄柚多多\n#50嵐 #50嵐中區 #葡萄柚系列 #季節限定 #好茶陪伴你的日常	2024-05-20 00:00:00	694
185	9	IG	好茶陪伴你的	什麼！竟然還可以這樣喝？！\n珍波椰青茶升級小祕技d(`･∀･)b\n布丁/燕麥/瑪奇朵 加上去超好喝♡\n幸福指數大大大提升！\n快相揪朋友一起來喝～\n#50嵐 #50嵐中區 #好茶陪伴你的日常 #手搖 #飲料\n#春季主打 #嵐a青春 #珍波椰青茶	2024-05-18 00:00:00	1691
186	9	IG	阿華田	「阿華田」120歲生日快樂🎉🎉\n嵐粉們喜歡在「阿華田」裡加哪些配料呢？\n阿嵐最喜歡在裡面加滿滿的燕麥和珍珠了！！\n喝完超有飽足感～營養滿點！\n🤫 聽說阿華田歡慶抽獎活動誠意滿滿！\n\\\\ 完整內容請參閱活動網站說明 //\nhttps://www.ovaltine.com.tw/ovaltine_120celebration/\n#50嵐 #50嵐中區 #好茶陪伴你的日常 #手搖 #飲料\n#歡慶阿華田120周年瑞士經典不斷電 #阿華田橘色潮食尚美味大探索	2024-05-08 00:00:00	157
188	9	IG	奶茶	春秋戰國時代百家爭鳴，\n現在奶茶也有四大門派擁護者\n奶茶派、奶青派、烏龍奶派、奶綠派\n各派系擁護者眾多～你屬於哪一派呢？\n歡迎嵐粉們分享 #最愛奶類\n阿嵐最近偏好 #珍珠奶青\n獨特奶香味搭配四季青茶的滿口清香\n再感受滑順的小珍珠，超級好喝～\n#50嵐 #50嵐中區 #春季主打 #嵐a青春 #珍珠奶青 #好茶陪伴你的日常 #手搖 #飲料	2024-04-09 00:00:00	8509
189	10	IG	羽衣蘋安	#二月最後一次 超級星期一優惠把握啦\n被譽為超級食物的羽衣甘藍，營養滿滿!!\n中午來一杯現榨 #羽衣蘋安杯 讓你開啟元氣滿滿的星期一\n2/9臨櫃限定 | 羽衣蘋安杯（M）只要49元\n*羽衣甘藍屬高鉀蔬菜，腎功能不良或低血壓族群請酌量食用\n*商場、外島等部分門市無販售，請以現場公告為準\n*優惠不併用\n#CoCo #羽衣甘藍 #優惠活動 #超級星期一	2026-02-08 00:00:00	28
190	10	IG	珍珠黑糖拿鐵(14oz)	嚼對很紓壓!手搖咖啡新登場!\n珍珠黑糖拿鐵(14oz)是咖啡也是手搖!\nQ彈珍珠在黑糖拿鐵裡翻滾，越嚼越香越過癮!冷熱都超好喝全台門市陸續開賣先點再取 maac.io/1HR0Q\n#CoCo都可 #珍珠黑糖拿鐵	2026-02-06 00:00:00	57
191	10	IG	莓好雙果茶	近期紅什麼就紅這杯明天來場莓好約會\n美樂蒂最愛草莓肯定要整組的啦～\n用美樂蒂聯名紙杯裝莓好雙果飲夢幻可愛\n𝟮/𝟰 都可訂限定優惠\n莓好雙果茶(L)\n憑券第二杯 #0元\n2杯只要75元\n每個人有2張券\n點我領券 https://maac.io/1HR0Q\n注意事項\n限使用「CoCo都可訂」線上點單，優惠不併用\n𝟮/𝟰 𝟎𝟎:𝟎𝟎 開始領券，第2、4杯可享折扣\n領券後，在確認明細時點選’’點我使用折價券’’帶入折扣\n限 𝟮/𝟰 當日使用，數量有限，售完為止\n商場門市/部分門市不適用本活動\n#好友日 #都可好友日 #CoCo都可	2026-02-03 00:00:00	149
192	10	IG	28茉輕乳茶	2月開始的每一天都在開心倒數過年٩(๑> ₃ <)۶з\n天天都是喝飲料的好日子 當然也要優惠喝 心情更加分👍\n全區任選2杯99\n🍓莓好雙果茶 草莓蔓越莓與紅茶的超幸福搭配🩷\n🧋冬韻擂焙珍奶 天冷喝這杯最暖心\n✔ 28茉輕乳茶✔ 21歲輕檸烏龍✔日焙珍珠奶茶\n🏠小湯圓奶茶(門市臨櫃限定)\n全部任選、自由搭配！\n📍 全台門市臨櫃＆都可訂平台同步優惠\n📍 活動品項及販售依各門市公告為主\n📍 外送平台及部分門市不適用\n#CoCo都可 #2杯99	2026-02-03 00:00:00	149
193	10	IG	生椰職人拿鐵(14oz)	週二咖啡日又要到啦!\n來杯西西里手搗檸檬美式\n鮮檸檬現搗出檸檬特有的精油香氣\n搭配職人金獎現磨咖啡\n感受鮮果的清新 品味咖啡的香醇\n隨心暢飲 加料更有勁\n每週二限定\n生椰職人拿鐵/職人美式/果咖美式 同價位買一送一\n 臨櫃 / 都可訂 同步開喝\n準時開點 https://maac.io/1HR0Q\n活動品項\n生椰職人拿鐵(14oz)（街邊) 原價$70\n粉角生椰拿鐵(14oz)（街邊) 原價$80\n職人美式(14oz)（街邊）原價$45\n西西里手搗檸檬美式 /紅柚香檸美式(L)（街邊）原價$75\n台灣柳丁美式( L) (街邊) 原價$85\n活動優惠以原價計，優惠不併用\n商場及部分門市不適用，詳情請洽現場公告\n#CoCo都可 #週二咖啡日 #買一送一 #職人咖啡 #CoCoCoffee	2026-02-02 00:00:00	12
194	10	IG	紅柚香檸美式	⌛OOO優惠倒數⌛\n(內個不要TAG我老闆😆喝就對了)\n有人跟小編一樣嗎?🛏️每天的開局就是果咖(西西里手搗香檸美式/紅柚香檸美式/香橙美式)，再加一份粉角或珍珠，醒腦又療癒RRRR!\n小編小桑心劇透…優惠倒數…快把握!\n☕️天天果咖日：各店指定美式、果咖系列同價位買一送一!\n☕️週二咖啡日：各店指定美式、果咖、生椰拿鐵系列買一送一!\n👉臨櫃買、線上點👉 https://maac.io/1HR0Q\n⚠️活動優惠以原價計，優惠不併用\n⚠️商場及部分門市不適用，詳洽各店現況\n#coco都可 #咖啡 #優惠 #買一送一	2026-01-30 00:00:00	43
195	10	IG	百香雙響炮	全民喝百香雙響炮第二杯10元\n快找那個願意幫你出10元的人 ~\n𝟭/𝟮𝟴 都可訂限定優惠\n百香雙響炮(L)\n憑券第二杯 #10元\n2杯80元帶走\n每個人有2張券\n點我領券 https://maac.io/1HR0Q\n注意事項\n限使用「CoCo都可訂」線上點單，優惠不併用\n𝟭/𝟮𝟴 𝟎𝟎:𝟎𝟎 開始領券，第2、4杯可享折扣\n領券後，在確認明細時點選’’點我使用折價券’’帶入折扣\n限𝟭/𝟮𝟴 當日使用，數量有限，售完為止\n商場門市/部分門市不適用本活動\n#好友日 #都可好友日 #CoCo都可	2026-01-27 00:00:00	204
196	10	IG	莓好雙果牛乳	🍓My Melody 莓好限定!莓好雙果系列甜美開喝！\n🍓酸甜草莓 ✕ 鮮香蔓越莓\n💗\n在紅茶與鮮奶的襯托下，開啟最療癒的莓果時刻～\n不只「好喝」，更「喝得安心」！\n採用尖端 HPP冷高壓滅菌技術 製作💡\n保留草莓與蔓越莓的營養、果香 ꙳⸌♡⸍꙳\n同時以超高壓力鎖住新鮮、遠離細菌\n讓每一口都是滿滿自然甜味與健康能量💪\n🍓 莓好雙果茶\n融合草莓、蔓越莓與紅茶香氣～\n酸甜交織、沁涼爽口，超適合下午來一杯✨\n🥛 莓好雙果牛乳\n莓果的酸甜搭上濃醇鮮奶\n柔滑香濃、無咖啡因，大人小孩都能喝！💗\n酸甜莓果 × 健康科技\n一起來喝下雙倍「莓」好的幸福！🫶\n1/26開始購買任一大杯飲品還有美樂蒂聯名紙杯喔💗\n#CoCo都可 #莓好雙果系列 #莓好雙果茶 #莓好雙果牛乳 #HPP冷高壓滅菌	2026-01-24 00:00:00	605
197	10	IG	冬韻擂焙珍奶	不得不愛天氣冷喝暖暖! 暖暖喝!\n#冬日奶茶天花板 開喝\n嚴選14種營養穀物\n手工煮製日式鹿兒島焙奶茶\n𝟭/𝟮𝟭 都可訂限定優惠\n冬韻擂焙珍奶(L)\n憑券第二杯 #0元\n2杯70元帶走\n每個人有2張券\n點我領券 https://maac.io/1HR0Q\n注意事項\n限使用「CoCo都可訂」線上點單，優惠不併用\n𝟭/𝟮𝟭 𝟎𝟎:𝟎𝟎 開始領券，第2、4杯可享折扣\n領券後，在確認明細時點選’’點我使用折價券’’帶入折扣\n限𝟭/𝟮𝟭當日使用，數量有限，售完為止\n商場門市/部分門市不適用本活動\n#好友日 #都可好友日 #CoCo都可	2026-01-20 00:00:00	177
198	10	IG	莓好雙果茶	#美好雙果平安健康+賺大錢🎉\n#莓好新年必喝莓好雙果茶🍓🍓🍓\n\n𝟭/𝟭𝟰 🫶都可訂限定優惠\n莓好雙果茶(L)\n📢憑券第二杯#10元\n2杯85元帶走 🧋\n每個人有2張券\n\n💡注意事項\n1️⃣ 限使用「CoCo都可訂」線上點單，優惠不併用\n2️⃣ 𝟭/𝟭𝟰 𝟎𝟎:𝟎𝟎 開始領券，第2、4杯可享折扣\n3️⃣ 領券後，在確認明細時點選’’點我使用折價券’’帶入折扣\n4️⃣ 限𝟭/𝟭𝟰 當日使用，數量有限，售完為止\n5️⃣ 商場門市/部分門市不適用本活動\n#好友日#都可好友日#CoCo都可	2026-01-13 00:00:00	105
\.


--
-- Data for Name: price_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.price_history (id, ingredient_id, market_price, change_rate, recorded_at) FROM stdin;
\.


--
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product (id, tenant_id, name, price, scraped_at, category) FROM stdin;
1	1	功夫茶王	0.00	2026-02-10 17:12:37.589741	功夫・必喝
2	1	芝士奶蓋翠玉	0.00	2026-02-10 17:12:37.589741	功夫・必喝
3	1	冰淇淋雪藏紅茶	0.00	2026-02-10 17:12:37.589741	功夫・必喝
4	1	輕飲水果茶王	0.00	2026-02-10 17:12:37.589741	功夫・必喝
5	1	寒天柚香飲	0.00	2026-02-10 17:12:37.589741	功夫・必喝
6	1	黑糖波霸鮮奶	0.00	2026-02-10 17:12:37.589741	功夫・必喝
7	1	隱山烏龍	0.00	2026-02-10 17:12:37.589741	功夫・必喝
8	1	芭樂檸檬綠	0.00	2026-02-10 17:12:37.589741	功夫・必喝
9	1	岩葉紅茶	0.00	2026-02-10 17:12:37.589741	功夫・好茶
10	1	翠玉綠茶	0.00	2026-02-10 17:12:37.589741	功夫・好茶
11	1	四季春青茶	0.00	2026-02-10 17:12:37.589741	功夫・好茶
12	1	烏龍鐵觀音	0.00	2026-02-10 17:12:37.589741	功夫・好茶
13	1	手作冬瓜茶	0.00	2026-02-10 17:12:37.589741	功夫・好茶
14	1	蜜桃胭脂紅茶	0.00	2026-02-10 17:12:37.589741	功夫・好茶
15	1	日月潭紅玉	0.00	2026-02-10 17:12:37.589741	功夫・好茶
16	1	阿里山冰茶	0.00	2026-02-10 17:12:37.589741	功夫・好茶
17	1	芝士奶蓋紅茶	0.00	2026-02-10 17:12:37.589741	功夫・好茶
18	1	芝士奶蓋烏龍	0.00	2026-02-10 17:12:37.589741	功夫・好茶
19	1	玫瑰冰茶	0.00	2026-02-10 17:12:37.589741	功夫・好茶
20	1	青梅綠茶	0.00	2026-02-10 17:12:37.589741	功夫・好茶
21	1	多多綠茶	0.00	2026-02-10 17:12:37.589741	功夫・好茶
22	1	胭脂多多	0.00	2026-02-10 17:12:37.589741	功夫・好茶
23	1	芝士奶蓋青茶	0.00	2026-02-10 17:12:37.589741	功夫・好茶
24	1	38奶霸	0.00	2026-02-10 17:12:37.589741	功夫・奶茶
25	1	黑糖波霸珍珠奶茶	0.00	2026-02-10 17:12:37.589741	功夫・奶茶
26	1	厚奶茶	0.00	2026-02-10 17:12:37.589741	功夫・奶茶
27	1	厚奶綠	0.00	2026-02-10 17:12:37.589741	功夫・奶茶
28	1	烏龍觀音奶茶	0.00	2026-02-10 17:12:37.589741	功夫・奶茶
29	1	英式伯爵奶茶	0.00	2026-02-10 17:12:37.589741	功夫・奶茶
30	1	蜜桃胭脂奶茶	0.00	2026-02-10 17:12:37.589741	功夫・奶茶
31	1	莊園玫瑰奶茶	0.00	2026-02-10 17:12:37.589741	功夫・奶茶
32	1	巧克力奶茶	0.00	2026-02-10 17:12:37.589741	功夫・奶茶
33	1	粉粿柚香綠	0.00	2026-02-10 17:12:37.589741	功夫・鮮果
34	1	鮮榨柳橙綠	0.00	2026-02-10 17:12:37.589741	功夫・鮮果
35	1	黃金芒果綠	0.00	2026-02-10 17:12:37.589741	功夫・鮮果
36	1	百香3Q(珍珠+蒟蒻+椰果)	0.00	2026-02-10 17:12:37.589741	功夫・鮮果
37	1	百香羅勒子	0.00	2026-02-10 17:12:37.589741	功夫・鮮果
38	1	冬瓜檸檬	0.00	2026-02-10 17:12:37.589741	功夫・鮮果
39	1	黃金芒果莎莎	0.00	2026-02-10 17:12:37.589741	功夫・鮮果
40	1	泰式榴槤莎莎(冰沙)	0.00	2026-02-10 17:12:37.589741	功夫・鮮果
41	1	紅豆粉粿鮮奶	0.00	2026-02-10 17:12:37.589741	功夫・鮮奶
42	1	岩葉紅茶拿鐵	0.00	2026-02-10 17:12:37.589741	功夫・鮮奶
43	1	烏龍觀音拿鐵	0.00	2026-02-10 17:12:37.589741	功夫・鮮奶
44	1	英式伯爵拿鐵	0.00	2026-02-10 17:12:37.589741	功夫・鮮奶
45	1	蜜桃胭脂拿鐵	0.00	2026-02-10 17:12:37.589741	功夫・鮮奶
46	1	冰淇淋紅茶拿鐵	0.00	2026-02-10 17:12:37.589741	功夫・鮮奶
47	1	巧克力鮮奶	0.00	2026-02-10 17:12:37.589741	功夫・鮮奶
48	1	暖薑奶茶	0.00	2026-02-10 17:12:37.589741	冬日限定
49	1	暖薑鮮奶	0.00	2026-02-10 17:12:37.589741	冬日限定
50	1	薑汁桂圓紅棗	0.00	2026-02-10 17:12:37.589741	冬日限定
51	2	玉露青茶	0.00	2026-02-10 17:12:37.589741	嚴選茗品
52	2	桂花青茶	0.00	2026-02-10 17:12:37.589741	嚴選茗品
53	2	炭燒青茶	0.00	2026-02-10 17:12:37.589741	嚴選茗品
54	2	紅玉紅茶	0.00	2026-02-10 17:12:37.589741	經典純粹
55	2	翡翠綠茶	0.00	2026-02-10 17:12:37.589741	經典純粹
56	2	熟成油切蕎麥	0.00	2026-02-10 17:12:37.589741	經典純粹
57	2	熟成油切蕎麥(無)	0.00	2026-02-10 17:12:37.589741	經典純粹
58	2	御品冬瓜露	0.00	2026-02-10 17:12:37.589741	經典純粹
59	2	冷萃東方美人	0.00	2026-02-10 17:12:37.589741	經典純粹
60	2	冷萃半熟金萱	0.00	2026-02-10 17:12:37.589741	經典純粹
61	2	老奶奶的鳳梨田	0.00	2026-02-10 17:12:37.589741	職人手作
62	2	蘋果玉露青	0.00	2026-02-10 17:12:37.589741	職人手作
63	2	甘蔗玉露青	0.00	2026-02-10 17:12:37.589741	職人手作
64	2	冬瓜玉露青	0.00	2026-02-10 17:12:37.589741	職人手作
65	2	纖檸冬瓜露	0.00	2026-02-10 17:12:37.589741	職人手作
66	2	翡翠多多青	0.00	2026-02-10 17:12:37.589741	職人手作
67	2	檸檬桂花青	0.00	2026-02-10 17:12:37.589741	職人手作
68	2	柳橙翡翠青	0.00	2026-02-10 17:12:37.589741	職人手作
69	2	酪梨奶蓋紅玉	0.00	2026-02-10 17:12:37.589741	雲朵奶蓋
70	2	酪梨奶蓋綠茶	0.00	2026-02-10 17:12:37.589741	雲朵奶蓋
71	2	酪梨奶蓋烏龍	0.00	2026-02-10 17:12:37.589741	雲朵奶蓋
72	2	酪梨奶蓋冬瓜露	0.00	2026-02-10 17:12:37.589741	雲朵奶蓋
73	2	玉露奶青	0.00	2026-02-10 17:12:37.589741	香醇濃郁
74	2	桂花奶青	0.00	2026-02-10 17:12:37.589741	香醇濃郁
75	2	懷舊經典奶茶	0.00	2026-02-10 17:12:37.589741	香醇濃郁
76	2	鐵觀音奶茶	0.00	2026-02-10 17:12:37.589741	香醇濃郁
77	2	翡翠奶綠	0.00	2026-02-10 17:12:37.589741	香醇濃郁
78	2	熟成蕎麥奶茶	0.00	2026-02-10 17:12:37.589741	香醇濃郁
79	2	熟成蕎麥奶茶(無)	0.00	2026-02-10 17:12:37.589741	香醇濃郁
80	2	珍珠奶茶	0.00	2026-02-10 17:12:37.589741	香醇濃郁
81	2	烤糖蕎麥凍奶青	0.00	2026-02-10 17:12:37.589741	香醇濃郁
82	2	珈琲粉粿蕎麥奶	0.00	2026-02-10 17:12:37.589741	香醇濃郁
83	2	珈琲粉粿蕎麥奶(無)	0.00	2026-02-10 17:12:37.589741	香醇濃郁
84	2	紅茶拿鐵	0.00	2026-02-10 17:12:37.589741	牧場直送
85	2	翡翠拿鐵	0.00	2026-02-10 17:12:37.589741	牧場直送
86	2	珍珠粉粿牛奶	0.00	2026-02-10 17:12:37.589741	牧場直送
87	2	鐵觀音拿鐵	0.00	2026-02-10 17:12:37.589741	牧場直送
88	2	仙草嫩奶	0.00	2026-02-10 17:12:37.589741	牧場直送
89	2	翡翠莓香	0.00	2026-02-10 17:12:37.589741	季節限定
90	2	草莓優格飲	0.00	2026-02-10 17:12:37.589741	季節限定
91	2	冬瓜蕎麥老鄉茶	0.00	2026-02-10 17:12:37.589741	期間限定
92	2	冬瓜蕎麥老鄉拿鐵	0.00	2026-02-10 17:12:37.589741	期間限定
93	3	緋烏龍	0.00	2026-02-10 17:12:37.589741	新品上市-緋烏龍系列
94	3	馥莓緋烏龍	0.00	2026-02-10 17:12:37.589741	新品上市-緋烏龍系列
95	3	緋烏龍奶茶	0.00	2026-02-10 17:12:37.589741	新品上市-緋烏龍系列
96	3	緋烏龍鮮奶	0.00	2026-02-10 17:12:37.589741	新品上市-緋烏龍系列
97	3	芝士奶蓋緋烏龍	0.00	2026-02-10 17:12:37.589741	新品上市-緋烏龍系列
98	3	紅茶	0.00	2026-02-10 17:12:37.589741	Original TEA
99	3	綠茶	0.00	2026-02-10 17:12:37.589741	Original TEA
100	3	春烏龍	0.00	2026-02-10 17:12:37.589741	Original TEA
101	3	輕烏龍	0.00	2026-02-10 17:12:37.589741	Original TEA
102	3	焙烏龍	0.00	2026-02-10 17:12:37.589741	Original TEA
103	3	奶茶	0.00	2026-02-10 17:12:37.589741	Classic MILK TEA
104	3	焙烏龍奶茶	0.00	2026-02-10 17:12:37.589741	Classic MILK TEA
105	3	珍珠奶茶	0.00	2026-02-10 17:12:37.589741	Classic MILK TEA
106	3	黃金珍珠奶綠	0.00	2026-02-10 17:12:37.589741	Classic MILK TEA
107	3	烘吉奶茶	0.00	2026-02-10 17:12:37.589741	Classic MILK TEA
108	3	紅茶鮮奶	0.00	2026-02-10 17:12:37.589741	Fresh MILK
109	3	輕烏龍鮮奶	0.00	2026-02-10 17:12:37.589741	Fresh MILK
110	3	焙烏龍鮮奶	0.00	2026-02-10 17:12:37.589741	Fresh MILK
111	3	烘吉鮮奶	0.00	2026-02-10 17:12:37.589741	Fresh MILK
112	3	檸檬春烏龍	0.00	2026-02-10 17:12:37.589741	Double FRUIT
113	3	香橙春烏龍	0.00	2026-02-10 17:12:37.589741	Double FRUIT
114	3	甘蔗春烏龍	0.00	2026-02-10 17:12:37.589741	Double FRUIT
115	3	青梅春烏龍	0.00	2026-02-10 17:12:37.589741	Double FRUIT
116	3	優酪春烏龍	0.00	2026-02-10 17:12:37.589741	Double FRUIT
117	3	雙柚金烏龍	0.00	2026-02-10 17:12:37.589741	Double FRUIT
118	3	芝士奶蓋春烏龍	0.00	2026-02-10 17:12:37.589741	Cheese MILK FOAM
119	3	芝士奶蓋焙烏龍	0.00	2026-02-10 17:12:37.589741	Cheese MILK FOAM
120	3	芝士奶蓋阿華田	0.00	2026-02-10 17:12:37.589741	Cheese MILK FOAM
121	3	芝士奶蓋烘吉茶	0.00	2026-02-10 17:12:37.589741	Cheese MILK FOAM
122	4	太妃蜜桃風味厚奶霜	0.00	2026-02-10 17:12:37.589741	新品上市-太妃厚奶系列
123	4	太妃風味伯爵厚奶霜	0.00	2026-02-10 17:12:37.589741	新品上市-太妃厚奶系列
124	4	太妃風味錫蘭厚奶霜	0.00	2026-02-10 17:12:37.589741	新品上市-太妃厚奶系列
125	4	太妃蜜桃風味拿鐵	0.00	2026-02-10 17:12:37.589741	新品上市-太妃厚奶系列
126	4	太妃風味伯爵拿鐵	0.00	2026-02-10 17:12:37.589741	新品上市-太妃厚奶系列
127	4	太妃風味錫蘭拿鐵	0.00	2026-02-10 17:12:37.589741	新品上市-太妃厚奶系列
128	4	太妃蜜桃風味奶茶	0.00	2026-02-10 17:12:37.589741	新品上市-太妃厚奶系列
129	4	太妃風味伯爵奶茶	0.00	2026-02-10 17:12:37.589741	新品上市-太妃厚奶系列
130	4	太妃風味錫蘭奶茶	0.00	2026-02-10 17:12:37.589741	新品上市-太妃厚奶系列
131	4	英式玫瑰拿鐵	0.00	2026-02-10 17:12:37.589741	活動區
132	4	英式水果茶	0.00	2026-02-10 17:12:37.589741	人氣精選 TOP7
133	4	四季春茶王	0.00	2026-02-10 17:12:37.589741	人氣精選 TOP7
134	4	輕焙穀麥茶	0.00	2026-02-10 17:12:37.589741	人氣精選 TOP7
135	4	英式蜜桃風味茶	0.00	2026-02-10 17:12:37.589741	人氣精選 TOP7
136	4	朵朵奶蓋伯爵茶	0.00	2026-02-10 17:12:37.589741	人氣精選 TOP7
137	4	錫蘭高地莊園紅茶	0.00	2026-02-10 17:12:37.589741	莊園好茶
138	4	皇家伯爵茶	0.00	2026-02-10 17:12:37.589741	莊園好茶
139	4	英式玫瑰特調茶	0.00	2026-02-10 17:12:37.589741	莊園好茶
140	4	糯烏龍	0.00	2026-02-10 17:12:37.589741	莊園好茶
141	4	花開茉綠茶	0.00	2026-02-10 17:12:37.589741	莊園好茶
142	4	硬頸奶茶	0.00	2026-02-10 17:12:37.589741	硬頸乳茶
143	4	硬頸乳茶	0.00	2026-02-10 17:12:37.589741	硬頸乳茶
144	4	蜜桃風味水果茶	0.00	2026-02-10 17:12:37.589741	招牌水果茶
145	4	英式玫瑰水果茶	0.00	2026-02-10 17:12:37.589741	招牌水果茶
146	4	皇家伯爵水果茶	0.00	2026-02-10 17:12:37.589741	招牌水果茶
147	4	花開茉綠茶拿鐵	0.00	2026-02-10 17:12:37.589741	英式鮮奶茶
148	4	錫蘭莊園紅茶拿鐵	0.00	2026-02-10 17:12:37.589741	英式鮮奶茶
149	4	蜜桃風味拿鐵	0.00	2026-02-10 17:12:37.589741	英式鮮奶茶
150	4	皇家伯爵拿鐵	0.00	2026-02-10 17:12:37.589741	英式鮮奶茶
151	4	巧克力伯爵拿鐵	0.00	2026-02-10 17:12:37.589741	英式鮮奶茶
152	4	輕焙穀麥拿鐵	0.00	2026-02-10 17:12:37.589741	英式鮮奶茶
153	4	糯烏龍拿鐵	0.00	2026-02-10 17:12:37.589741	英式鮮奶茶
154	4	朵朵奶蓋蜜桃風味茶	0.00	2026-02-10 17:12:37.589741	朵朵海鹽奶蓋
155	4	蜂蜜花開茉綠茶	0.00	2026-02-10 17:12:37.589741	特調
156	4	蜂蜜四季春茶	0.00	2026-02-10 17:12:37.589741	特調
157	4	玫瑰水	0.00	2026-02-10 17:12:37.589741	特調
158	4	冬瓜糯烏龍	0.00	2026-02-10 17:12:37.589741	特調
159	4	錫蘭高地莊園奶茶	0.00	2026-02-10 17:12:37.589741	精選奶茶
160	4	花開茉綠奶茶	0.00	2026-02-10 17:12:37.589741	精選奶茶
161	4	蜜桃風味奶茶	0.00	2026-02-10 17:12:37.589741	精選奶茶
162	4	皇家伯爵奶茶	0.00	2026-02-10 17:12:37.589741	精選奶茶
163	4	英式玫瑰奶茶	0.00	2026-02-10 17:12:37.589741	精選奶茶
164	4	巧克力伯爵奶茶	0.00	2026-02-10 17:12:37.589741	精選奶茶
165	4	錫蘭高地珍珠奶茶	0.00	2026-02-10 17:12:37.589741	精選奶茶
166	4	輕焙穀麥奶茶	0.00	2026-02-10 17:12:37.589741	精選奶茶
167	5	白韻杏仁奶	0.00	2026-02-10 17:12:37.589741	新品系列
168	5	白韻杏仁鮮奶	0.00	2026-02-10 17:12:37.589741	新品系列
169	5	白韻杏仁頂級可可	0.00	2026-02-10 17:12:37.589741	新品系列
170	5	桂圓茶	0.00	2026-02-10 17:12:37.589741	冬季熱飲
171	5	桂圓鮮奶茶	0.00	2026-02-10 17:12:37.589741	冬季熱飲
172	5	薑薑好茶	0.00	2026-02-10 17:12:37.589741	冬季熱飲
173	5	薑薑奶茶	0.00	2026-02-10 17:12:37.589741	冬季熱飲
174	5	烏龍綠茶	0.00	2026-02-10 17:12:37.589741	茗品系列
175	5	特級綠茶	0.00	2026-02-10 17:12:37.589741	茗品系列
176	5	錫蘭紅茶	0.00	2026-02-10 17:12:37.589741	茗品系列
177	5	極品菁茶	0.00	2026-02-10 17:12:37.589741	茗品系列
178	5	特選普洱	0.00	2026-02-10 17:12:37.589741	茗品系列
179	5	烏龍菁茶	0.00	2026-02-10 17:12:37.589741	茗品系列
180	5	@綠+紅	0.00	2026-02-10 17:12:37.589741	茗品系列
181	5	冬瓜茶	0.00	2026-02-10 17:12:37.589741	冬瓜/百香系列
182	5	冬瓜檸檬	0.00	2026-02-10 17:12:37.589741	冬瓜/百香系列
183	5	冬瓜菁茶	0.00	2026-02-10 17:12:37.589741	冬瓜/百香系列
184	5	百香果綠茶	0.00	2026-02-10 17:12:37.589741	冬瓜/百香系列
185	5	雙Q百香果綠茶	0.00	2026-02-10 17:12:37.589741	冬瓜/百香系列
186	5	蜜桃凍紅茶	0.00	2026-02-10 17:12:37.589741	特調系列
187	5	梅子綠茶	0.00	2026-02-10 17:12:37.589741	特調系列
188	5	蜂蜜烏龍	0.00	2026-02-10 17:12:37.589741	特調系列
189	5	頂級可可	0.00	2026-02-10 17:12:37.589741	特調系列
190	5	濃情巧克力	0.00	2026-02-10 17:12:37.589741	特調系列
191	5	蜜茶	0.00	2026-02-10 17:12:37.589741	特調系列
192	5	咖啡奶茶	0.00	2026-02-10 17:12:37.589741	特調系列
193	5	蜂蜜綠茶	0.00	2026-02-10 17:12:37.589741	特調系列
194	5	荔枝紅茶	0.00	2026-02-10 17:12:37.589741	特調系列
195	5	妃嚐美荔	0.00	2026-02-10 17:12:37.589741	特調系列
196	5	桔茶	0.00	2026-02-10 17:12:37.589741	季節鮮果系列
197	5	鮮橙綠	0.00	2026-02-10 17:12:37.589741	季節鮮果系列
198	5	甘蔗金桔	0.00	2026-02-10 17:12:37.589741	季節鮮果系列
199	5	甘蔗菁茶	0.00	2026-02-10 17:12:37.589741	季節鮮果系列
200	5	鳳梨紅茶	0.00	2026-02-10 17:12:37.589741	季節鮮果系列
201	5	珍珠琥珀黑糖鮮奶	0.00	2026-02-10 17:12:37.589741	鮮奶/拿鐵系列
202	5	鮮奶茶	0.00	2026-02-10 17:12:37.589741	鮮奶/拿鐵系列
203	5	珍珠鮮奶茶	0.00	2026-02-10 17:12:37.589741	鮮奶/拿鐵系列
204	5	(隱藏版)珍珠蜂蜜鮮奶普洱	0.00	2026-02-10 17:12:37.589741	鮮奶/拿鐵系列
205	5	頂級可可拿鐵	0.00	2026-02-10 17:12:37.589741	鮮奶/拿鐵系列
206	5	鮮奶冬瓜	0.00	2026-02-10 17:12:37.589741	鮮奶/拿鐵系列
207	5	咖啡拿鐵	0.00	2026-02-10 17:12:37.589741	鮮奶/拿鐵系列
208	5	珍珠芝麻拿鐵	0.00	2026-02-10 17:12:37.589741	鮮奶/拿鐵系列
209	5	雙凍拿鐵(綠茶凍、仙草凍)	0.00	2026-02-10 17:12:37.589741	鮮奶/拿鐵系列
210	5	茉綠茶凍拿鐵	0.00	2026-02-10 17:12:37.589741	鮮奶/拿鐵系列
211	5	粉戀莓莓	0.00	2026-02-10 17:12:37.589741	鮮奶/拿鐵系列
212	5	琥珀黑糖奶茶	0.00	2026-02-10 17:12:37.589741	奶茶系列
213	5	珍珠奶茶	0.00	2026-02-10 17:12:37.589741	奶茶系列
214	5	錫蘭奶紅	0.00	2026-02-10 17:12:37.589741	奶茶系列
215	5	烏龍奶茶	0.00	2026-02-10 17:12:37.589741	奶茶系列
216	5	特級奶綠	0.00	2026-02-10 17:12:37.589741	奶茶系列
217	5	仙草凍奶茶	0.00	2026-02-10 17:12:37.589741	奶茶系列
218	5	椰果奶茶	0.00	2026-02-10 17:12:37.589741	奶茶系列
219	5	布丁奶茶	0.00	2026-02-10 17:12:37.589741	奶茶系列
220	5	暗黑水晶奶茶	0.00	2026-02-10 17:12:37.589741	奶茶系列
221	5	蜂蜜奶茶	0.00	2026-02-10 17:12:37.589741	奶茶系列
222	5	芝麻奶茶	0.00	2026-02-10 17:12:37.589741	奶茶系列
223	5	極品奶菁	0.00	2026-02-10 17:12:37.589741	奶茶系列
224	5	烏龍奶菁	0.00	2026-02-10 17:12:37.589741	奶茶系列
225	5	普洱奶茶	0.00	2026-02-10 17:12:37.589741	奶茶系列
226	5	奶茶	0.00	2026-02-10 17:12:37.589741	奶茶系列
227	5	茶凍奶綠	0.00	2026-02-10 17:12:37.589741	奶茶系列
228	5	優多綠茶	0.00	2026-02-10 17:12:37.589741	優多系列
229	5	優多百香果綠茶	0.00	2026-02-10 17:12:37.589741	優多系列
230	5	紅心芭樂優多	0.00	2026-02-10 17:12:37.589741	優多系列
231	5	優多莓莓	0.00	2026-02-10 17:12:37.589741	優多系列
232	5	蘋果醋	0.00	2026-02-10 17:12:37.589741	果醋系列
233	5	蘋果醋紅茶	0.00	2026-02-10 17:12:37.589741	果醋系列
234	5	蜂蜜蘋果醋	0.00	2026-02-10 17:12:37.589741	果醋系列
235	5	藍莓醋	0.00	2026-02-10 17:12:37.589741	果醋系列
236	5	蜂蜜藍莓醋	0.00	2026-02-10 17:12:37.589741	果醋系列
237	5	荔枝蘋果醋	0.00	2026-02-10 17:12:37.589741	果醋系列
238	5	Red Bull紅牛能量紅茶	0.00	2026-02-10 17:12:37.589741	Red Bull能量系列
239	5	Red Bull紅牛能量藍莓蜜	0.00	2026-02-10 17:12:37.589741	Red Bull能量系列
240	5	Red Bull巨峰葡萄能量優多	0.00	2026-02-10 17:12:37.589741	Red Bull能量系列
241	5	Red Bull巨峰葡萄能量果醋	0.00	2026-02-10 17:12:37.589741	Red Bull能量系列
242	6	桂香輕蕎麥	0.00	2026-02-10 17:12:37.589741	熱銷新品
243	6	娜杯桂香拿鐵	0.00	2026-02-10 17:12:37.589741	熱銷新品
244	6	香芋仙草綠茶拿鐵	0.00	2026-02-10 17:12:37.589741	熱銷新品
245	6	靜岡焙焙鮮奶	0.00	2026-02-10 17:12:37.589741	熱銷新品
246	6	娜杯紅茶	0.00	2026-02-10 17:12:37.589741	愛茶的牛
247	6	茉莉原淬綠茶	0.00	2026-02-10 17:12:37.589741	愛茶的牛
248	6	水之森玄米抹茶	0.00	2026-02-10 17:12:37.589741	愛茶的牛
249	6	熟釀青梅綠	0.00	2026-02-10 17:12:37.589741	鮮調果茶
250	6	熟釀青梅檸	0.00	2026-02-10 17:12:37.589741	鮮調果茶
251	6	香柚綠茶	0.00	2026-02-10 17:12:37.589741	鮮調果茶
252	6	養樂多綠	0.00	2026-02-10 17:12:37.589741	鮮調果茶
253	6	青檸香茶	0.00	2026-02-10 17:12:37.589741	鮮調果茶
254	6	柳丁綠茶	0.00	2026-02-10 17:12:37.589741	鮮調果茶
255	6	冰萃柳丁	0.00	2026-02-10 17:12:37.589741	鮮調果茶
256	6	蜂蜜檸檬晶凍	0.00	2026-02-10 17:12:37.589741	鮮調果茶
257	6	娜杯紅茶拿鐵	0.00	2026-02-10 17:12:37.589741	醇濃鮮奶茶
258	6	茉香綠茶拿鐵	0.00	2026-02-10 17:12:37.589741	醇濃鮮奶茶
259	6	珍珠娜杯紅茶拿鐵	0.00	2026-02-10 17:12:37.589741	醇濃鮮奶茶
260	6	芋頭鮮奶	0.00	2026-02-10 17:12:37.589741	醇濃綠光鮮奶
261	6	手炒黑糖鮮奶	0.00	2026-02-10 17:12:37.589741	醇濃綠光鮮奶
262	6	法芙娜可可鮮奶	0.00	2026-02-10 17:12:37.589741	醇濃綠光鮮奶
263	6	珍珠鮮奶	0.00	2026-02-10 17:12:37.589741	醇濃綠光鮮奶
264	6	嫩仙草凍奶	0.00	2026-02-10 17:12:37.589741	醇濃綠光鮮奶
265	6	綠光純鮮奶家庭號	0.00	2026-02-10 17:12:37.589741	醇濃綠光鮮奶
266	6	玄米抹茶鮮奶	0.00	2026-02-10 17:12:37.589741	醇濃綠光鮮奶
267	6	輕纖蕎麥拿鐵	0.00	2026-02-10 17:12:37.589741	無咖啡因
268	6	輕纖蕎麥茶	0.00	2026-02-10 17:12:37.589741	無咖啡因
269	6	原鄉冬瓜茶	0.00	2026-02-10 17:12:37.589741	無咖啡因
270	6	焙香決明大麥	0.00	2026-02-10 17:12:37.589741	無咖啡因
271	6	焙香大麥拿鐵	0.00	2026-02-10 17:12:37.589741	無咖啡因
272	6	冬瓜檸檬	0.00	2026-02-10 17:12:37.589741	無咖啡因
273	6	冬瓜麥茶	0.00	2026-02-10 17:12:37.589741	無咖啡因
274	7	小葉紅茶	0.00	2026-02-10 17:12:37.589741	原葉鮮萃茶 TEAPRESSO
275	7	鮮萃大麥紅茶	0.00	2026-02-10 17:12:37.589741	原葉鮮萃茶 TEAPRESSO
276	7	嗨神	0.00	2026-02-10 17:12:37.589741	原葉鮮萃茶 TEAPRESSO
277	7	玩火	0.00	2026-02-10 17:12:37.589741	原葉鮮萃茶 TEAPRESSO
278	7	四季春	0.00	2026-02-10 17:12:37.589741	原葉鮮萃茶 TEAPRESSO
279	7	烏龍綠茶	0.00	2026-02-10 17:12:37.589741	原葉鮮萃茶 TEAPRESSO
280	7	碧螺春	0.00	2026-02-10 17:12:37.589741	原葉鮮萃茶 TEAPRESSO
281	7	金萱茶	0.00	2026-02-10 17:12:37.589741	原葉鮮萃茶 TEAPRESSO
282	7	茉莉烏龍	0.00	2026-02-10 17:12:37.589741	原葉鮮萃茶 TEAPRESSO
283	7	烏瓦紅茶	0.00	2026-02-10 17:12:37.589741	原葉鮮萃茶 TEAPRESSO
284	7	熟滄觀音	0.00	2026-02-10 17:12:37.589741	原葉鮮萃茶 TEAPRESSO
285	7	玫瑰普洱	0.00	2026-02-10 17:12:37.589741	原葉鮮萃茶 TEAPRESSO
286	7	東方美人	0.00	2026-02-10 17:12:37.589741	原葉鮮萃茶 TEAPRESSO
287	7	文山包種	0.00	2026-02-10 17:12:37.589741	原葉鮮萃茶 TEAPRESSO
288	7	白桃蜜烏龍	0.00	2026-02-10 17:12:37.589741	原葉鮮萃茶 TEAPRESSO
289	7	桂花四季春	0.00	2026-02-10 17:12:37.589741	原葉鮮萃茶 TEAPRESSO
290	7	小葉紅奶茶	0.00	2026-02-10 17:12:37.589741	鮮萃茶奶茶 TEAPRESSO MILK TEA
291	7	大麥奶茶	0.00	2026-02-10 17:12:37.589741	鮮萃茶奶茶 TEAPRESSO MILK TEA
292	7	嗨神奶茶	0.00	2026-02-10 17:12:37.589741	鮮萃茶奶茶 TEAPRESSO MILK TEA
293	7	玩火奶茶	0.00	2026-02-10 17:12:37.589741	鮮萃茶奶茶 TEAPRESSO MILK TEA
294	7	四季春奶茶	0.00	2026-02-10 17:12:37.589741	鮮萃茶奶茶 TEAPRESSO MILK TEA
295	7	玫瑰普洱奶茶	0.00	2026-02-10 17:12:37.589741	鮮萃茶奶茶 TEAPRESSO MILK TEA
296	7	烏龍奶茶	0.00	2026-02-10 17:12:37.589741	鮮萃茶奶茶 TEAPRESSO MILK TEA
297	7	茉莉烏龍奶茶	0.00	2026-02-10 17:12:37.589741	鮮萃茶奶茶 TEAPRESSO MILK TEA
298	7	觀音奶茶	0.00	2026-02-10 17:12:37.589741	鮮萃茶奶茶 TEAPRESSO MILK TEA
299	7	黑糖紅茶拿鐵	0.00	2026-02-10 17:12:37.589741	鮮萃茶拿鐵 TEAPRESSO LATTE
300	7	小葉紅拿鐵	0.00	2026-02-10 17:12:37.589741	鮮萃茶拿鐵 TEAPRESSO LATTE
301	7	四季春拿鐵	0.00	2026-02-10 17:12:37.589741	鮮萃茶拿鐵 TEAPRESSO LATTE
302	7	玫瑰普洱拿鐵	0.00	2026-02-10 17:12:37.589741	鮮萃茶拿鐵 TEAPRESSO LATTE
303	7	烏龍拿鐵	0.00	2026-02-10 17:12:37.589741	鮮萃茶拿鐵 TEAPRESSO LATTE
304	7	茉莉烏龍拿鐵	0.00	2026-02-10 17:12:37.589741	鮮萃茶拿鐵 TEAPRESSO LATTE
305	7	烏瓦紅茶拿鐵	0.00	2026-02-10 17:12:37.589741	鮮萃茶拿鐵 TEAPRESSO LATTE
306	7	金萱拿鐵	0.00	2026-02-10 17:12:37.589741	鮮萃茶拿鐵 TEAPRESSO LATTE
307	7	觀音拿鐵	0.00	2026-02-10 17:12:37.589741	鮮萃茶拿鐵 TEAPRESSO LATTE
308	7	文山包種拿鐵	0.00	2026-02-10 17:12:37.589741	鮮萃茶拿鐵 TEAPRESSO LATTE
309	7	沖繩黑糖奶茶	0.00	2026-02-10 17:12:37.589741	奶茶/特調 MILK TEA / SPECIAL
310	7	沖繩黑糖奶綠	0.00	2026-02-10 17:12:37.589741	奶茶/特調 MILK TEA / SPECIAL
311	7	黑糖港式厚奶	0.00	2026-02-10 17:12:37.589741	奶茶/特調 MILK TEA / SPECIAL
312	7	雙Q奶茶1號條	0.00	2026-02-10 17:12:37.589741	奶茶/特調 MILK TEA / SPECIAL
313	7	雙Q奶茶2號芋	0.00	2026-02-10 17:12:37.589741	奶茶/特調 MILK TEA / SPECIAL
314	7	招牌奶茶	0.00	2026-02-10 17:12:37.589741	奶茶/特調 MILK TEA / SPECIAL
315	7	黃金奶綠	0.00	2026-02-10 17:12:37.589741	奶茶/特調 MILK TEA / SPECIAL
316	7	珍珠奶茶	0.00	2026-02-10 17:12:37.589741	奶茶/特調 MILK TEA / SPECIAL
317	7	珍珠奶綠	0.00	2026-02-10 17:12:37.589741	奶茶/特調 MILK TEA / SPECIAL
318	7	粉條奶茶	0.00	2026-02-10 17:12:37.589741	奶茶/特調 MILK TEA / SPECIAL
319	7	仙草凍奶茶	0.00	2026-02-10 17:12:37.589741	奶茶/特調 MILK TEA / SPECIAL
320	7	桂花奶綠	0.00	2026-02-10 17:12:37.589741	奶茶/特調 MILK TEA / SPECIAL
321	7	港式厚奶	0.00	2026-02-10 17:12:37.589741	奶茶/特調 MILK TEA / SPECIAL
322	7	經典可可	0.00	2026-02-10 17:12:37.589741	奶茶/特調 MILK TEA / SPECIAL
323	7	可可拿鐵	0.00	2026-02-10 17:12:37.589741	奶茶/特調 MILK TEA / SPECIAL
324	7	宇治抹茶	0.00	2026-02-10 17:12:37.589741	奶茶/特調 MILK TEA / SPECIAL
325	7	抹茶拿鐵	0.00	2026-02-10 17:12:37.589741	奶茶/特調 MILK TEA / SPECIAL
326	7	話梅冰綠	0.00	2026-02-10 17:12:37.589741	鮮調果茶 SPECIALTY
327	7	話梅檸檬綠	0.00	2026-02-10 17:12:37.589741	鮮調果茶 SPECIALTY
328	7	錫蘭紅茶	0.00	2026-02-10 17:12:37.589741	鮮調果茶 SPECIALTY
329	7	茉莉綠茶	0.00	2026-02-10 17:12:37.589741	鮮調果茶 SPECIALTY
330	7	蜂蜜紅茶	0.00	2026-02-10 17:12:37.589741	鮮調果茶 SPECIALTY
331	7	蜂蜜綠茶	0.00	2026-02-10 17:12:37.589741	鮮調果茶 SPECIALTY
332	7	玉荷冰綠	0.00	2026-02-10 17:12:37.589741	鮮調果茶 SPECIALTY
333	7	檸檬紅茶	0.00	2026-02-10 17:12:37.589741	鮮調果茶 SPECIALTY
334	7	檸檬綠茶	0.00	2026-02-10 17:12:37.589741	鮮調果茶 SPECIALTY
335	7	養樂多綠茶	0.00	2026-02-10 17:12:37.589741	鮮調果茶 SPECIALTY
336	7	百香搖果樂	0.00	2026-02-10 17:12:37.589741	鮮調果茶 SPECIALTY
337	7	蘋果冰茶	0.00	2026-02-10 17:12:37.589741	鮮調果茶 SPECIALTY
338	7	鳳梨冰茶	0.00	2026-02-10 17:12:37.589741	鮮調果茶 SPECIALTY
339	7	芭樂檸檬綠	0.00	2026-02-10 17:12:37.589741	鮮調果茶 SPECIALTY
340	7	超桔霸氣飲	0.00	2026-02-10 17:12:37.589741	果然系列 (無咖啡因 DECAFFEINE)
341	7	蜂蜜蘆薈	0.00	2026-02-10 17:12:37.589741	果然系列 (無咖啡因 DECAFFEINE)
342	7	金桔檸檬	0.00	2026-02-10 17:12:37.589741	果然系列 (無咖啡因 DECAFFEINE)
343	7	荔枝玉露	0.00	2026-02-10 17:12:37.589741	果然系列 (無咖啡因 DECAFFEINE)
344	7	纖美小紫蘇	0.00	2026-02-10 17:12:37.589741	果然系列 (無咖啡因 DECAFFEINE)
345	7	芭樂多多	0.00	2026-02-10 17:12:37.589741	果然系列 (無咖啡因 DECAFFEINE)
346	7	檸檬愛玉風味飲	0.00	2026-02-10 17:12:37.589741	夏季季節限定 SEASONAL
347	7	葡萄柚綠茶	0.00	2026-02-10 17:12:37.589741	夏季季節限定 SEASONAL
348	7	青檸香柚QQ	0.00	2026-02-10 17:12:37.589741	夏季季節限定 SEASONAL
349	7	桂圓紅棗	0.00	2026-02-10 17:12:37.589741	冬季季節限定 SEASONAL
350	7	暖薑茶	0.00	2026-02-10 17:12:37.589741	冬季季節限定 SEASONAL
351	7	暖薑奶茶	0.00	2026-02-10 17:12:37.589741	冬季季節限定 SEASONAL
352	7	熱檸紅茶	0.00	2026-02-10 17:12:37.589741	冬季季節限定 SEASONAL
353	7	熱檸綠茶	0.00	2026-02-10 17:12:37.589741	冬季季節限定 SEASONAL
354	7	熱桔茶	0.00	2026-02-10 17:12:37.589741	冬季季節限定 SEASONAL
355	7	紫米奶茶	0.00	2026-02-10 17:12:37.589741	冬季季節限定 SEASONAL
356	7	紫米可可	0.00	2026-02-10 17:12:37.589741	冬季季節限定 SEASONAL
357	7	黑糖薑汁可可	0.00	2026-02-10 17:12:37.589741	冬季季節限定 SEASONAL
358	8	極品紅茶	0.00	2026-02-10 17:12:37.589741	醇萃
359	8	翡翠綠茶	0.00	2026-02-10 17:12:37.589741	醇萃
360	8	青四季春	0.00	2026-02-10 17:12:37.589741	醇萃
361	8	三韻紅萱	0.00	2026-02-10 17:12:37.589741	醇萃
362	8	三十三茶王	0.00	2026-02-10 17:12:37.589741	醇萃
363	8	碎銀普洱茶	0.00	2026-02-10 17:12:37.589741	醇萃
364	8	花沫烏龍	0.00	2026-02-10 17:12:37.589741	醇萃
365	8	紅柚翡翠	0.00	2026-02-10 17:12:37.589741	鮮調
366	8	鮮果百香紅茶	0.00	2026-02-10 17:12:37.589741	鮮調
367	8	鮮果百香綠茶	0.00	2026-02-10 17:12:37.589741	鮮調
368	8	翡翠雷夢	0.00	2026-02-10 17:12:37.589741	鮮調
369	8	柳丁翡翠	0.00	2026-02-10 17:12:37.589741	鮮調
370	8	蘋果紅萱	0.00	2026-02-10 17:12:37.589741	鮮調
371	8	蜜桃烏龍	0.00	2026-02-10 17:12:37.589741	鮮調
372	8	阿源楊桃紅茶	0.00	2026-02-10 17:12:37.589741	鄉韻
373	8	阿源楊桃綠茶	0.00	2026-02-10 17:12:37.589741	鄉韻
374	8	楊桃雷夢	0.00	2026-02-10 17:12:37.589741	鄉韻
375	8	冬瓜雷夢	0.00	2026-02-10 17:12:37.589741	鄉韻
376	8	冬瓜茶王	0.00	2026-02-10 17:12:37.589741	鄉韻
377	8	甘蔗四季春	0.00	2026-02-10 17:12:37.589741	鄉韻
378	8	豆漿紅茶	0.00	2026-02-10 17:12:37.589741	鄉韻
379	8	冬瓜鮮乳	0.00	2026-02-10 17:12:37.589741	小農鮮乳坊
380	8	巧克鮮乳茶	0.00	2026-02-10 17:12:37.589741	小農鮮乳坊
381	8	龜記濃乳茶	0.00	2026-02-10 17:12:37.589741	小農鮮乳坊
382	8	極品鮮乳茶	0.00	2026-02-10 17:12:37.589741	小農鮮乳坊
383	8	翡翠鮮乳茶	0.00	2026-02-10 17:12:37.589741	小農鮮乳坊
384	8	碎銀普洱鮮乳	0.00	2026-02-10 17:12:37.589741	小農鮮乳坊
385	8	茶王鮮乳茶	0.00	2026-02-10 17:12:37.589741	小農鮮乳坊
386	8	蜂蜜綠茶	0.00	2026-02-10 17:12:37.589741	蜜蜂工坊
387	8	蜂蜜四季春	0.00	2026-02-10 17:12:37.589741	蜜蜂工坊
388	8	蜂蜜雷夢	0.00	2026-02-10 17:12:37.589741	蜜蜂工坊
389	8	雷夢蘆薈蜜	0.00	2026-02-10 17:12:37.589741	蜜蜂工坊
390	8	蜂蜜花沫烏龍	0.00	2026-02-10 17:12:37.589741	蜜蜂工坊
391	8	蜂蜜奶茶	0.00	2026-02-10 17:12:37.589741	奶茶
392	8	極品奶茶	0.00	2026-02-10 17:12:37.589741	奶茶
393	8	翡翠奶茶	0.00	2026-02-10 17:12:37.589741	奶茶
394	8	茶王奶茶	0.00	2026-02-10 17:12:37.589741	奶茶
395	8	碎銀普洱奶茶	0.00	2026-02-10 17:12:37.589741	奶茶
396	8	珍珠奶茶	0.00	2026-02-10 17:12:37.589741	奶茶
397	8	原味薑茶	0.00	2026-02-10 17:12:37.589741	冬日暖飲
398	8	薑汁奶茶	0.00	2026-02-10 17:12:37.589741	冬日暖飲
399	8	薑汁雷夢	0.00	2026-02-10 17:12:37.589741	冬日暖飲
400	9	阿薩姆紅茶	0.00	2026-02-10 17:12:37.589741	找好茶
401	9	茉莉綠茶	0.00	2026-02-10 17:12:37.589741	找好茶
402	9	四季春青茶	0.00	2026-02-10 17:12:37.589741	找好茶
403	9	黃金烏龍	0.00	2026-02-10 17:12:37.589741	找好茶
404	9	檸檬綠	0.00	2026-02-10 17:12:37.589741	找好茶
405	9	檸檬紅	0.00	2026-02-10 17:12:37.589741	找好茶
406	9	梅の綠	0.00	2026-02-10 17:12:37.589741	找好茶
407	9	冰綠	0.00	2026-02-10 17:12:37.589741	找好茶
408	9	桔子綠	0.00	2026-02-10 17:12:37.589741	找好茶
409	9	養樂多綠	0.00	2026-02-10 17:12:37.589741	找好茶
410	9	旺來紅	0.00	2026-02-10 17:12:37.589741	找好茶
411	9	旺來綠	0.00	2026-02-10 17:12:37.589741	找好茶
412	9	柚子烏龍	0.00	2026-02-10 17:12:37.589741	找好茶
413	9	麵茶綠	0.00	2026-02-10 17:12:37.589741	找好茶
414	9	麵茶紅	0.00	2026-02-10 17:12:37.589741	找好茶
415	9	麵茶青	0.00	2026-02-10 17:12:37.589741	找好茶
416	9	麵茶烏龍	0.00	2026-02-10 17:12:37.589741	找好茶
417	9	柚子紅	0.00	2026-02-10 17:12:37.589741	找好茶
418	9	柚子綠	0.00	2026-02-10 17:12:37.589741	找好茶
419	9	柚子青	0.00	2026-02-10 17:12:37.589741	找好茶
420	9	奶茶	0.00	2026-02-10 17:12:37.589741	找奶茶
421	9	奶綠	0.00	2026-02-10 17:12:37.589741	找奶茶
422	9	紅茶瑪奇朵	0.00	2026-02-10 17:12:37.589741	找奶茶
423	9	綠茶瑪奇朵	0.00	2026-02-10 17:12:37.589741	找奶茶
424	9	四季瑪奇朵	0.00	2026-02-10 17:12:37.589741	找奶茶
425	9	烏龍瑪奇朵	0.00	2026-02-10 17:12:37.589741	找奶茶
426	9	四季奶青	0.00	2026-02-10 17:12:37.589741	找奶茶
427	9	黃金烏龍奶	0.00	2026-02-10 17:12:37.589741	找奶茶
428	9	阿華田	0.00	2026-02-10 17:12:37.589741	找奶茶
429	9	麵茶奶綠	0.00	2026-02-10 17:12:37.589741	找奶茶
430	9	麵茶奶茶	0.00	2026-02-10 17:12:37.589741	找奶茶
431	9	麵茶四季奶青	0.00	2026-02-10 17:12:37.589741	找奶茶
432	9	麵茶黃金烏龍奶	0.00	2026-02-10 17:12:37.589741	找奶茶
433	9	波霸紅茶	0.00	2026-02-10 17:12:37.589741	找口感
434	9	波霸綠茶	0.00	2026-02-10 17:12:37.589741	找口感
435	9	波霸青茶	0.00	2026-02-10 17:12:37.589741	找口感
436	9	波霸烏龍茶	0.00	2026-02-10 17:12:37.589741	找口感
437	9	波霸奶茶	0.00	2026-02-10 17:12:37.589741	找口感
438	9	波霸奶綠	0.00	2026-02-10 17:12:37.589741	找口感
439	9	珍珠紅茶	0.00	2026-02-10 17:12:37.589741	找口感
440	9	珍珠綠茶	0.00	2026-02-10 17:12:37.589741	找口感
441	9	珍珠青茶	0.00	2026-02-10 17:12:37.589741	找口感
442	9	珍珠黃金烏龍	0.00	2026-02-10 17:12:37.589741	找口感
443	9	珍珠奶茶	0.00	2026-02-10 17:12:37.589741	找口感
444	9	布丁奶茶	0.00	2026-02-10 17:12:37.589741	找口感
445	9	布丁奶綠	0.00	2026-02-10 17:12:37.589741	找口感
446	9	布丁奶青	0.00	2026-02-10 17:12:37.589741	找口感
447	9	椰果奶茶	0.00	2026-02-10 17:12:37.589741	找口感
448	9	布丁黃金烏龍	0.00	2026-02-10 17:12:37.589741	找口感
449	9	布丁紅	0.00	2026-02-10 17:12:37.589741	找口感
450	9	布丁綠	0.00	2026-02-10 17:12:37.589741	找口感
451	9	布丁青	0.00	2026-02-10 17:12:37.589741	找口感
452	9	布丁烏龍奶茶	0.00	2026-02-10 17:12:37.589741	找口感
453	9	紅茶拿鐵	0.00	2026-02-10 17:12:37.589741	紅茶拿鐵
454	9	綠茶拿鐵	0.00	2026-02-10 17:12:37.589741	紅茶拿鐵
455	9	黃金烏龍拿鐵	0.00	2026-02-10 17:12:37.589741	紅茶拿鐵
456	9	阿華田拿鐵	0.00	2026-02-10 17:12:37.589741	紅茶拿鐵
457	9	珍珠鮮奶	0.00	2026-02-10 17:12:37.589741	紅茶拿鐵
458	9	波霸鮮奶	0.00	2026-02-10 17:12:37.589741	紅茶拿鐵
459	9	重焙烏龍拿鐵	0.00	2026-02-10 17:12:37.589741	紅茶拿鐵
460	9	麵茶綠茶拿鐵	0.00	2026-02-10 17:12:37.589741	紅茶拿鐵
461	9	麵茶紅茶拿鐵	0.00	2026-02-10 17:12:37.589741	紅茶拿鐵
462	9	麵茶四季拿鐵	0.00	2026-02-10 17:12:37.589741	紅茶拿鐵
463	9	麵茶黃金烏龍拿鐵	0.00	2026-02-10 17:12:37.589741	紅茶拿鐵
464	9	麵茶重焙烏龍拿鐵	0.00	2026-02-10 17:12:37.589741	紅茶拿鐵
465	9	冰茶	0.00	2026-02-10 17:12:37.589741	找新鮮
466	9	檸檬養樂多	0.00	2026-02-10 17:12:37.589741	找新鮮
467	9	檸檬汁	0.00	2026-02-10 17:12:37.589741	找新鮮
468	9	金桔檸檬	0.00	2026-02-10 17:12:37.589741	找新鮮
469	9	檸檬梅汁	0.00	2026-02-10 17:12:37.589741	找新鮮
470	9	柚子茶	0.00	2026-02-10 17:12:37.589741	找新鮮
471	9	芒果紅	0.00	2026-02-10 17:12:37.589741	找冰淇淋
472	9	芒果綠	0.00	2026-02-10 17:12:37.589741	找冰淇淋
473	9	芒果青	0.00	2026-02-10 17:12:37.589741	找冰淇淋
474	9	芒果烏龍	0.00	2026-02-10 17:12:37.589741	找冰淇淋
475	9	荔枝紅	0.00	2026-02-10 17:12:37.589741	找冰淇淋
476	9	荔枝綠	0.00	2026-02-10 17:12:37.589741	找冰淇淋
477	9	荔枝青	0.00	2026-02-10 17:12:37.589741	找冰淇淋
478	9	荔枝烏龍	0.00	2026-02-10 17:12:37.589741	找冰淇淋
479	9	冰淇淋紅茶	0.00	2026-02-10 17:12:37.589741	找冰淇淋
480	9	冰淇淋綠茶	0.00	2026-02-10 17:12:37.589741	找冰淇淋
481	9	冰淇淋青茶	0.00	2026-02-10 17:12:37.589741	找冰淇淋
482	9	冰淇淋烏龍茶	0.00	2026-02-10 17:12:37.589741	找冰淇淋
483	9	四季春珍波椰	0.00	2026-02-10 17:12:37.589741	店長推薦
484	9	珍珠奶綠	0.00	2026-02-10 17:12:37.589741	店長推薦
485	9	四季奶青瑪奇朵	0.00	2026-02-10 17:12:37.589741	店長推薦
486	10	職人美式(14oz)	0.00	2026-02-10 17:12:37.589741	醇品咖啡香
487	10	職人拿鐵(14oz)	0.00	2026-02-10 17:12:37.589741	醇品咖啡香
488	10	珍珠職人拿鐵(14oz)	0.00	2026-02-10 17:12:37.589741	醇品咖啡香
489	10	粉角職人拿鐵(14oz)	0.00	2026-02-10 17:12:37.589741	醇品咖啡香
490	10	珍珠黑糖拿鐵(14oz)	0.00	2026-02-10 17:12:37.589741	醇品咖啡香
491	10	紅柚香檸美式	0.00	2026-02-10 17:12:37.589741	醇品咖啡香
492	10	西西里手搗檸檬美式	0.00	2026-02-10 17:12:37.589741	醇品咖啡香
493	10	生椰職人拿鐵(14oz)	0.00	2026-02-10 17:12:37.589741	醇品咖啡香
494	10	粉角生椰拿鐵(14oz)	0.00	2026-02-10 17:12:37.589741	醇品咖啡香
495	10	台灣柳丁美式	0.00	2026-02-10 17:12:37.589741	醇品咖啡香
496	10	日安大麥	0.00	2026-02-10 17:12:37.589741	熱門新品
497	10	手作仙草凍乳	0.00	2026-02-10 17:12:37.589741	熱門新品
498	10	28茉輕乳茶	0.00	2026-02-10 17:12:37.589741	熱門新品
499	10	28茉粉角輕乳茶	0.00	2026-02-10 17:12:37.589741	熱門新品
500	10	手採紅茶	0.00	2026-02-10 17:12:37.589741	經典純茶
501	10	茉莉綠茶	0.00	2026-02-10 17:12:37.589741	經典純茶
502	10	四季春青茶	0.00	2026-02-10 17:12:37.589741	經典純茶
503	10	日式焙茶	0.00	2026-02-10 17:12:37.589741	經典純茶
504	10	２１歲輕烏龍	0.00	2026-02-10 17:12:37.589741	經典純茶
505	10	蕎麥四季春	0.00	2026-02-10 17:12:37.589741	經典純茶
506	10	仙草蜜	0.00	2026-02-10 17:12:37.589741	經典純茶
507	10	四季珍椰青	0.00	2026-02-10 17:12:37.589741	經典純茶
508	10	蜜香凍紅茶	0.00	2026-02-10 17:12:37.589741	經典純茶
509	10	蜜香凍綠茶	0.00	2026-02-10 17:12:37.589741	經典純茶
510	10	蜜香凍青茶	0.00	2026-02-10 17:12:37.589741	經典純茶
511	10	粉角檸檬冬瓜	0.00	2026-02-10 17:12:37.589741	激推果茶
512	10	檸檬奇遇桔	0.00	2026-02-10 17:12:37.589741	激推果茶
513	10	芒裡偷閒奇亞籽	0.00	2026-02-10 17:12:37.589741	激推果茶
514	10	２１歲輕檸烏龍	0.00	2026-02-10 17:12:37.589741	激推果茶
515	10	百香雙響炮	0.00	2026-02-10 17:12:37.589741	激推果茶
516	10	葡萄柚果粒茶	0.00	2026-02-10 17:12:37.589741	激推果茶
517	10	百香綠茶	0.00	2026-02-10 17:12:37.589741	激推果茶
518	10	芒果綠茶	0.00	2026-02-10 17:12:37.589741	激推果茶
519	10	蜜香檸凍紅茶	0.00	2026-02-10 17:12:37.589741	激推果茶
520	10	蜜香檸凍綠茶	0.00	2026-02-10 17:12:37.589741	激推果茶
521	10	蜜香檸凍青茶	0.00	2026-02-10 17:12:37.589741	激推果茶
522	10	蜜香檸凍冬瓜	0.00	2026-02-10 17:12:37.589741	激推果茶
523	10	檸檬紅茶	0.00	2026-02-10 17:12:37.589741	激推果茶
524	10	檸檬綠茶	0.00	2026-02-10 17:12:37.589741	激推果茶
525	10	檸檬青茶	0.00	2026-02-10 17:12:37.589741	激推果茶
526	10	檸檬冬瓜露	0.00	2026-02-10 17:12:37.589741	激推果茶
527	10	蕎麥冬瓜露	0.00	2026-02-10 17:12:37.589741	激推果茶
528	10	金桔檸檬	0.00	2026-02-10 17:12:37.589741	激推果茶
529	10	檸檬霸	0.00	2026-02-10 17:12:37.589741	激推果茶
530	10	綠茶養樂多	0.00	2026-02-10 17:12:37.589741	激推果茶
531	10	莓好雙果茶	0.00	2026-02-10 17:12:37.589741	莓果系列
532	10	莓好雙果牛乳	0.00	2026-02-10 17:12:37.589741	莓果系列
533	10	茉香奶茶	0.00	2026-02-10 17:12:37.589741	就愛喝奶茶
534	10	阿薩姆奶茶	0.00	2026-02-10 17:12:37.589741	就愛喝奶茶
535	10	珍珠奶茶	0.00	2026-02-10 17:12:37.589741	就愛喝奶茶
536	10	奶茶三兄弟	0.00	2026-02-10 17:12:37.589741	就愛喝奶茶
537	10	布丁奶茶	0.00	2026-02-10 17:12:37.589741	就愛喝奶茶
538	10	粉角奶茶	0.00	2026-02-10 17:12:37.589741	就愛喝奶茶
539	10	冬韻擂焙珍奶	0.00	2026-02-10 17:12:37.589741	就愛喝奶茶
540	10	日式焙奶茶	0.00	2026-02-10 17:12:37.589741	就愛喝奶茶
541	10	日焙珍珠奶茶	0.00	2026-02-10 17:12:37.589741	就愛喝奶茶
542	10	英式鮮奶茶	0.00	2026-02-10 17:12:37.589741	濃純鮮奶
543	10	珍珠鮮奶茶	0.00	2026-02-10 17:12:37.589741	濃純鮮奶
544	10	粉角鮮奶茶	0.00	2026-02-10 17:12:37.589741	濃純鮮奶
545	10	芋頭牛奶	0.00	2026-02-10 17:12:37.589741	濃純鮮奶
546	10	芋頭珍珠牛奶	0.00	2026-02-10 17:12:37.589741	濃純鮮奶
547	10	日焙鮮奶茶	0.00	2026-02-10 17:12:37.589741	濃純鮮奶
\.


--
-- Data for Name: product_composition; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_composition (id, product_id, ingredient_id) FROM stdin;
1	1	1
2	2	2
3	2	3
4	2	4
5	3	5
6	3	6
7	4	7
8	4	8
9	4	9
10	4	10
11	4	11
12	5	12
13	5	13
14	5	14
15	6	15
16	6	16
17	6	17
18	7	18
19	8	19
20	8	20
21	8	12
22	9	21
23	10	22
24	11	23
25	12	24
26	13	25
27	14	26
28	15	27
29	16	1
30	17	4
31	17	21
32	18	28
33	18	4
34	19	29
35	19	30
36	20	31
37	20	32
38	20	33
39	21	34
40	21	12
41	22	26
42	22	35
43	23	36
44	23	4
45	24	37
46	24	38
47	24	39
48	24	40
49	25	41
50	25	42
51	25	16
52	25	21
53	26	43
54	26	42
55	26	44
56	27	42
57	27	32
58	28	42
59	28	45
60	29	42
61	29	46
62	30	42
63	30	47
64	31	43
65	31	42
66	31	29
67	32	42
68	32	48
69	32	21
70	33	12
71	33	49
72	33	50
73	34	11
74	34	51
75	34	52
76	35	3
77	35	53
78	35	54
79	36	21
80	36	8
81	36	12
82	36	41
83	36	40
84	36	55
85	36	56
86	37	57
87	37	8
88	37	12
89	37	56
90	37	58
91	38	19
92	38	59
93	38	60
94	39	61
95	39	12
96	39	58
97	39	54
98	40	62
99	40	63
100	41	64
101	41	65
102	41	49
103	42	65
104	42	5
105	43	65
106	43	45
107	44	65
108	44	66
109	45	65
110	45	47
111	46	65
112	46	21
113	46	6
114	47	65
115	47	48
116	48	39
117	48	67
118	49	67
119	49	18
120	49	17
121	50	67
122	50	68
123	51	69
124	52	70
125	52	71
126	53	71
127	54	72
128	55	73
129	56	74
130	57	74
131	58	75
132	59	76
133	60	77
134	61	78
135	61	79
136	62	80
137	62	79
138	63	81
139	63	79
140	64	82
141	64	79
142	65	82
143	65	83
144	65	84
145	66	69
146	66	85
147	67	69
148	67	83
149	67	84
150	67	86
151	68	69
152	68	87
153	68	88
154	69	89
155	69	72
156	69	90
157	69	91
158	69	92
159	70	89
160	70	90
161	70	73
162	70	91
163	70	92
164	71	89
165	71	93
166	71	90
167	71	91
168	71	92
169	72	89
170	72	90
171	72	94
172	72	91
173	72	92
174	73	95
175	73	92
176	74	79
177	74	96
178	74	97
179	75	98
180	75	99
181	76	100
182	76	101
183	77	102
184	77	96
185	78	74
186	78	103
187	79	74
188	79	103
189	80	100
190	80	104
191	80	99
192	81	105
193	81	106
194	81	107
195	81	79
196	82	107
197	82	74
198	82	108
199	83	107
200	83	74
201	83	108
202	84	96
203	84	99
204	85	102
205	85	96
206	86	104
207	86	109
208	86	103
209	87	96
210	87	101
211	88	110
212	88	111
213	89	112
214	89	96
215	89	113
216	90	96
217	90	114
218	90	115
219	91	82
220	91	116
221	92	96
222	92	82
223	92	74
224	93	117
225	94	118
226	94	117
227	95	119
228	95	117
229	96	120
230	96	117
231	97	117
232	97	121
233	98	122
234	99	123
235	100	124
236	101	124
237	102	124
238	103	125
239	103	124
240	104	126
241	104	125
242	105	127
243	105	125
244	105	124
245	106	127
246	106	125
247	106	123
248	107	125
249	107	128
250	108	120
251	108	122
252	109	120
253	109	124
254	110	120
255	110	126
256	111	120
257	111	128
258	112	129
259	112	130
260	112	131
261	113	132
262	113	133
263	113	131
264	114	134
265	114	131
266	115	135
267	115	136
268	115	131
269	116	137
270	116	131
271	116	138
272	117	139
273	117	124
274	117	138
275	117	140
276	118	121
277	118	141
278	119	142
279	119	121
280	120	143
281	120	121
282	121	128
283	121	121
284	122	144
285	122	145
286	122	146
287	122	147
288	123	144
289	123	148
290	123	147
291	124	144
292	124	149
293	124	147
294	125	144
295	125	150
296	125	147
297	126	144
298	126	151
299	126	148
300	127	151
301	127	149
302	127	144
303	128	144
304	128	149
305	128	152
306	128	145
307	129	144
308	129	152
309	129	153
310	130	144
311	130	149
312	130	152
313	131	151
314	131	146
315	131	154
316	132	149
317	132	155
318	132	156
319	132	157
320	133	158
321	134	159
322	134	160
323	135	149
324	135	145
325	136	148
326	136	161
327	137	149
328	138	149
329	138	162
330	139	149
331	139	154
332	140	163
333	140	164
334	140	165
335	141	166
336	141	167
337	141	168
338	142	169
339	142	170
340	143	169
341	143	151
342	144	149
343	144	156
344	144	157
345	144	145
346	145	154
347	145	157
348	145	156
349	145	155
350	145	149
351	146	149
352	146	155
353	146	156
354	146	157
355	147	151
356	147	167
357	147	166
358	147	168
359	148	151
360	148	149
361	149	151
362	149	149
363	149	145
364	150	151
365	150	149
366	150	162
367	151	151
368	151	149
369	151	171
370	151	162
371	152	169
372	152	151
373	153	151
374	153	172
375	154	151
376	154	149
377	154	145
378	155	166
379	155	167
380	155	168
381	155	173
382	156	158
383	156	173
384	157	154
385	158	163
386	158	172
387	159	149
388	159	152
389	160	166
390	160	152
391	160	168
392	160	167
393	161	149
394	161	152
395	161	145
396	162	149
397	162	152
398	162	162
399	163	149
400	163	152
401	163	154
402	164	149
403	164	152
404	164	171
405	164	162
406	165	174
407	165	149
408	165	152
409	166	169
410	166	152
411	167	175
412	167	176
413	168	177
414	168	176
415	169	175
416	169	176
417	169	178
418	170	179
419	170	180
420	171	177
421	171	179
422	171	180
423	172	181
424	172	182
425	173	183
426	173	181
427	173	182
428	174	184
429	174	185
430	175	184
431	176	186
432	177	187
433	178	188
434	179	187
435	179	185
436	180	184
437	180	186
438	181	189
439	182	189
440	182	190
441	182	191
442	183	189
443	183	187
444	184	184
445	184	192
446	185	193
447	185	184
448	185	194
449	185	192
450	186	195
451	186	196
452	186	197
453	186	198
454	187	199
455	187	184
456	187	200
457	188	185
458	188	201
459	189	175
460	189	178
461	190	177
462	190	178
463	191	201
464	192	175
465	192	202
466	192	195
467	193	184
468	193	201
469	194	195
470	194	203
471	195	195
472	195	203
473	195	204
474	196	205
475	196	206
476	197	207
477	197	208
478	197	184
479	198	209
480	198	205
481	198	206
482	199	209
483	199	187
484	200	195
485	200	210
486	200	211
487	201	193
488	201	177
489	201	181
490	202	177
491	202	201
492	202	195
493	203	193
494	203	177
495	203	195
496	204	193
497	204	177
498	204	201
499	204	188
500	205	177
501	205	178
502	206	177
503	206	189
504	207	177
505	207	202
506	208	193
507	208	177
508	208	212
509	208	195
510	209	213
511	209	214
512	209	184
513	209	177
514	210	214
515	210	184
516	210	215
517	211	216
518	211	214
519	211	215
520	211	195
521	211	217
522	212	175
523	212	181
524	212	195
525	213	193
526	213	195
527	213	175
528	214	195
529	214	175
530	215	175
531	215	218
532	216	175
533	216	184
534	217	213
535	217	175
536	217	195
537	218	175
538	218	195
539	218	194
540	219	175
541	219	195
542	219	219
543	220	175
544	220	220
545	220	195
546	221	175
547	221	201
548	221	195
549	222	175
550	222	212
551	222	195
552	223	175
553	223	187
554	224	175
555	224	218
556	225	177
557	225	201
558	225	188
559	226	175
560	226	195
561	227	175
562	227	184
563	227	214
564	228	221
565	228	184
566	229	221
567	229	184
568	229	192
569	230	221
570	230	184
571	230	222
572	230	223
573	231	221
574	231	195
575	231	224
576	232	225
577	233	195
578	233	225
579	234	225
580	234	201
581	235	226
582	236	226
583	236	201
584	237	225
585	237	227
586	238	186
587	238	228
588	239	226
589	239	201
590	239	228
591	240	221
592	240	229
593	241	225
594	241	229
595	242	230
596	242	231
597	243	232
598	243	233
599	243	231
600	244	234
601	244	233
602	244	235
603	244	236
604	245	233
605	245	237
606	246	232
607	246	233
608	247	235
609	248	238
610	248	239
611	249	240
612	249	235
613	250	240
614	250	235
615	250	241
616	251	235
617	251	242
618	251	243
619	252	235
620	252	244
621	253	245
622	253	246
623	253	235
624	254	235
625	254	247
626	254	248
627	255	249
628	255	247
629	255	248
630	256	245
631	256	250
632	256	251
633	257	232
634	257	233
635	258	233
636	258	235
637	259	252
638	259	233
639	259	232
640	260	233
641	260	236
642	261	233
643	261	253
644	262	233
645	262	254
646	263	252
647	263	233
648	264	234
649	264	233
650	265	233
651	266	233
652	266	255
653	267	233
654	267	230
655	268	230
656	269	256
657	270	257
658	270	258
659	271	233
660	271	259
661	272	256
662	272	245
663	272	260
664	273	256
665	273	259
666	274	261
667	275	262
668	275	263
669	276	264
670	276	265
671	277	266
672	277	267
673	277	264
674	277	268
675	278	261
676	279	269
677	279	270
678	280	271
679	281	272
680	281	273
681	282	270
682	283	274
683	284	275
684	285	276
685	285	277
686	286	270
687	287	270
688	288	272
689	288	278
690	288	270
691	289	270
692	289	279
693	290	280
694	290	281
695	291	282
696	291	283
697	291	284
698	292	285
699	292	286
700	292	287
701	293	264
702	293	270
703	293	288
704	293	289
705	294	286
706	294	290
707	295	286
708	295	277
709	295	291
710	296	292
711	296	270
712	297	293
713	297	292
714	298	292
715	298	294
716	299	295
717	299	296
718	299	297
719	300	298
720	300	281
721	301	261
722	301	298
723	302	299
724	302	296
725	303	298
726	303	270
727	304	298
728	304	270
729	305	298
730	305	297
731	306	298
732	306	300
733	307	298
734	307	270
735	308	298
736	308	270
737	309	292
738	309	295
739	309	274
740	310	269
741	310	295
742	310	292
743	311	298
744	311	295
745	311	274
746	312	301
747	312	292
748	312	274
749	312	302
750	313	301
751	313	292
752	313	274
753	313	303
754	314	304
755	314	286
756	315	269
757	315	292
758	316	292
759	316	305
760	316	274
761	317	269
762	317	292
763	317	305
764	318	292
765	318	274
766	318	302
767	319	306
768	319	292
769	319	274
770	320	269
771	320	307
772	320	292
773	321	304
774	321	308
775	322	286
776	322	309
777	323	298
778	323	309
779	324	310
780	325	310
781	325	298
782	326	311
783	326	269
784	326	312
785	327	313
786	327	311
787	327	269
788	327	312
789	328	274
790	329	269
791	330	265
792	330	274
793	331	269
794	331	265
795	332	314
796	332	315
797	332	316
798	333	313
799	333	274
800	334	313
801	334	269
802	335	269
803	335	317
804	336	318
805	336	319
806	336	315
807	336	301
808	336	320
809	337	321
810	337	274
811	337	313
812	337	322
813	337	323
814	338	324
815	338	269
816	338	325
817	339	313
818	339	326
819	339	315
820	339	327
821	339	323
822	340	328
823	340	329
824	340	312
825	340	330
826	341	265
827	341	331
828	342	313
829	342	330
830	343	314
831	343	332
832	343	316
833	344	333
834	344	334
835	344	330
836	344	335
837	344	336
838	345	327
839	345	317
840	346	313
841	346	334
842	347	269
843	347	337
844	348	313
845	348	322
846	348	337
847	348	331
848	349	338
849	349	339
850	350	340
851	350	274
852	351	340
853	351	292
854	351	274
855	352	313
856	352	323
857	352	274
858	353	313
859	353	269
860	353	323
861	354	328
862	354	330
863	355	292
864	355	341
865	356	341
866	356	342
867	357	295
868	357	342
869	358	343
870	359	344
871	360	345
872	361	346
873	362	347
874	363	348
875	364	347
876	365	344
877	365	349
878	365	350
879	366	351
880	366	343
881	367	344
882	367	351
883	368	352
884	368	344
885	368	353
886	369	354
887	369	344
888	369	355
889	370	356
890	370	357
891	370	343
892	371	358
893	371	359
894	371	347
895	372	360
896	372	361
897	372	343
898	373	360
899	373	344
900	373	361
901	374	361
902	374	362
903	374	343
904	374	352
905	374	353
906	375	352
907	375	363
908	375	353
909	376	363
910	376	347
911	377	345
912	377	364
913	378	365
914	378	343
915	379	366
916	379	367
917	380	366
918	380	343
919	380	368
920	381	366
921	381	343
922	382	366
923	382	343
924	383	366
925	383	344
926	384	366
927	384	348
928	385	366
929	385	347
930	386	344
931	386	369
932	387	370
933	387	369
934	388	352
935	388	353
936	388	369
937	389	352
938	389	353
939	389	371
940	389	369
941	390	347
942	390	369
943	391	372
944	391	369
945	391	343
946	392	373
947	392	343
948	393	344
949	393	373
950	394	347
951	394	373
952	395	372
953	395	348
954	396	372
955	396	343
956	396	374
957	397	375
958	397	343
959	398	375
960	398	372
961	398	343
962	399	352
963	399	375
964	399	353
965	399	344
966	400	376
967	401	377
968	402	378
969	403	379
970	404	380
971	404	377
972	404	381
973	405	380
974	405	381
975	405	376
976	406	382
977	406	377
978	407	377
979	407	383
980	407	384
981	407	385
982	408	377
983	408	383
984	408	384
985	408	385
986	409	377
987	409	386
988	410	387
989	410	388
990	410	376
991	411	387
992	411	377
993	411	388
994	412	379
995	412	389
996	412	390
997	413	391
998	413	377
999	414	391
1000	414	376
1001	415	391
1002	415	378
1003	416	391
1004	416	379
1005	417	389
1006	417	390
1007	417	376
1008	418	377
1009	418	390
1010	418	389
1011	419	378
1012	419	390
1013	419	389
1014	420	392
1015	420	376
1016	421	392
1017	421	377
1018	422	393
1019	422	376
1020	423	377
1021	423	393
1022	424	394
1023	424	393
1024	425	393
1025	425	379
1026	426	395
1027	426	378
1028	427	395
1029	427	379
1030	428	395
1031	428	396
1032	429	391
1033	429	377
1034	429	392
1035	430	391
1036	430	392
1037	430	376
1038	431	391
1039	431	392
1040	431	378
1041	432	391
1042	432	392
1043	432	379
1044	433	397
1045	433	376
1046	434	397
1047	434	377
1048	435	397
1049	435	378
1050	436	397
1051	436	379
1052	437	392
1053	437	398
1054	437	376
1055	438	377
1056	438	392
1057	438	398
1058	439	399
1059	439	376
1060	440	399
1061	440	377
1062	441	399
1063	441	378
1064	442	399
1065	442	379
1066	443	399
1067	443	392
1068	443	376
1069	444	400
1070	444	392
1071	444	376
1072	445	377
1073	445	392
1074	445	400
1075	446	392
1076	446	378
1077	446	400
1078	447	392
1079	447	376
1080	447	401
1081	448	392
1082	448	379
1083	448	400
1084	449	376
1085	449	400
1086	450	377
1087	450	400
1088	451	378
1089	451	400
1090	452	392
1091	452	379
1092	452	400
1093	453	402
1094	453	376
1095	454	402
1096	454	377
1097	455	402
1098	455	379
1099	456	402
1100	456	396
1101	457	399
1102	457	402
1103	458	397
1104	458	402
1105	459	402
1106	459	379
1107	460	391
1108	460	402
1109	460	377
1110	461	391
1111	461	402
1112	461	376
1113	462	391
1114	462	402
1115	462	378
1116	463	391
1117	463	402
1118	463	379
1119	464	391
1120	464	402
1121	464	379
1122	465	384
1123	465	385
1124	465	377
1125	465	383
1126	465	403
1127	466	380
1128	466	381
1129	466	386
1130	467	380
1131	467	381
1132	468	380
1133	468	381
1134	468	385
1135	469	382
1136	469	380
1137	469	381
1138	469	403
1139	470	404
1140	470	390
1141	470	389
1142	471	405
1143	471	376
1144	471	406
1145	472	377
1146	472	405
1147	472	406
1148	473	378
1149	473	405
1150	473	406
1151	474	379
1152	474	405
1153	474	406
1154	475	407
1155	475	376
1156	475	408
1157	476	407
1158	476	377
1159	476	408
1160	477	407
1161	477	378
1162	477	408
1163	478	407
1164	478	379
1165	478	408
1166	479	409
1167	479	376
1168	480	409
1169	480	377
1170	481	409
1171	481	378
1172	482	409
1173	482	379
1174	483	397
1175	483	378
1176	483	399
1177	483	401
1178	484	377
1179	484	392
1180	484	398
1181	485	392
1182	485	378
1183	485	393
1184	486	410
1185	487	411
1186	487	410
1187	488	412
1188	488	411
1189	488	410
1190	489	413
1191	489	411
1192	489	410
1193	490	411
1194	490	414
1195	490	415
1196	491	416
1197	491	417
1198	491	418
1199	491	419
1200	491	410
1201	492	418
1202	492	410
1203	492	420
1204	493	421
1205	493	422
1206	493	410
1207	494	413
1208	494	422
1209	494	410
1210	494	421
1211	495	423
1212	495	410
1213	495	424
1214	495	425
1215	496	426
1216	496	427
1217	496	428
1218	496	429
1219	496	430
1220	496	431
1221	497	432
1222	497	433
1223	497	434
1224	498	411
1225	498	435
1226	499	413
1227	499	411
1228	499	435
1229	500	436
1230	501	435
1231	502	437
1232	503	438
1233	504	439
1234	505	437
1235	505	429
1236	506	440
1237	506	441
1238	507	412
1239	507	437
1240	507	442
1241	508	436
1242	508	443
1243	509	435
1244	509	443
1245	510	437
1246	510	443
1247	511	413
1248	511	418
1249	511	444
1250	512	445
1251	512	418
1252	512	446
1253	512	443
1254	512	447
1255	512	419
1256	512	448
1257	512	449
1258	513	450
1259	513	435
1260	513	451
1261	513	445
1262	514	418
1263	514	419
1264	514	439
1265	515	412
1266	515	435
1267	515	452
1268	515	442
1269	516	435
1270	516	453
1271	517	435
1272	517	452
1273	518	435
1274	518	454
1275	518	451
1276	519	418
1277	519	419
1278	519	436
1279	519	443
1280	520	418
1281	520	435
1282	520	419
1283	520	443
1284	521	418
1285	521	437
1286	521	419
1287	521	443
1288	522	418
1289	522	455
1290	522	419
1291	522	443
1292	523	418
1293	523	419
1294	523	436
1295	524	418
1296	524	435
1297	524	419
1298	525	418
1299	525	437
1300	525	419
1301	526	418
1302	526	419
1303	526	444
1304	527	444
1305	527	456
1306	528	418
1307	528	448
1308	528	419
1309	528	446
1310	529	418
1311	529	435
1312	530	435
1313	530	457
1314	531	458
1315	531	459
1316	531	436
1317	532	411
1318	532	458
1319	532	453
1320	532	459
1321	533	435
1322	533	460
1323	534	460
1324	534	436
1325	535	460
1326	535	415
1327	535	436
1328	536	460
1329	536	436
1330	536	412
1331	536	433
1332	536	461
1333	537	461
1334	537	460
1335	537	436
1336	538	413
1337	538	460
1338	538	436
1339	539	412
1340	539	462
1341	539	460
1342	539	438
1343	540	438
1344	540	460
1345	541	438
1346	541	460
1347	541	415
1348	542	411
1349	542	436
1350	543	411
1351	543	415
1352	543	436
1353	544	413
1354	544	411
1355	544	436
1356	545	411
1357	545	463
1358	546	464
1359	546	415
1360	547	411
1361	547	438
\.


--
-- Data for Name: store; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.store (id, tenant_id, name, location_city) FROM stdin;
1	1	功夫茶	台北市
2	1	大茗本位制茶堂	台北市
3	1	得正	台北市
4	1	先喝道	台北市
5	1	清新福全	台北市
6	1	迷克夏	台北市
7	1	Comebuy	台北市
8	1	龜記	台北市
9	1	五十嵐	台北市
10	1	Coco都可	台北市
\.


--
-- Data for Name: tenant; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tenant (id, name, is_registered) FROM stdin;
1	功夫茶	t
2	大茗本位制茶堂	t
3	得正	t
4	先喝道	t
5	清心福全	t
6	迷客夏	t
7	comebuy	t
8	龜記	t
9	五十嵐	t
10	coco都可	t
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, store_id, email, password_hash, created_at) FROM stdin;
\.


--
-- Data for Name: weather_cache; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.weather_cache (id, city_name, condition, temperature, recorded_at) FROM stdin;
\.


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

SELECT pg_catalog.setval('public.marketing_content_id_seq', 198, true);


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
-- Name: store_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.store_id_seq', 10, true);


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
-- Name: store store_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store
    ADD CONSTRAINT store_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenant(id);


--
-- Name: users users_store_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_store_id_fkey FOREIGN KEY (store_id) REFERENCES public.store(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

\unrestrict 7Dz5mrN8YSwcfe4fbd8ueQWCDFom2GpXjdulC4bemKDcnRIzeCPDRgtjVaYeQip

