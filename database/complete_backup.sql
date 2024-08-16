--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

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
-- Name: adress; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.adress (
    id integer NOT NULL,
    home_number character varying NOT NULL,
    street_id integer NOT NULL,
    locality_id integer NOT NULL
);


ALTER TABLE public.adress OWNER TO postgres;

--
-- Name: adress_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.adress_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.adress_id_seq OWNER TO postgres;

--
-- Name: adress_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.adress_id_seq OWNED BY public.adress.id;


--
-- Name: agreement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.agreement (
    id integer NOT NULL,
    date_of_start date NOT NULL,
    date_of_conclusion date NOT NULL,
    month_rent double precision NOT NULL,
    tenant_phys_id integer,
    tenant_leg_id integer,
    apartment_id integer NOT NULL,
    base_rate_id integer NOT NULL,
    company_id integer NOT NULL
);


ALTER TABLE public.agreement OWNER TO postgres;

--
-- Name: agreement_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.agreement_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.agreement_id_seq OWNER TO postgres;

--
-- Name: agreement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.agreement_id_seq OWNED BY public.agreement.id;


--
-- Name: apartment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.apartment (
    id integer NOT NULL,
    square double precision NOT NULL,
    basement_coefficient double precision NOT NULL,
    technical_imp_coeff double precision NOT NULL,
    adress_id integer NOT NULL,
    basement_square double precision NOT NULL
);


ALTER TABLE public.apartment OWNER TO postgres;

--
-- Name: apartment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.apartment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.apartment_id_seq OWNER TO postgres;

--
-- Name: apartment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.apartment_id_seq OWNED BY public.apartment.id;


--
-- Name: base_rate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.base_rate (
    id integer NOT NULL,
    date date NOT NULL,
    rate_for_one double precision NOT NULL
);


ALTER TABLE public.base_rate OWNER TO postgres;

--
-- Name: base_rate_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.base_rate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.base_rate_id_seq OWNER TO postgres;

--
-- Name: base_rate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.base_rate_id_seq OWNED BY public.base_rate.id;


--
-- Name: company; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.company (
    id integer NOT NULL,
    name character varying NOT NULL,
    short_name character varying NOT NULL,
    phone bigint NOT NULL,
    mail character varying NOT NULL,
    adress_id integer NOT NULL
);


ALTER TABLE public.company OWNER TO postgres;

--
-- Name: company_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.company_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.company_id_seq OWNER TO postgres;

--
-- Name: company_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.company_id_seq OWNED BY public.company.id;


--
-- Name: legal_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.legal_entity (
    id integer NOT NULL,
    name character varying NOT NULL,
    inn "char" NOT NULL,
    license_date date NOT NULL,
    adress_id integer NOT NULL
);


ALTER TABLE public.legal_entity OWNER TO postgres;

--
-- Name: legal_entity_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.legal_entity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.legal_entity_id_seq OWNER TO postgres;

--
-- Name: legal_entity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.legal_entity_id_seq OWNED BY public.legal_entity.id;


--
-- Name: locality; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.locality (
    id integer NOT NULL,
    name character varying NOT NULL,
    locality_type_id integer NOT NULL
);


ALTER TABLE public.locality OWNER TO postgres;

--
-- Name: locality_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.locality_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.locality_id_seq OWNER TO postgres;

--
-- Name: locality_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.locality_id_seq OWNED BY public.locality.id;


--
-- Name: locality_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.locality_type (
    id integer NOT NULL,
    name character varying NOT NULL,
    short_name character varying NOT NULL
);


ALTER TABLE public.locality_type OWNER TO postgres;

--
-- Name: locality_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.locality_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.locality_type_id_seq OWNER TO postgres;

--
-- Name: locality_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.locality_type_id_seq OWNED BY public.locality_type.id;


--
-- Name: physical_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.physical_entity (
    id integer NOT NULL,
    surname character varying NOT NULL,
    name character varying NOT NULL,
    middle_name character varying NOT NULL,
    inn "char" NOT NULL,
    passport_series "char" NOT NULL,
    passport_number "char" NOT NULL,
    passport_date date NOT NULL,
    passport_issued_by character varying NOT NULL,
    adress_id integer NOT NULL
);


ALTER TABLE public.physical_entity OWNER TO postgres;

--
-- Name: physical_entity_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.physical_entity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.physical_entity_id_seq OWNER TO postgres;

--
-- Name: physical_entity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.physical_entity_id_seq OWNED BY public.physical_entity.id;


--
-- Name: street; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.street (
    id integer NOT NULL,
    name character varying NOT NULL,
    street_type_id integer NOT NULL
);


ALTER TABLE public.street OWNER TO postgres;

--
-- Name: street_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.street_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.street_id_seq OWNER TO postgres;

--
-- Name: street_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.street_id_seq OWNED BY public.street.id;


--
-- Name: street_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.street_type (
    id integer NOT NULL,
    name character varying NOT NULL,
    short_name character varying NOT NULL
);


ALTER TABLE public.street_type OWNER TO postgres;

--
-- Name: street_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.street_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.street_type_id_seq OWNER TO postgres;

--
-- Name: street_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.street_type_id_seq OWNED BY public.street_type.id;


--
-- Name: adress id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adress ALTER COLUMN id SET DEFAULT nextval('public.adress_id_seq'::regclass);


--
-- Name: agreement id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agreement ALTER COLUMN id SET DEFAULT nextval('public.agreement_id_seq'::regclass);


--
-- Name: apartment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apartment ALTER COLUMN id SET DEFAULT nextval('public.apartment_id_seq'::regclass);


--
-- Name: base_rate id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.base_rate ALTER COLUMN id SET DEFAULT nextval('public.base_rate_id_seq'::regclass);


--
-- Name: company id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.company ALTER COLUMN id SET DEFAULT nextval('public.company_id_seq'::regclass);


--
-- Name: legal_entity id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.legal_entity ALTER COLUMN id SET DEFAULT nextval('public.legal_entity_id_seq'::regclass);


--
-- Name: locality id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locality ALTER COLUMN id SET DEFAULT nextval('public.locality_id_seq'::regclass);


--
-- Name: locality_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locality_type ALTER COLUMN id SET DEFAULT nextval('public.locality_type_id_seq'::regclass);


--
-- Name: physical_entity id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.physical_entity ALTER COLUMN id SET DEFAULT nextval('public.physical_entity_id_seq'::regclass);


--
-- Name: street id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.street ALTER COLUMN id SET DEFAULT nextval('public.street_id_seq'::regclass);


--
-- Name: street_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.street_type ALTER COLUMN id SET DEFAULT nextval('public.street_type_id_seq'::regclass);


--
-- Data for Name: adress; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.adress (id, home_number, street_id, locality_id) FROM stdin;
1	60\n	3	1
2	110\n	1	1
3	50	2	1
4	123	1	1
5	124	2	1
6	125	2	1
7	126	2	1
11	5	4	5
12	101	5	6
13	5	6	6
53	155	8	1
54	152	8	1
55	201	8	1
\.


--
-- Data for Name: agreement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.agreement (id, date_of_start, date_of_conclusion, month_rent, tenant_phys_id, tenant_leg_id, apartment_id, base_rate_id, company_id) FROM stdin;
1	2024-05-20	2025-05-19	20000	1	\N	4	1	1
2	2024-05-30	2024-05-29	25000	\N	1	5	1	1
\.


--
-- Data for Name: apartment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.apartment (id, square, basement_coefficient, technical_imp_coeff, adress_id, basement_square) FROM stdin;
4	40	0	0	11	0
5	100	1	0	12	10
53	42	0	0	53	0
54	42	0	0	54	0
55	42	0	0	55	0
\.


--
-- Data for Name: base_rate; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.base_rate (id, date, rate_for_one) FROM stdin;
1	2024-05-02	1000
\.


--
-- Data for Name: company; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.company (id, name, short_name, phone, mail, adress_id) FROM stdin;
1	Company Rent ltd.	Rent	88003456789	company@gmail.com	1
\.


--
-- Data for Name: legal_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.legal_entity (id, name, inn, license_date, adress_id) FROM stdin;
1	Yandex	1	1999-06-01	3
\.


--
-- Data for Name: locality; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.locality (id, name, locality_type_id) FROM stdin;
1	Оренбург	1
5	Санкт-Петербург	1
6	Москва	1
9	Владивосток	1
\.


--
-- Data for Name: locality_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.locality_type (id, name, short_name) FROM stdin;
1	Город	Г.
2	Поселок городского типа	ПГТ
3	Поселок	П.
4	Городской поселок	ГП.
5	Деревня	Д.
6	Село	С.
\.


--
-- Data for Name: physical_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.physical_entity (id, surname, name, middle_name, inn, passport_series, passport_number, passport_date, passport_issued_by, adress_id) FROM stdin;
1	Иванов	Иван	Иванович	1	1	1	2004-06-01	УМВД РФ ПО ОРЕНБУРГСКОЙ ОБЛ.	2
\.


--
-- Data for Name: street; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.street (id, name, street_type_id) FROM stdin;
1	Победы	2
2	Терешковой	1
3	Гагарина	2
4	Малая Бухаресткая	1
5	Садовая	1
6	Весенняя	1
7	Весенний	2
8	Победы	1
9	Семеновская	1
10	Невский	2
11	Литейный	2
12	Чкалова	1
13	Авиаторов	1
\.


--
-- Data for Name: street_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.street_type (id, name, short_name) FROM stdin;
1	Улица	ул.
2	Проспект	пр.
3	Переулок	пер.
4	Площадь	пл.
5	Бульвар	бул.
6	Проезд	проезд.
7	Набережная	наб.
8	Шоссе	ш.
\.


--
-- Name: adress_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.adress_id_seq', 55, true);


--
-- Name: agreement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.agreement_id_seq', 1, false);


--
-- Name: apartment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.apartment_id_seq', 55, true);


--
-- Name: base_rate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.base_rate_id_seq', 1, false);


--
-- Name: company_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.company_id_seq', 1, true);


--
-- Name: legal_entity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.legal_entity_id_seq', 1, false);


--
-- Name: locality_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.locality_id_seq', 9, true);


--
-- Name: locality_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.locality_type_id_seq', 1, false);


--
-- Name: physical_entity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.physical_entity_id_seq', 1, false);


--
-- Name: street_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.street_id_seq', 14, true);


--
-- Name: street_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.street_type_id_seq', 1, false);


--
-- Name: adress adress_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adress
    ADD CONSTRAINT adress_pkey PRIMARY KEY (id);


--
-- Name: agreement agreement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agreement
    ADD CONSTRAINT agreement_pkey PRIMARY KEY (id);


--
-- Name: apartment apartment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apartment
    ADD CONSTRAINT apartment_pkey PRIMARY KEY (id);


--
-- Name: base_rate base_rate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.base_rate
    ADD CONSTRAINT base_rate_pkey PRIMARY KEY (id);


--
-- Name: company company_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.company
    ADD CONSTRAINT company_pkey PRIMARY KEY (id);


--
-- Name: legal_entity legal_entity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.legal_entity
    ADD CONSTRAINT legal_entity_pkey PRIMARY KEY (id);


--
-- Name: locality locality_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locality
    ADD CONSTRAINT locality_pkey PRIMARY KEY (id);


--
-- Name: locality_type locality_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locality_type
    ADD CONSTRAINT locality_type_pkey PRIMARY KEY (id);


--
-- Name: physical_entity physical_entity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.physical_entity
    ADD CONSTRAINT physical_entity_pkey PRIMARY KEY (id);


--
-- Name: street street_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.street
    ADD CONSTRAINT street_pkey PRIMARY KEY (id);


--
-- Name: street_type street_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.street_type
    ADD CONSTRAINT street_type_pkey PRIMARY KEY (id);


--
-- Name: adress adress_locality_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adress
    ADD CONSTRAINT adress_locality_id_fkey FOREIGN KEY (locality_id) REFERENCES public.locality(id);


--
-- Name: adress adress_street_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adress
    ADD CONSTRAINT adress_street_id_fkey FOREIGN KEY (street_id) REFERENCES public.street(id);


--
-- Name: agreement agreement_apartment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agreement
    ADD CONSTRAINT agreement_apartment_id_fkey FOREIGN KEY (apartment_id) REFERENCES public.apartment(id) NOT VALID;


--
-- Name: agreement agreement_base_rate_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agreement
    ADD CONSTRAINT agreement_base_rate_id_fkey FOREIGN KEY (base_rate_id) REFERENCES public.base_rate(id) NOT VALID;


--
-- Name: agreement agreement_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agreement
    ADD CONSTRAINT agreement_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.company(id) NOT VALID;


--
-- Name: agreement agreement_tenant_leg_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agreement
    ADD CONSTRAINT agreement_tenant_leg_id_fkey FOREIGN KEY (tenant_leg_id) REFERENCES public.legal_entity(id) NOT VALID;


--
-- Name: agreement agreement_tenant_phys_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agreement
    ADD CONSTRAINT agreement_tenant_phys_id_fkey FOREIGN KEY (tenant_phys_id) REFERENCES public.physical_entity(id) NOT VALID;


--
-- Name: company company_adress_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.company
    ADD CONSTRAINT company_adress_id_fkey FOREIGN KEY (adress_id) REFERENCES public.adress(id) NOT VALID;


--
-- Name: locality locality_locality_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locality
    ADD CONSTRAINT locality_locality_type_id_fkey FOREIGN KEY (locality_type_id) REFERENCES public.locality_type(id) NOT VALID;


--
-- Name: street street_street_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.street
    ADD CONSTRAINT street_street_type_id_fkey FOREIGN KEY (street_type_id) REFERENCES public.street_type(id) NOT VALID;


--
-- PostgreSQL database dump complete
--

