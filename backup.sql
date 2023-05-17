--
-- PostgreSQL database dump
--

-- Dumped from database version 14.7 (Homebrew)
-- Dumped by pg_dump version 14.7 (Homebrew)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: active_storage_attachments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.active_storage_attachments (
    id bigint NOT NULL,
    name character varying NOT NULL,
    record_type character varying NOT NULL,
    record_id bigint NOT NULL,
    blob_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.active_storage_attachments OWNER TO postgres;

--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.active_storage_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.active_storage_attachments_id_seq OWNER TO postgres;

--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.active_storage_attachments_id_seq OWNED BY public.active_storage_attachments.id;


--
-- Name: active_storage_blobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.active_storage_blobs (
    id bigint NOT NULL,
    key character varying NOT NULL,
    filename character varying NOT NULL,
    content_type character varying,
    metadata text,
    service_name character varying NOT NULL,
    byte_size bigint NOT NULL,
    checksum character varying NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.active_storage_blobs OWNER TO postgres;

--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.active_storage_blobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.active_storage_blobs_id_seq OWNER TO postgres;

--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.active_storage_blobs_id_seq OWNED BY public.active_storage_blobs.id;


--
-- Name: active_storage_variant_records; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.active_storage_variant_records (
    id bigint NOT NULL,
    blob_id bigint NOT NULL,
    variation_digest character varying NOT NULL
);


ALTER TABLE public.active_storage_variant_records OWNER TO postgres;

--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.active_storage_variant_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.active_storage_variant_records_id_seq OWNER TO postgres;

--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.active_storage_variant_records_id_seq OWNED BY public.active_storage_variant_records.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO postgres;

--
-- Name: companies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.companies (
    id bigint NOT NULL,
    name character varying,
    cui character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    status integer DEFAULT 0
);


ALTER TABLE public.companies OWNER TO postgres;

--
-- Name: companies_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.companies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.companies_id_seq OWNER TO postgres;

--
-- Name: companies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.companies_id_seq OWNED BY public.companies.id;


--
-- Name: company_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.company_users (
    id bigint NOT NULL,
    company_id bigint NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    status integer DEFAULT 0,
    meta_data json
);


ALTER TABLE public.company_users OWNER TO postgres;

--
-- Name: company_users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.company_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.company_users_id_seq OWNER TO postgres;

--
-- Name: company_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.company_users_id_seq OWNED BY public.company_users.id;


--
-- Name: documents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.documents (
    id bigint NOT NULL,
    company_id bigint NOT NULL,
    author_id integer,
    title character varying,
    category integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    file character varying,
    status integer DEFAULT 0,
    description character varying,
    issue_date date
);


ALTER TABLE public.documents OWNER TO postgres;

--
-- Name: documents_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.documents_id_seq OWNER TO postgres;

--
-- Name: documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.documents_id_seq OWNED BY public.documents.id;


--
-- Name: jwt_denylist; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jwt_denylist (
    id bigint NOT NULL,
    jti character varying NOT NULL,
    exp timestamp without time zone NOT NULL
);


ALTER TABLE public.jwt_denylist OWNER TO postgres;

--
-- Name: jwt_denylist_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jwt_denylist_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.jwt_denylist_id_seq OWNER TO postgres;

--
-- Name: jwt_denylist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jwt_denylist_id_seq OWNED BY public.jwt_denylist.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    name character varying,
    role integer,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
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
-- Name: active_storage_attachments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_attachments ALTER COLUMN id SET DEFAULT nextval('public.active_storage_attachments_id_seq'::regclass);


--
-- Name: active_storage_blobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_blobs ALTER COLUMN id SET DEFAULT nextval('public.active_storage_blobs_id_seq'::regclass);


--
-- Name: active_storage_variant_records id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_variant_records ALTER COLUMN id SET DEFAULT nextval('public.active_storage_variant_records_id_seq'::regclass);


--
-- Name: companies id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies ALTER COLUMN id SET DEFAULT nextval('public.companies_id_seq'::regclass);


--
-- Name: company_users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.company_users ALTER COLUMN id SET DEFAULT nextval('public.company_users_id_seq'::regclass);


--
-- Name: documents id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents ALTER COLUMN id SET DEFAULT nextval('public.documents_id_seq'::regclass);


--
-- Name: jwt_denylist id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jwt_denylist ALTER COLUMN id SET DEFAULT nextval('public.jwt_denylist_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: active_storage_attachments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.active_storage_attachments (id, name, record_type, record_id, blob_id, created_at) FROM stdin;
\.


--
-- Data for Name: active_storage_blobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.active_storage_blobs (id, key, filename, content_type, metadata, service_name, byte_size, checksum, created_at) FROM stdin;
\.


--
-- Data for Name: active_storage_variant_records; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.active_storage_variant_records (id, blob_id, variation_digest) FROM stdin;
\.


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2023-03-04 22:05:28.346656	2023-03-04 22:05:28.346656
\.


--
-- Data for Name: companies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.companies (id, name, cui, created_at, updated_at, status) FROM stdin;
23	firma_mea_acum	4545	2023-04-01 14:49:20.286122	2023-04-01 15:26:19.043718	1
3	firma2	2	2023-03-26 11:58:39.955634	2023-04-01 15:48:52.770725	1
6	firma_mea	123456	2023-03-26 14:25:40.899348	2023-04-01 15:49:03.955036	1
22	firma234	645	2023-03-26 19:16:43.800785	2023-04-01 15:51:05.833007	1
21	firma546	675	2023-03-26 19:14:48.083395	2023-04-01 15:51:08.333248	1
20	firma45	654456	2023-03-26 19:12:47.10936	2023-04-01 15:51:10.985976	1
19	firm4589	6767	2023-03-26 19:11:23.759358	2023-04-01 15:51:11.815527	1
18	firma3435	098	2023-03-26 19:09:32.248873	2023-04-01 15:51:12.126248	1
17	firma2345	0909	2023-03-26 19:06:47.227583	2023-04-01 15:51:12.427458	1
16	fiuhutvtgghihh	86t667880	2023-03-26 19:00:36.023726	2023-04-01 15:51:12.571184	1
15	fiuhutvtgghih	86t66788	2023-03-26 19:00:30.881955	2023-04-01 15:51:12.770911	1
14	fiuhutvtggh	86t6678	2023-03-26 19:00:23.943962	2023-04-01 15:51:13.048538	1
13	fiuhutvtgg	86t667	2023-03-26 19:00:17.934802	2023-04-01 15:51:13.29973	1
1	\N	\N	2023-03-19 17:41:37.576762	2023-04-01 15:51:43.815812	1
12	fiuhutvtg	86t66	2023-03-26 19:00:11.671099	2023-04-01 15:51:45.969258	1
10	fiuhutv	86t	2023-03-26 18:58:49.875227	2023-04-01 17:24:45.228307	1
11	fiuhutvt	86t6	2023-03-26 19:00:00.060016	2023-04-01 18:23:10.918945	1
9	firma 222	67	2023-03-26 17:42:55.811554	2023-04-01 18:36:37.152341	2
8	firma mea 1111	1234563	2023-03-26 14:31:00.337539	2023-04-01 18:40:24.629913	2
7	firma mea 11	12345678	2023-03-26 14:27:32.752243	2023-04-01 18:40:25.895295	1
24	firmea_noua	333	2023-04-01 18:43:34.929014	2023-04-01 18:43:50.914063	1
25	firma444	44444	2023-04-01 18:44:26.434973	2023-04-01 18:44:42.714018	1
2	firma1	12345	2023-03-25 22:15:26.904842	2023-04-01 21:59:25.736195	2
4	firma3	3	2023-03-26 11:58:51.173323	2023-04-01 22:00:18.528257	2
5	firma10230123	1234	2023-03-26 12:11:54.563383	2023-04-01 22:02:32.082501	2
26	firma_mea 3444	656565	2023-04-01 22:09:10.955847	2023-04-01 22:09:25.76743	2
27	firmea_test_1	12	2023-04-01 22:10:29.103483	2023-04-01 22:10:29.103483	0
28	firma mea misto 	345000	2023-04-03 21:35:21.319595	2023-04-03 21:35:21.319595	0
29	firma Lavinia 	0502	2023-04-04 19:10:00.929537	2023-04-04 19:12:16.664518	1
30	test	777	2023-04-04 19:30:58.146329	2023-04-04 19:40:17.0356	1
\.


--
-- Data for Name: company_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.company_users (id, company_id, user_id, created_at, updated_at, status, meta_data) FROM stdin;
1	2	24	2023-03-25 22:15:26.932269	2023-03-25 22:15:26.932269	1	\N
2	3	24	2023-03-26 11:58:39.968051	2023-03-26 11:58:39.968051	1	\N
3	4	24	2023-03-26 11:58:51.189397	2023-03-26 11:58:51.189397	1	\N
4	5	24	2023-03-26 12:11:54.568981	2023-03-26 12:11:54.568981	1	\N
5	6	24	2023-03-26 14:25:40.905535	2023-03-26 14:25:40.905535	1	\N
6	7	24	2023-03-26 14:27:32.78649	2023-03-26 14:27:32.78649	1	\N
7	8	24	2023-03-26 14:31:00.376367	2023-03-26 14:31:00.376367	1	\N
8	9	24	2023-03-26 17:42:55.821374	2023-03-26 17:42:55.821374	1	\N
9	10	24	2023-03-26 18:58:49.886266	2023-03-26 18:58:49.886266	1	\N
10	11	24	2023-03-26 19:00:00.093779	2023-03-26 19:00:00.093779	1	\N
11	12	24	2023-03-26 19:00:11.67671	2023-03-26 19:00:11.67671	1	\N
12	13	24	2023-03-26 19:00:17.939171	2023-03-26 19:00:17.939171	1	\N
13	14	24	2023-03-26 19:00:23.950293	2023-03-26 19:00:23.950293	1	\N
14	15	24	2023-03-26 19:00:30.885556	2023-03-26 19:00:30.885556	1	\N
15	16	24	2023-03-26 19:00:36.029266	2023-03-26 19:00:36.029266	1	\N
16	17	24	2023-03-26 19:06:47.232955	2023-03-26 19:06:47.232955	1	\N
17	18	24	2023-03-26 19:09:32.27095	2023-03-26 19:09:32.27095	1	\N
18	19	24	2023-03-26 19:11:23.763512	2023-03-26 19:11:23.763512	1	\N
19	20	24	2023-03-26 19:12:47.115483	2023-03-26 19:12:47.115483	1	\N
20	21	24	2023-03-26 19:14:48.109417	2023-03-26 19:14:48.109417	1	\N
21	22	24	2023-03-26 19:16:43.806307	2023-03-26 19:16:43.806307	1	\N
22	23	24	2023-04-01 14:49:20.347967	2023-04-01 14:49:20.347967	1	\N
23	24	24	2023-04-01 18:43:34.93536	2023-04-01 18:43:34.93536	1	\N
24	25	24	2023-04-01 18:44:26.43912	2023-04-01 18:44:26.43912	1	\N
25	26	24	2023-04-01 22:09:10.96617	2023-04-01 22:09:25.808647	2	\N
26	27	24	2023-04-01 22:10:29.156548	2023-04-01 22:10:29.156548	1	\N
27	1	28	2023-04-02 13:46:39.320146	2023-04-02 13:46:39.320146	0	\N
28	3	28	2023-04-02 14:24:36.846165	2023-04-02 14:24:36.846165	0	\N
29	23	28	2023-04-02 14:26:34.65037	2023-04-02 14:26:34.65037	0	\N
30	8	28	2023-04-03 21:06:34.535276	2023-04-03 21:06:34.535276	0	\N
31	28	24	2023-04-03 21:35:21.336742	2023-04-03 21:35:21.336742	1	\N
32	28	28	2023-04-03 21:35:31.923673	2023-04-03 21:35:31.923673	0	\N
33	29	24	2023-04-04 19:10:00.941344	2023-04-04 19:10:00.941344	1	\N
34	29	28	2023-04-04 19:13:40.731878	2023-04-04 19:13:40.731878	0	\N
35	30	24	2023-04-04 19:30:58.20218	2023-04-04 19:30:58.20218	1	\N
36	30	28	2023-04-04 19:36:56.121901	2023-04-04 19:59:48.024797	1	\N
\.


--
-- Data for Name: documents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.documents (id, company_id, author_id, title, category, created_at, updated_at, file, status, description, issue_date) FROM stdin;
\.


--
-- Data for Name: jwt_denylist; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jwt_denylist (id, jti, exp) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schema_migrations (version) FROM stdin;
20220522002040
20220527023513
20220527023611
20220527025250
20220531123319
20220531123329
20220531123434
20220601125859
20220603181836
20220605112539
20220605112843
20220605113453
20220605113743
20220605195002
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, encrypted_password, name, role, reset_password_token, reset_password_sent_at, remember_created_at, created_at, updated_at) FROM stdin;
24	lav5555@gmail.com	$2a$12$KBfg5ok/C02eKnN3Yb0gF.y5jLDs5uCdREdQmuzcrH.siT2nffllu	lavinia_euu	3	\N	\N	\N	2023-03-19 17:20:48.837062	2023-03-19 17:20:48.837062
25	lav4444@gmail.com	$2a$12$xCpyTA/mDXR5kLFyQJBfm.49XWGJpbBW7XGblxZfeAnzzsM.ZBdMi	lavinia_euu	3	\N	\N	\N	2023-03-23 19:56:33.721233	2023-03-23 19:56:33.721233
26	admin@localhost	$2a$12$OcLHSTQXLSa4IppN/h/ogO2IHGcceMmQJzGRFDlu8kG.scAZU8GgK	Admin	0	\N	\N	\N	2023-04-01 14:31:32.680459	2023-04-01 14:31:32.680459
27	lav_contabil_sef@gmail.com	$2a$12$wb3W8xwa6aiC2PcrMerPJOSbBbI4OZ5KXNfSp2zVsv6SPOaEAFsEm	lavinia_contabil_sef	1	\N	\N	\N	2023-04-01 14:31:47.016289	2023-04-01 14:31:47.016289
28	lavinia_angajat@gmail.com	$2a$12$c5xStGzXGnJfRKLoS/SdhOCZkfUwwpJuAF.O0CyI5D6zn6OvKnqyC	lavinia_angajat	4	\N	\N	\N	2023-04-02 13:17:26.032259	2023-04-02 13:17:26.032259
\.


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.active_storage_attachments_id_seq', 1, false);


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.active_storage_blobs_id_seq', 1, false);


--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.active_storage_variant_records_id_seq', 1, false);


--
-- Name: companies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.companies_id_seq', 30, true);


--
-- Name: company_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.company_users_id_seq', 36, true);


--
-- Name: documents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.documents_id_seq', 1, false);


--
-- Name: jwt_denylist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jwt_denylist_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 28, true);


--
-- Name: active_storage_attachments active_storage_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT active_storage_attachments_pkey PRIMARY KEY (id);


--
-- Name: active_storage_blobs active_storage_blobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_blobs
    ADD CONSTRAINT active_storage_blobs_pkey PRIMARY KEY (id);


--
-- Name: active_storage_variant_records active_storage_variant_records_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT active_storage_variant_records_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: companies companies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);


--
-- Name: company_users company_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.company_users
    ADD CONSTRAINT company_users_pkey PRIMARY KEY (id);


--
-- Name: documents documents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);


--
-- Name: jwt_denylist jwt_denylist_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jwt_denylist
    ADD CONSTRAINT jwt_denylist_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_active_storage_attachments_on_blob_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_active_storage_attachments_on_blob_id ON public.active_storage_attachments USING btree (blob_id);


--
-- Name: index_active_storage_attachments_uniqueness; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_active_storage_attachments_uniqueness ON public.active_storage_attachments USING btree (record_type, record_id, name, blob_id);


--
-- Name: index_active_storage_blobs_on_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_active_storage_blobs_on_key ON public.active_storage_blobs USING btree (key);


--
-- Name: index_active_storage_variant_records_uniqueness; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_active_storage_variant_records_uniqueness ON public.active_storage_variant_records USING btree (blob_id, variation_digest);


--
-- Name: index_company_users_on_company_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_company_users_on_company_id ON public.company_users USING btree (company_id);


--
-- Name: index_company_users_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_company_users_on_user_id ON public.company_users USING btree (user_id);


--
-- Name: index_documents_on_company_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_documents_on_company_id ON public.documents USING btree (company_id);


--
-- Name: index_jwt_denylist_on_jti; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_jwt_denylist_on_jti ON public.jwt_denylist USING btree (jti);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: company_users fk_rails_6e70dad67e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.company_users
    ADD CONSTRAINT fk_rails_6e70dad67e FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: documents fk_rails_83141d4c8c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT fk_rails_83141d4c8c FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: company_users fk_rails_946619ff40; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.company_users
    ADD CONSTRAINT fk_rails_946619ff40 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: active_storage_variant_records fk_rails_993965df05; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT fk_rails_993965df05 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: active_storage_attachments fk_rails_c3b3935057; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT fk_rails_c3b3935057 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- PostgreSQL database dump complete
--

