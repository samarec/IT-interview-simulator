--
-- PostgreSQL database dump
--

\restrict ouUDVrcFjXTy5XGOhKbaXvRyL6IsA84uNkHXSiBxdlcJORLpN87zCWfbBuDzFkv

-- Dumped from database version 16.8
-- Dumped by pg_dump version 18.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: z1; Type: SCHEMA; Schema: -; Owner: z1
--

CREATE SCHEMA z1;


ALTER SCHEMA z1 OWNER TO z1;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: answers; Type: TABLE; Schema: z1; Owner: z1
--

CREATE TABLE z1.answers (
    id integer NOT NULL,
    card_id integer NOT NULL,
    title character varying NOT NULL,
    is_correct boolean NOT NULL
);


ALTER TABLE z1.answers OWNER TO z1;

--
-- Name: answers_id_seq; Type: SEQUENCE; Schema: z1; Owner: z1
--

CREATE SEQUENCE z1.answers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE z1.answers_id_seq OWNER TO z1;

--
-- Name: answers_id_seq; Type: SEQUENCE OWNED BY; Schema: z1; Owner: z1
--

ALTER SEQUENCE z1.answers_id_seq OWNED BY z1.answers.id;


--
-- Name: card_types; Type: TABLE; Schema: z1; Owner: z1
--

CREATE TABLE z1.card_types (
    id bigint NOT NULL,
    name text NOT NULL
);


ALTER TABLE z1.card_types OWNER TO z1;

--
-- Name: card_types_id_seq; Type: SEQUENCE; Schema: z1; Owner: z1
--

ALTER TABLE z1.card_types ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME z1.card_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: cards; Type: TABLE; Schema: z1; Owner: z1
--

CREATE TABLE z1.cards (
    id integer NOT NULL,
    topic_id integer NOT NULL,
    title character varying NOT NULL,
    description text,
    card_type_id bigint
);


ALTER TABLE z1.cards OWNER TO z1;

--
-- Name: cards_id_seq; Type: SEQUENCE; Schema: z1; Owner: z1
--

CREATE SEQUENCE z1.cards_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE z1.cards_id_seq OWNER TO z1;

--
-- Name: cards_id_seq; Type: SEQUENCE OWNED BY; Schema: z1; Owner: z1
--

ALTER SEQUENCE z1.cards_id_seq OWNED BY z1.cards.id;


--
-- Name: difficulties; Type: TABLE; Schema: z1; Owner: z1
--

CREATE TABLE z1.difficulties (
    id bigint NOT NULL,
    name text NOT NULL
);


ALTER TABLE z1.difficulties OWNER TO z1;

--
-- Name: difficulties_id_seq; Type: SEQUENCE; Schema: z1; Owner: z1
--

ALTER TABLE z1.difficulties ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME z1.difficulties_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: faq; Type: TABLE; Schema: z1; Owner: z1
--

CREATE TABLE z1.faq (
    id integer NOT NULL,
    title character varying NOT NULL,
    description text NOT NULL
);


ALTER TABLE z1.faq OWNER TO z1;

--
-- Name: faq_id_seq; Type: SEQUENCE; Schema: z1; Owner: z1
--

CREATE SEQUENCE z1.faq_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE z1.faq_id_seq OWNER TO z1;

--
-- Name: faq_id_seq; Type: SEQUENCE OWNED BY; Schema: z1; Owner: z1
--

ALTER SEQUENCE z1.faq_id_seq OWNED BY z1.faq.id;


--
-- Name: profession_tags; Type: TABLE; Schema: z1; Owner: z1
--

CREATE TABLE z1.profession_tags (
    profession_id integer NOT NULL,
    tag_id integer NOT NULL,
    weight integer DEFAULT 1
);


ALTER TABLE z1.profession_tags OWNER TO z1;

--
-- Name: professions; Type: TABLE; Schema: z1; Owner: z1
--

CREATE TABLE z1.professions (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE z1.professions OWNER TO z1;

--
-- Name: professions_id_seq; Type: SEQUENCE; Schema: z1; Owner: z1
--

CREATE SEQUENCE z1.professions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE z1.professions_id_seq OWNER TO z1;

--
-- Name: professions_id_seq; Type: SEQUENCE OWNED BY; Schema: z1; Owner: z1
--

ALTER SEQUENCE z1.professions_id_seq OWNED BY z1.professions.id;


--
-- Name: roles; Type: TABLE; Schema: z1; Owner: z1
--

CREATE TABLE z1.roles (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text
);


ALTER TABLE z1.roles OWNER TO z1;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: z1; Owner: z1
--

CREATE SEQUENCE z1.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE z1.roles_id_seq OWNER TO z1;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: z1; Owner: z1
--

ALTER SEQUENCE z1.roles_id_seq OWNED BY z1.roles.id;


--
-- Name: tags; Type: TABLE; Schema: z1; Owner: z1
--

CREATE TABLE z1.tags (
    id integer NOT NULL,
    name character varying NOT NULL,
    is_active boolean DEFAULT true
);


ALTER TABLE z1.tags OWNER TO z1;

--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: z1; Owner: z1
--

CREATE SEQUENCE z1.tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE z1.tags_id_seq OWNER TO z1;

--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: z1; Owner: z1
--

ALTER SEQUENCE z1.tags_id_seq OWNED BY z1.tags.id;


--
-- Name: test_cards; Type: TABLE; Schema: z1; Owner: z1
--

CREATE TABLE z1.test_cards (
    test_id integer NOT NULL,
    card_id integer NOT NULL,
    order_index integer DEFAULT 0
);


ALTER TABLE z1.test_cards OWNER TO z1;

--
-- Name: tests; Type: TABLE; Schema: z1; Owner: z1
--

CREATE TABLE z1.tests (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    duration_minutes integer DEFAULT 5,
    profession_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    code character varying(100),
    difficulty_id bigint
);


ALTER TABLE z1.tests OWNER TO z1;

--
-- Name: tests_id_seq; Type: SEQUENCE; Schema: z1; Owner: z1
--

CREATE SEQUENCE z1.tests_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE z1.tests_id_seq OWNER TO z1;

--
-- Name: tests_id_seq; Type: SEQUENCE OWNED BY; Schema: z1; Owner: z1
--

ALTER SEQUENCE z1.tests_id_seq OWNED BY z1.tests.id;


--
-- Name: topic_professions; Type: TABLE; Schema: z1; Owner: z1
--

CREATE TABLE z1.topic_professions (
    topic_id integer NOT NULL,
    profession_id integer NOT NULL
);


ALTER TABLE z1.topic_professions OWNER TO z1;

--
-- Name: topic_tags; Type: TABLE; Schema: z1; Owner: z1
--

CREATE TABLE z1.topic_tags (
    topic_id integer NOT NULL,
    tag_id integer NOT NULL
);


ALTER TABLE z1.topic_tags OWNER TO z1;

--
-- Name: topics; Type: TABLE; Schema: z1; Owner: z1
--

CREATE TABLE z1.topics (
    id integer NOT NULL,
    name character varying NOT NULL,
    code character varying(100)
);


ALTER TABLE z1.topics OWNER TO z1;

--
-- Name: topics_id_seq; Type: SEQUENCE; Schema: z1; Owner: z1
--

CREATE SEQUENCE z1.topics_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE z1.topics_id_seq OWNER TO z1;

--
-- Name: topics_id_seq; Type: SEQUENCE OWNED BY; Schema: z1; Owner: z1
--

ALTER SEQUENCE z1.topics_id_seq OWNED BY z1.topics.id;


--
-- Name: user_test_results; Type: TABLE; Schema: z1; Owner: z1
--

CREATE TABLE z1.user_test_results (
    id integer NOT NULL,
    user_id integer,
    test_id integer NOT NULL,
    score integer,
    max_score integer,
    passed boolean DEFAULT false,
    completed_at timestamp with time zone DEFAULT now(),
    mode character varying(20)
);


ALTER TABLE z1.user_test_results OWNER TO z1;

--
-- Name: user_test_results_id_seq; Type: SEQUENCE; Schema: z1; Owner: z1
--

CREATE SEQUENCE z1.user_test_results_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE z1.user_test_results_id_seq OWNER TO z1;

--
-- Name: user_test_results_id_seq; Type: SEQUENCE OWNED BY; Schema: z1; Owner: z1
--

ALTER SEQUENCE z1.user_test_results_id_seq OWNED BY z1.user_test_results.id;


--
-- Name: user_topic_counters; Type: TABLE; Schema: z1; Owner: z1
--

CREATE TABLE z1.user_topic_counters (
    id integer NOT NULL,
    user_id integer NOT NULL,
    topic_id integer NOT NULL,
    completed_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE z1.user_topic_counters OWNER TO z1;

--
-- Name: user_topic_counters_id_seq; Type: SEQUENCE; Schema: z1; Owner: z1
--

CREATE SEQUENCE z1.user_topic_counters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE z1.user_topic_counters_id_seq OWNER TO z1;

--
-- Name: user_topic_counters_id_seq; Type: SEQUENCE OWNED BY; Schema: z1; Owner: z1
--

ALTER SEQUENCE z1.user_topic_counters_id_seq OWNED BY z1.user_topic_counters.id;


--
-- Name: users; Type: TABLE; Schema: z1; Owner: z1
--

CREATE TABLE z1.users (
    id integer NOT NULL,
    username character varying(100) NOT NULL,
    email character varying(255) NOT NULL,
    password_hash character varying(255) NOT NULL,
    role_id integer,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE z1.users OWNER TO z1;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: z1; Owner: z1
--

CREATE SEQUENCE z1.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE z1.users_id_seq OWNER TO z1;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: z1; Owner: z1
--

ALTER SEQUENCE z1.users_id_seq OWNED BY z1.users.id;


--
-- Name: answers id; Type: DEFAULT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.answers ALTER COLUMN id SET DEFAULT nextval('z1.answers_id_seq'::regclass);


--
-- Name: cards id; Type: DEFAULT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.cards ALTER COLUMN id SET DEFAULT nextval('z1.cards_id_seq'::regclass);


--
-- Name: faq id; Type: DEFAULT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.faq ALTER COLUMN id SET DEFAULT nextval('z1.faq_id_seq'::regclass);


--
-- Name: professions id; Type: DEFAULT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.professions ALTER COLUMN id SET DEFAULT nextval('z1.professions_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.roles ALTER COLUMN id SET DEFAULT nextval('z1.roles_id_seq'::regclass);


--
-- Name: tags id; Type: DEFAULT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.tags ALTER COLUMN id SET DEFAULT nextval('z1.tags_id_seq'::regclass);


--
-- Name: tests id; Type: DEFAULT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.tests ALTER COLUMN id SET DEFAULT nextval('z1.tests_id_seq'::regclass);


--
-- Name: topics id; Type: DEFAULT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.topics ALTER COLUMN id SET DEFAULT nextval('z1.topics_id_seq'::regclass);


--
-- Name: user_test_results id; Type: DEFAULT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.user_test_results ALTER COLUMN id SET DEFAULT nextval('z1.user_test_results_id_seq'::regclass);


--
-- Name: user_topic_counters id; Type: DEFAULT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.user_topic_counters ALTER COLUMN id SET DEFAULT nextval('z1.user_topic_counters_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.users ALTER COLUMN id SET DEFAULT nextval('z1.users_id_seq'::regclass);


--
-- Data for Name: answers; Type: TABLE DATA; Schema: z1; Owner: z1
--

COPY z1.answers (id, card_id, title, is_correct) FROM stdin;
1	1	Да	f
2	1	Нет	t
3	2	Да	t
4	2	Нет	f
5	3	Да	t
6	3	Нет	f
7	4	Да	t
8	4	Нет	f
9	5	Да	f
10	5	Нет	t
11	6	Да	f
12	6	Нет	t
13	7	Да	f
14	7	Нет	t
15	8	Да	t
16	8	Нет	f
17	9	Да	f
18	9	Нет	t
19	10	Да	f
20	10	Нет	t
21	11	Да	f
22	11	Нет	t
23	12	Да	f
24	12	Нет	t
25	13	Да	f
26	13	Нет	t
27	14	Да	t
28	14	Нет	f
29	15	Да	f
30	15	Нет	t
31	16	Да	f
32	16	Нет	t
33	17	Да	t
34	17	Нет	f
35	18	Да	f
36	18	Нет	t
37	19	Да	t
38	19	Нет	f
39	20	Да	t
40	20	Нет	f
41	21	Да	f
42	21	Нет	t
43	22	Да	f
44	22	Нет	t
45	23	Да	t
46	23	Нет	f
47	24	Да	t
48	24	Нет	f
49	25	Да	t
50	25	Нет	f
51	26	Язык разметки для создания веб-страниц	t
52	26	Язык программирования	f
53	26	Язык стилей	f
54	26	База данных	f
55	27	Cascading Style Sheets	t
56	27	Computer Style System	f
57	27	Creative Style Sheets	f
58	27	Coded Style Sheets	f
59	28	Document Object Model - объектная модель документа	t
60	28	Document Oriented Model	f
61	28	Data Object Model	f
62	28	Digital Object Model	f
63	29	<html>	t
64	29	<head>	f
65	29	<body>	f
66	29	<document>	f
67	30	html, head, body	t
68	30	html, header, footer	f
69	30	head, body, footer	f
70	30	html, body, main	f
71	31	Создание абзаца текста	t
72	31	Создание списка	f
73	31	Создание заголовка	f
74	31	Создание таблицы	f
75	32	Перенос строки	t
76	32	Создание параграфа	f
77	32	Горизонтальная линия	f
78	32	Жирный текст	f
79	33	Горизонтальный разделитель	t
80	33	Перенос строки	f
81	33	Создание списка	f
82	33	Создание заголовка	f
83	34	Маркированный список	t
84	34	Нумерованный список	f
85	34	Таблица	f
86	34	Абзац	f
87	35	Нумерованный список	t
88	35	Маркированный список	f
89	35	Таблица	f
90	35	Абзац	f
91	36	Пункт списка	t
92	36	Заголовок списка	f
93	36	Название списка	f
94	36	Ссылка	f
95	37	Универсальный блочный контейнер	t
96	37	Универсальный строчный контейнер	f
97	37	Список	f
98	37	Таблица	f
99	38	Универсальный строчный контейнер	t
100	38	Универсальный блочный контейнер	f
101	38	Параграф	f
102	38	Заголовок	f
103	39	Создание гиперссылок	t
104	39	Создание изображения	f
105	39	Создание кнопки	f
106	39	Создание списка	f
107	40	Создание формы для отправки данных	t
108	40	Создание таблицы	f
109	40	Создание списка	f
110	40	Вставка изображения	f
111	41	<button>	t
112	41	<input type="button">	f
113	41	<btn>	f
114	41	<click>	f
115	42	Поле ввода данных	t
116	42	Кнопка	f
117	42	Изображение	f
118	42	Список	f
119	43	Создание выпадающего списка	t
120	43	Создание кнопки	f
121	43	Создание поля ввода	f
122	43	Создание таблицы	f
123	44	Использование тегов по их смыслу	t
124	44	Использование только div	f
125	44	Вёрстка без CSS	f
126	44	Использование только таблиц	f
127	45	Шапка сайта	t
128	45	Подвал сайта	f
129	45	Боковая панель	f
130	45	Основной контент	f
131	46	Подвал сайта	t
132	46	Шапка сайта	f
133	46	Навигация	f
134	46	Основной контент	f
135	47	Навигационные ссылки	t
136	47	Основной контент	f
137	47	Подвал	f
138	47	Шапка	f
139	48	Основное содержимое страницы	t
140	48	Боковая панель	f
141	48	Навигация	f
142	48	Шапка	f
143	49	Самостоятельный контент	t
144	49	Боковая панель	f
145	49	Навигация	f
146	49	Подвал	f
147	50	Раздел документа	t
148	50	Самостоятельный контент	f
149	50	Навигация	f
150	50	Шапка	f
151	51	<header>	t
152	51	<div>	f
153	51	<footer>	t
154	51	<span>	f
155	51	<main>	t
156	51	<article>	t
157	52	required	t
158	52	pattern	t
159	52	minlength	t
160	52	maxlength	t
161	52	style	f
162	52	class	f
163	53	JPEG	t
164	53	PNG	t
165	53	GIF	t
166	53	SVG	t
167	53	WebP	t
168	53	DOC	f
169	54	text	t
170	54	password	t
171	54	email	t
172	54	number	t
173	54	checkbox	t
174	54	radio	t
175	54	button	f
176	55	<html>	t
177	55	<head>	t
178	55	<body>	t
179	55	<footer>	f
180	55	<header>	f
181	55	<main>	f
182	56	<ul>	t
183	56	<ol>	t
184	56	<li>	t
185	56	<dl>	t
186	56	<p>	f
187	56	<div>	f
188	57	autoplay	t
189	57	loop	t
190	57	controls	t
191	57	muted	t
192	57	preload	t
193	57	poster	f
194	58	GET	t
195	58	POST	t
196	58	PUT	f
197	58	DELETE	f
198	58	PATCH	f
199	58	HEAD	f
200	59	<fieldset>	t
201	59	<legend>	t
202	59	<div>	t
203	59	<span>	f
204	59	<p>	f
205	59	<label>	f
206	60	aria-label	t
207	60	aria-describedby	t
208	60	role	t
209	60	tabindex	t
210	60	style	f
211	60	class	f
212	61	<blockquote>	t
213	61	<q>	t
214	61	<cite>	t
215	61	<p>	f
216	61	<span>	f
217	61	<div>	f
218	62	<strong>	t
219	62	<em>	t
220	62	<b>	t
221	62	<i>	t
222	62	<u>	t
223	62	<s>	t
224	63	<input>	t
225	63	<textarea>	t
226	63	<select>	t
227	63	<button>	t
228	63	<label>	f
229	63	<fieldset>	f
230	64	tabindex	t
231	64	accesskey	t
232	64	autofocus	t
233	64	disabled	t
234	64	readonly	t
235	64	hidden	f
236	65	CSS	t
237	65	JavaScript	t
238	65	PHP	t
239	65	Python	f
240	65	Ruby	f
241	65	Java	f
242	66	<table>	t
243	66	<tr>	t
244	66	<td>	t
245	66	<th>	t
246	66	<thead>	t
247	66	<tbody>	t
248	66	<tfoot>	t
249	67	alt	t
250	67	title	t
251	67	src	t
252	67	width	f
253	67	height	f
254	67	loading	t
255	68	<header>	t
256	68	<main>	t
257	68	<footer>	t
258	68	<nav>	t
259	68	<article>	t
260	68	<section>	t
261	68	<aside>	t
262	69	<video>	t
263	69	<audio>	t
264	69	<img>	t
265	69	<iframe>	t
266	69	<embed>	t
267	69	<object>	t
268	70	<span>	t
269	70	<a>	t
270	70	<img>	t
271	70	<strong>	t
272	70	<em>	t
273	70	<div>	f
274	70	<p>	f
275	71	action	t
276	71	method	t
277	71	enctype	t
278	71	name	t
279	71	id	f
280	71	class	f
281	72	<mark>	t
282	72	<strong>	t
283	72	<em>	t
284	72	<b>	t
285	72	<i>	t
286	72	<u>	t
287	73	<div>	t
288	73	<span>	t
289	73	<section>	t
290	73	<article>	t
291	73	<header>	t
292	73	<footer>	t
293	73	<main>	t
294	74	id	t
295	74	class	t
296	74	style	t
297	74	title	t
298	74	data-*	t
299	74	hidden	t
300	74	href	f
301	75	<nav>	t
302	75	<a>	t
303	75	<ul>	t
304	75	<li>	t
305	75	<div>	f
306	75	<span>	f
307	76	HyperText Markup Language	t
308	77	Cascading Style Sheets	t
309	78	html	t
310	79	h1	t
311	80	href	t
312	81	alt	t
313	82	ul	t
314	83	ol	t
315	84	li	t
316	85	p	t
317	86	br	t
318	87	hr	t
319	88	a	t
320	89	img	t
321	90	header	t
322	91	footer	t
323	92	nav	t
324	93	main	t
325	94	article	t
326	95	aside	t
327	96	mark	t
328	97	code	t
329	98	pre	t
330	99	video	t
331	100	audio	t
332	101	Да	t
333	101	Нет	f
334	102	Да	f
335	102	Нет	t
336	103	Да	t
337	103	Нет	f
338	104	Да	t
339	104	Нет	f
340	105	Да	f
341	105	Нет	t
342	106	Да	t
343	106	Нет	f
344	107	Да	f
345	107	Нет	t
346	108	Да	t
347	108	Нет	f
348	109	Да	f
349	109	Нет	t
350	110	Да	t
351	110	Нет	f
352	111	Да	t
353	111	Нет	f
354	112	Да	t
355	112	Нет	f
356	113	Да	t
357	113	Нет	f
358	114	Да	f
359	114	Нет	t
360	115	Да	f
361	115	Нет	t
362	116	Да	t
363	116	Нет	f
364	117	Да	f
365	117	Нет	t
366	118	Да	t
367	118	Нет	f
368	119	Да	t
369	119	Нет	f
370	120	Да	f
371	120	Нет	t
372	121	Да	t
373	121	Нет	f
374	122	Да	t
375	122	Нет	f
376	123	Да	t
377	123	Нет	f
378	124	Да	t
379	124	Нет	f
380	125	Да	t
381	125	Нет	f
382	126	Язык программирования от Google	t
383	126	Фреймворк для веб-разработки	f
384	126	База данных	f
385	126	Операционная система	f
386	127	Роберт Гриземер, Роб Пайк, Кен Томпсон	t
387	127	Бьёрн Страуструп	f
388	127	Джеймс Гослинг	f
389	127	Гвидо ван Россум	f
390	128	2009	t
391	128	2000	f
392	128	2010	f
393	128	2005	f
394	129	Легковесный поток выполнения	t
395	129	Системный процесс	f
396	129	Тип данных	f
397	129	Библиотека	f
398	130	Использовать ключевое слово go	t
399	130	Использовать ключевое слово async	f
400	130	Использовать ключевое слово thread	f
401	130	Использовать ключевое слово spawn	f
402	131	Средство для коммуникации между горутинами	t
403	131	Тип данных для хранения	f
404	131	Поток выполнения	f
405	131	Функция	f
406	132	Использовать make с chan	t
407	132	Использовать new с chan	f
408	132	Использовать createChannel()	f
409	132	Использовать &chan{}	f
410	133	Отправляет или получает данные из канала	t
411	133	Создаёт канал	f
412	133	Закрывает канал	f
413	133	Удаляет канал	f
414	134	Ожидание операций на нескольких каналах	t
415	134	Выбор данных из массива	f
416	134	Сортировка данных	f
417	134	Фильтрация данных	f
418	135	Откладывает выполнение до возврата из функции	t
419	135	Выполняет функцию сразу	f
420	135	Создаёт новую горутину	f
421	135	Завершает программу	f
422	136	В обратном порядке (LIFO)	t
423	136	В прямом порядке (FIFO)	f
424	136	В случайном порядке	f
425	136	Все одновременно	f
426	137	Встроенная функция для создания паники	t
427	137	Ошибка компиляции	f
428	137	Сборщик мусора	f
429	137	Тип данных	f
430	138	Восстановление после паники	t
431	138	Повторное выполнение	f
432	138	Создание паники	f
433	138	Удаление паники	f
434	139	Тип, определяющий набор методов	t
435	139	Графический интерфейс	f
436	139	Структура данных	f
437	139	Библиотека для веба	f
438	140	Неявно - реализовав все методы	t
439	140	С помощью ключевого слова implements	f
440	140	С помощью ключевого слова extends	f
441	140	С помощью аннотаций	f
442	141	Может хранить значение любого типа	t
443	141	Не может хранить значения	f
444	141	Только для чисел	f
445	141	Только для строк	f
446	142	Извлечение значения интерфейса конкретного типа	t
447	142	Проверка типа переменной	f
448	142	Преобразование типов	f
449	142	Создание нового типа	f
450	143	Проверка типа значения интерфейса	t
451	143	Переключение по значению	f
452	143	Сортировка типов	f
453	143	Создание типа	f
454	144	Способ организации и повторного использования кода	t
455	144	Исполняемый файл	f
456	144	Библиотека времени выполнения	f
457	144	Конфигурационный файл	f
458	145	Использовать ключевое слово import	t
459	145	Использовать include	f
460	145	Использовать require	f
461	145	Использовать using	f
462	146	Псевдоним int32 для Unicode	t
463	146	Тип для чисел с плавающей точкой	f
464	146	Тип для больших чисел	f
465	146	Тип для дат	f
466	147	Псевдоним uint8 для байта	t
467	147	Тип для чисел с плавающей точкой	f
468	147	Тип для больших чисел	f
469	147	Тип для строк	f
470	148	var или :=	t
471	148	Только var	f
472	148	Только :=	f
473	148	С помощью let	f
474	149	var везде, := только внутри функций	t
475	149	:= везде, var только внутри	f
476	149	Это одно и то же	f
477	149	Разницы нет	f
478	150	Значение по умолчанию для неинициализированных переменных	t
479	150	Нулевое значение	f
480	150	Пустое значение	f
481	150	Ошибка	f
482	151	Статическая типизация	t
483	151	Горутины	t
484	151	Быстрая компиляция	t
485	151	Динамическая типизация	f
486	151	Наследование классов	f
487	152	net/http	t
488	152	encoding/json	t
489	152	sync	t
490	152	context	t
491	152	django	f
492	152	react	f
493	153	bool	t
494	153	string	t
495	153	int	t
496	153	float64	t
497	153	byte	t
498	153	rune	t
499	154	var name type	t
500	154	var name = value	t
501	154	name := value	t
502	154	let name = value	f
503	154	const name = value	f
504	155	Массивы	t
505	155	Слайсы	t
506	155	Карты	t
507	155	Структуры	t
508	155	Списки	f
509	155	Кортежи	f
510	156	Горутины	t
511	156	Каналы	t
512	156	select	t
513	156	sync.WaitGroup	t
514	156	Мьютексы	t
515	156	Потоки Java	f
516	157	io	t
517	157	os	t
518	157	bufio	t
519	157	fmt	t
520	157	django	f
521	157	flask	f
522	158	io.Reader	t
523	158	io.Writer	t
524	158	io.Closer	t
525	158	io.File	f
526	158	io.Data	f
527	159	Каналы	t
528	159	Мьютексы	t
529	159	Атомарные операции	t
530	159	WaitGroup	t
531	159	Семафоры	f
532	159	Мониторы	f
533	160	pprof	t
534	160	go test -bench	t
535	160	go test -cpuprofile	t
536	160	go test -memprofile	t
537	160	jprofiler	f
538	160	valgrind	f
539	161	encoding/json	t
540	161	encoding/xml	t
541	161	regexp	t
542	161	yaml	f
543	161	toml	f
544	162	Value receiver	t
545	162	Pointer receiver	t
546	162	Reference receiver	f
547	162	Const receiver	f
548	163	Возврат ошибки	t
549	163	panic/recover	t
550	163	Явная проверка	t
551	163	try-catch	f
552	163	throw	f
553	164	context.Context	t
554	164	context.WithCancel	t
555	164	context.WithTimeout	t
556	164	context.WithDeadline	t
557	164	context.Cancel	f
558	165	int	t
559	165	int8	t
560	165	int16	t
561	165	int32	t
562	165	int64	t
563	165	uint	t
564	165	float32	t
565	165	float64	t
566	166	len	t
567	166	strings.Contains	t
568	166	strings.Split	t
569	166	strings.Join	t
570	166	strlen	f
571	166	strcat	f
572	167	Mutex	t
573	167	RWMutex	t
574	167	WaitGroup	t
575	167	Once	t
576	167	Cond	t
577	167	Semaphore	f
578	168	Go modules	t
579	168	go.mod	t
580	168	go.sum	t
581	168	go get	t
582	168	go mod tidy	t
583	168	npm	f
584	169	os.Open	t
585	169	os.Create	t
586	169	os.ReadFile	t
587	169	os.WriteFile	t
588	169	os.Read	f
589	169	os.Write	f
590	170	http.Get	t
591	170	http.Post	t
592	170	http.NewRequest	t
593	170	http.Client	t
594	170	http.Send	f
595	170	http.Fetch	f
596	171	JSON	t
597	171	XML	t
598	171	Base64	t
599	171	Gob	t
600	171	YAML	f
601	171	TOML	f
602	172	& (получение адреса)	t
603	172	* (разыменование)	t
604	172	-> (доступ к полю)	f
605	172	. (доступ к полю)	f
606	173	time	t
607	173	time.Time	t
608	173	time.Duration	t
609	173	datetime	f
610	173	calendar	f
611	174	testing	t
612	174	go test	t
613	174	Табличные тесты	t
614	174	Моки	t
615	174	junit	f
616	174	pytest	f
617	175	Трехцветная маркировка	t
618	175	Параллельная сборка	t
619	175	Низкие паузы	t
620	175	Stop-the-world	f
621	175	Полная остановка	f
622	176	Go	t
623	177	Golang	t
624	178	горутина	t
625	179	go	t
626	180	канал	t
627	181	make	t
628	182	select	t
629	183	defer	t
630	184	recover	t
631	185	rune	t
632	186	byte	t
633	187	:=	t
634	188	zero value	t
635	189	iota	t
636	190	слайс	t
637	191	карта	t
638	192	структура	t
639	193	интерфейс	t
640	194	метод	t
641	195	указатель	t
642	196	воркер пул	t
643	197	pprof	t
644	198	WaitGroup	t
645	199	go.mod	t
646	200	бенчмарк	t
647	201	Да	t
648	201	Нет	f
649	202	Да	f
650	202	Нет	t
651	203	Да	t
652	203	Нет	f
653	204	Да	t
654	204	Нет	f
655	205	Да	t
656	205	Нет	f
657	206	Да	t
658	206	Нет	f
659	207	Да	t
660	207	Нет	f
661	208	Да	f
662	208	Нет	t
663	209	Да	t
664	209	Нет	f
665	210	Да	t
666	210	Нет	f
667	211	Да	f
668	211	Нет	t
669	212	Да	t
670	212	Нет	f
671	213	Да	t
672	213	Нет	f
673	214	Да	t
674	214	Нет	f
675	215	Да	f
676	215	Нет	t
677	216	Да	f
678	216	Нет	t
679	217	Да	t
680	217	Нет	f
681	218	Да	t
682	218	Нет	f
683	219	Да	t
684	219	Нет	f
685	220	Да	t
686	220	Нет	f
687	221	Да	t
688	221	Нет	f
689	222	Да	t
690	222	Нет	f
691	223	Да	f
692	223	Нет	t
693	224	Да	t
694	224	Нет	f
695	225	Да	t
696	225	Нет	f
697	226	Платформа для контейнеризации приложений	t
698	226	Язык программирования	f
699	226	База данных	f
700	226	Операционная система	f
701	227	Метод виртуализации на уровне операционной системы	t
702	227	Полная виртуализация	f
703	227	Аппаратная виртуализация	f
704	227	Сетевая виртуализация	f
705	228	Контейнеры используют ядро хоста	t
706	228	ВМ используют ядро хоста	f
707	228	Контейнеры имеют своё ядро	f
708	228	Разницы нет	f
709	229	Неизменяемый шаблон для создания контейнеров	t
710	229	Запущенный контейнер	f
711	229	Остановленный контейнер	f
712	229	Конфигурационный файл	f
713	230	Запущенный экземпляр Docker-образа	t
714	230	Неизменяемый шаблон	f
715	230	Файл с инструкциями	f
716	230	Сеть для приложений	f
717	231	Публичный реестр Docker-образов	t
718	231	База данных	f
719	231	Сеть контейнеров	f
720	231	Оркестратор	f
721	232	Файл с инструкциями для сборки образа	t
722	232	Файл конфигурации сети	f
723	232	Файл с переменными окружения	f
724	232	Лог-файл	f
725	233	docker build	t
726	233	docker run	f
727	233	docker create	f
728	233	docker assemble	f
729	234	docker run	t
730	234	docker start	f
731	234	docker create	f
732	234	docker launch	f
733	235	docker ps	t
734	235	docker list	f
735	235	docker show	f
736	235	docker containers	f
737	236	docker stop	t
738	236	docker kill	f
739	236	docker pause	f
740	236	docker exit	f
741	237	docker rm	t
742	237	docker rmi	f
743	237	docker remove	f
744	237	docker delete	f
745	238	docker rmi	t
746	238	docker rm	f
747	238	docker remove	f
748	238	docker delete	f
749	239	Неизменяемая часть Docker-образа	t
750	239	Изменяемая часть образа	f
751	239	Конфигурация сети	f
752	239	Том данных	f
753	240	Кэширует слои при повторной сборке	t
754	240	Не кэширует ничего	f
755	240	Кэширует только последний слой	f
756	240	Очищает кэш при сборке	f
757	241	Фоновый процесс управления контейнерами	t
758	241	Интерфейс командной строки	f
759	241	Графический интерфейс	f
760	241	Сеть контейнеров	f
761	242	Интерфейс для взаимодействия с Docker-демоном	t
762	242	Демон управления	f
763	242	База данных	f
764	242	Сеть контейнеров	f
765	243	Указывает базовый образ для сборки	t
766	243	Устанавливает переменные	f
767	243	Копирует файлы	f
768	243	Выполняет команды	f
769	244	Выполняет команды во время сборки образа	t
770	244	Запускает контейнер	f
771	244	Копирует файлы	f
772	244	Устанавливает переменные	f
773	245	Копирует файлы из хоста в образ	t
774	245	Копирует файлы из образа в хост	f
775	245	Скачивает файлы	f
776	245	Удаляет файлы	f
777	246	Задает команду по умолчанию для контейнера	t
778	246	Задает исполняемый файл	f
779	246	Копирует файлы	f
780	246	Устанавливает переменные	f
781	247	Задает исполняемый файл для контейнера	t
782	247	Задает команду по умолчанию	f
783	247	Копирует файлы	f
784	247	Устанавливает переменные	f
785	248	Инструмент для многоконтейнерных приложений	t
786	248	Язык программирования	f
787	248	База данных	f
788	248	Сеть	f
789	249	docker-compose up	t
790	249	docker-compose start	f
791	249	docker-compose run	f
792	249	docker-compose launch	f
793	250	docker-compose.yml или compose.yaml	t
794	250	compose.json	f
795	250	docker.yml	f
796	250	compose.yaml	f
797	251	Быстрый запуск	t
798	251	Легковесность	t
799	251	Эффективное использование ресурсов	t
800	251	Требуют отдельную ОС	f
801	251	Медленный запуск	f
802	252	Демон dockerd	t
803	252	REST API	t
804	252	CLI клиент	t
805	252	Система плагинов	t
806	252	База данных	f
807	253	COPY	t
808	253	ADD	t
809	253	RUN	f
810	253	CMD	f
811	253	ENV	f
812	254	CMD	t
813	254	ENTRYPOINT	t
814	254	RUN	t
815	254	COPY	f
816	254	FROM	f
817	255	Named volumes	t
818	255	Bind mounts	t
819	255	tmpfs	t
820	255	Host mounts	f
821	255	Network mounts	f
822	256	bridge	t
823	256	host	t
824	256	overlay	t
825	256	macvlan	t
826	256	none	t
827	256	ethernet	f
828	257	docker run	t
829	257	docker stop	t
830	257	docker rm	t
831	257	docker ps	t
832	257	docker build	f
833	257	docker rmi	f
834	258	docker build	t
835	258	docker images	t
836	258	docker rmi	t
837	258	docker tag	t
838	258	docker run	f
839	258	docker stop	f
840	259	docker volume create	t
841	259	docker volume ls	t
842	259	docker volume rm	t
843	259	docker volume prune	t
844	259	docker volume delete	f
845	260	docker network create	t
846	260	docker network ls	t
847	260	docker network rm	t
848	260	docker network connect	t
849	260	docker network delete	f
850	261	-d	t
851	261	--name	t
852	261	-p	t
853	261	-v	t
854	261	-e	t
855	261	--network	t
856	262	Запуск сервисов	t
857	262	Масштабирование	t
858	262	Сети	t
859	262	Тома	t
860	262	Зависимости	t
861	262	Компиляция кода	f
862	263	up	t
863	263	down	t
864	263	logs	t
865	263	exec	t
866	263	ps	t
867	263	config	t
868	264	Минимум слоев	t
869	264	Официальные образы	t
870	264	.dockerignore	t
871	264	Конкретные теги	t
872	264	Большое количество слоев	f
873	264	Неофициальные образы	f
874	265	Многоэтапная сборка	t
875	265	Alpine-образы	t
876	265	Объединение RUN	t
877	265	Использование больших образов	f
878	265	Добавление лишних файлов	f
879	266	Кластеризация	t
880	266	Балансировка	t
881	266	Отказоустойчивость	t
882	266	Масштабирование	t
883	266	Одиночный хост	f
884	266	Локальное выполнение	f
885	267	Менеджеры	t
886	267	Рабочие ноды	t
887	267	Клиенты	f
888	267	Серверы	f
889	268	Сервисы	t
890	268	Стеки	t
891	268	Задачи	t
892	268	Ноды	t
893	268	Образы	f
894	268	Сети	f
895	269	Тома	t
896	269	Bind mounts	t
897	269	Хранение внутри контейнера	t
898	269	Базы данных	f
899	269	Файлы логов	f
900	270	docker push	t
901	270	docker pull	t
902	270	docker login	t
903	270	docker tag	f
904	270	docker save	f
905	271	-d	t
906	271	--build	t
907	271	--scale	t
908	271	--force-recreate	t
909	271	--stop	f
910	271	--remove	f
911	272	USER инструкция	t
912	272	Read-only тома	t
913	272	Капсистемы	t
914	272	Секреты	t
915	272	root доступ	f
916	272	Открытые порты	f
917	273	ENV	t
918	273	ARG	t
919	273	--env-file	t
920	273	.env файл	t
921	273	SECRET	f
922	273	CONFIG	f
923	274	docker logs	t
924	274	docker-compose logs	t
925	274	journalctl	t
926	274	syslog	t
927	274	docker events	f
928	274	docker stats	f
929	275	docker stats	t
930	275	docker events	t
931	275	cAdvisor	t
932	275	Prometheus	t
933	275	docker logs	f
934	275	docker ps	f
935	276	Docker	t
936	277	Dockerfile	t
937	278	образ	t
938	279	контейнер	t
939	280	docker build	t
940	281	docker run	t
941	282	docker ps	t
942	283	docker stop	t
943	284	docker rm	t
944	285	docker rmi	t
945	286	FROM	t
946	287	RUN	t
947	288	COPY	t
948	289	CMD	t
949	290	ENTRYPOINT	t
950	291	Docker Compose	t
951	292	docker-compose up	t
952	293	docker-compose down	t
953	294	bridge	t
954	295	named volumes	t
955	296	bind mounts	t
956	297	Docker Swarm	t
957	298	нода	t
958	299	docker-compose.yml	t
959	300	docker logs	t
960	301	Да	t
961	301	Нет	f
962	302	Да	t
963	302	Нет	f
964	303	Да	t
965	303	Нет	f
966	304	Да	f
967	304	Нет	t
968	305	Да	f
969	305	Нет	t
970	306	Да	t
971	306	Нет	f
972	307	Да	t
973	307	Нет	f
974	308	Да	f
975	308	Нет	t
976	309	Да	f
977	309	Нет	t
978	310	Да	f
979	310	Нет	t
980	311	Да	t
981	311	Нет	f
982	312	Да	f
983	312	Нет	t
984	313	Да	t
985	313	Нет	f
986	314	Да	t
987	314	Нет	f
988	315	Да	t
989	315	Нет	f
990	316	Да	t
991	316	Нет	f
992	317	Да	f
993	317	Нет	t
994	318	Да	f
995	318	Нет	t
996	319	Да	f
997	319	Нет	t
998	320	Да	t
999	320	Нет	f
1000	321	Да	t
1001	321	Нет	f
1002	322	Да	t
1003	322	Нет	f
1004	323	Да	t
1005	323	Нет	f
1006	324	Да	f
1007	324	Нет	t
1008	325	Да	t
1009	325	Нет	f
1010	326	Совокупность устройств для обмена данными	t
1011	326	Один компьютер	f
1012	326	Программа для связи	f
1013	326	База данных	f
1014	327	7-уровневая эталонная модель	t
1015	327	4-уровневая модель	f
1016	327	5-уровневая модель	f
1017	327	6-уровневая модель	f
1018	328	7 уровней	t
1019	328	4 уровня	f
1020	328	5 уровней	f
1021	328	6 уровней	f
1022	329	4-уровневая практическая модель	t
1023	329	7-уровневая теоретическая модель	f
1024	329	5-уровневая модель	f
1025	329	6-уровневая модель	f
1026	330	4 уровня	t
1027	330	7 уровней	f
1028	330	5 уровней	f
1029	330	6 уровней	f
1030	331	Уникальный идентификатор устройства в сети	t
1031	331	Имя устройства	f
1032	331	Пароль устройства	f
1033	331	Модель устройства	f
1034	332	32 бита	t
1035	332	16 бит	f
1036	332	64 бита	f
1037	332	128 бит	f
1038	333	128 бит	t
1039	333	32 бита	f
1040	333	64 бита	f
1041	333	256 бит	f
1042	334	Определяет границы сети и хостов	t
1043	334	Скрывает IP-адрес	f
1044	334	Шифрует данные	f
1045	334	Маскирует порты	f
1046	335	Преобразует домены в IP-адреса	t
1047	335	Преобразует IP в MAC	f
1048	335	Преобразует порты	f
1049	335	Преобразует протоколы	f
1050	336	Автоматическая настройка сети	t
1051	336	Ручная настройка сети	f
1052	336	Шифрование данных	f
1053	336	Сжатие данных	f
1054	337	Преобразование сетевых адресов	t
1055	337	Преобразование портов	f
1056	337	Шифрование адресов	f
1057	337	Маскировка данных	f
1058	338	Идентификатор процесса (0-65535)	t
1059	338	Физическое устройство	f
1060	338	Кабель	f
1061	338	Маршрутизатор	f
1062	339	Физический адрес сетевого интерфейса, 48 бит	t
1063	339	Логический адрес, 32 бита	f
1064	339	IP-адрес	f
1065	339	Порт	f
1066	340	Семейство технологий для локальных сетей	t
1067	340	Язык программирования	f
1068	340	База данных	f
1069	340	Протокол маршрутизации	f
1070	341	Устройство канального уровня	t
1071	341	Устройство сетевого уровня	f
1072	341	Устройство транспортного уровня	f
1073	341	Устройство прикладного уровня	f
1074	342	Устройство сетевого уровня	t
1075	342	Устройство канального уровня	f
1076	342	Устройство транспортного уровня	f
1077	342	Устройство физического уровня	f
1078	343	Виртуальная локальная сеть	t
1079	343	Физическая сеть	f
1080	343	Глобальная сеть	f
1081	343	Беспроводная сеть	f
1082	344	Протокол с соединением и гарантией доставки	t
1083	344	Протокол без соединения	f
1084	344	Протокол без гарантии доставки	f
1085	344	Протокол для веба	f
1086	345	Протокол без соединения и гарантии	t
1087	345	Протокол с соединением	f
1088	345	Протокол с гарантией доставки	f
1089	345	Протокол для веба	f
1090	346	Протокол передачи гипертекста	t
1091	346	Протокол передачи файлов	f
1092	346	Протокол передачи почты	f
1093	346	Протокол передачи видео	f
1094	347	HTTP с шифрованием через SSL/TLS	t
1095	347	HTTP без шифрования	f
1096	347	Быстрый HTTP	f
1097	347	Медленный HTTP	f
1098	348	Протокол для передачи файлов	t
1099	348	Протокол для передачи гипертекста	f
1100	348	Протокол для передачи почты	f
1101	348	Протокол для передачи видео	f
1102	349	Протокол для безопасного удалённого управления	t
1103	349	Протокол для передачи файлов	f
1104	349	Протокол для отправки почты	f
1105	349	Протокол для передачи гипертекста	f
1106	350	Виртуальная частная сеть для безопасного соединения	t
1107	350	Виртуальная публичная сеть	f
1108	350	Физическая частная сеть	f
1109	350	Физическая публичная сеть	f
1110	351	Физический	t
1111	351	Канальный	t
1112	351	Сетевой	t
1113	351	Транспортный	t
1114	351	Сеансовый	t
1115	351	Представительный	t
1116	351	Прикладной	t
1117	351	Только сетевой	f
1118	352	Прикладной	t
1119	352	Транспортный	t
1120	352	Межсетевой	t
1121	352	Сетевой интерфейс	t
1122	352	Физический	f
1123	352	Канальный	f
1124	353	TCP	t
1125	353	UDP	t
1126	353	SCTP	t
1127	353	DCCP	t
1128	353	IP	f
1129	353	ICMP	f
1130	354	HTTP	t
1131	354	FTP	t
1132	354	SMTP	t
1133	354	DNS	t
1134	354	SSH	t
1135	354	SNMP	t
1136	354	TCP	f
1137	354	UDP	f
1138	355	RIP	t
1139	355	OSPF	t
1140	355	BGP	t
1141	355	EIGRP	t
1142	355	TCP	f
1143	355	UDP	f
1144	356	GET	t
1145	356	POST	t
1146	356	PUT	t
1147	356	DELETE	t
1148	356	PATCH	t
1149	356	HEAD	t
1150	356	SEND	f
1151	356	RECEIVE	f
1152	357	2xx Успех	t
1153	357	3xx Перенаправление	t
1154	357	4xx Ошибка клиента	t
1155	357	5xx Ошибка сервера	t
1156	357	1xx Информационные	t
1157	357	6xx Ошибка сети	f
1158	358	SMTP	t
1159	358	POP3	t
1160	358	IMAP	t
1161	358	HTTP	f
1162	358	FTP	f
1163	358	SSH	f
1164	359	Коммутаторы	t
1165	359	Маршрутизаторы	t
1166	359	Сетевые карты	t
1167	359	Хабы	t
1168	359	Принтеры	f
1169	359	Мониторы	f
1170	360	Витая пара	t
1171	360	Коаксиальный	t
1172	360	Оптоволокно	t
1173	360	USB	f
1174	360	HDMI	f
1175	360	VGA	f
1176	361	Звезда	t
1177	361	Шина	t
1178	361	Кольцо	t
1179	361	Ячеистая	t
1180	361	Треугольник	f
1181	361	Квадрат	f
1182	362	Unicast	t
1183	362	Multicast	t
1184	362	Broadcast	t
1185	362	Anycast	t
1186	362	Singlecast	f
1187	362	Doublecast	f
1188	363	IPsec	t
1189	363	SSL/TLS	t
1190	363	SSH	t
1191	363	VPN	t
1192	363	HTTP	f
1193	363	FTP	f
1194	364	Firewall	t
1195	364	IDS	t
1196	364	IPS	t
1197	364	DMZ	t
1198	364	VPN	t
1199	364	Router	f
1200	364	Switch	f
1201	365	OSPF	t
1202	365	RIP	t
1203	365	EIGRP	t
1204	365	BGP	f
1205	365	TCP	f
1206	366	BGP	t
1207	366	OSPF	f
1208	366	RIP	f
1209	366	EIGRP	f
1210	367	Source IP	t
1211	367	Destination IP	t
1212	367	TTL	t
1213	367	Protocol	t
1214	367	Port	f
1215	367	MAC	f
1216	368	Соединение	t
1217	368	Гарантия доставки	t
1218	368	Управление потоком	t
1219	368	Управление перегрузкой	t
1220	368	Без соединения	f
1221	368	Без гарантии	f
1222	369	Без соединения	t
1223	369	Без гарантии	t
1224	369	Быстрый	t
1225	369	Без управления потоком	t
1226	369	С соединением	f
1227	369	С гарантией	f
1228	370	IP-адрес	t
1229	370	Маска подсети	t
1230	370	Шлюз по умолчанию	t
1231	370	DNS-сервер	t
1232	370	MAC-адрес	f
1233	370	Порт	f
1234	371	DDoS	t
1235	371	ARP-spoofing	t
1236	371	DNS-spoofing	t
1237	371	MITM	t
1238	371	VLAN	f
1239	371	NAT	f
1240	372	SSH	t
1241	372	Telnet	t
1242	372	HTTP	f
1243	372	FTP	f
1244	372	SMTP	f
1245	373	ICMP (ping)	t
1246	373	ICMP (traceroute)	t
1247	373	TCP	f
1248	373	UDP	f
1249	373	HTTP	f
1250	374	802.1Q	t
1251	374	VTP	t
1252	374	DTP	t
1253	374	STP	f
1254	374	LACP	f
1255	375	LACP	t
1256	375	PAgP	t
1257	375	STP	f
1258	375	VTP	f
1259	375	DTP	f
1260	376	OSI	t
1261	377	TCP/IP	t
1262	378	32	t
1263	379	128	t
1264	380	DNS	t
1265	381	DHCP	t
1266	382	NAT	t
1267	383	MAC-адрес	t
1268	384	коммутатор	t
1269	385	маршрутизатор	t
1270	386	TCP	t
1271	387	UDP	t
1272	388	HTTP	t
1273	389	HTTPS	t
1274	390	FTP	t
1275	391	SSH	t
1276	392	SMTP	t
1277	393	POP3	t
1278	394	IMAP	t
1279	395	SNMP	t
1280	396	NTP	t
1281	397	VPN	t
1282	398	IDS	t
1283	399	IPS	t
1284	400	ICMP	t
1285	401	Да	t
1286	401	Нет	f
1287	402	Да	t
1288	402	Нет	f
1289	403	Да	t
1290	403	Нет	f
1291	404	Да	f
1292	404	Нет	t
1293	405	Да	f
1294	405	Нет	t
1295	406	Да	f
1296	406	Нет	t
1297	407	Да	f
1298	407	Нет	t
1299	408	Да	t
1300	408	Нет	f
1301	409	Да	f
1302	409	Нет	t
1303	410	Да	f
1304	410	Нет	t
1305	411	Да	f
1306	411	Нет	t
1307	412	Да	t
1308	412	Нет	f
1309	413	Да	t
1310	413	Нет	f
1311	414	Да	t
1312	414	Нет	f
1313	415	Да	t
1314	415	Нет	f
1315	416	Да	t
1316	416	Нет	f
1317	417	Да	f
1318	417	Нет	t
1319	418	Да	t
1320	418	Нет	f
1321	419	Да	f
1322	419	Нет	t
1323	420	Да	t
1324	420	Нет	f
1325	421	Да	f
1326	421	Нет	t
1327	422	Да	t
1328	422	Нет	f
1329	423	Да	t
1330	423	Нет	f
1331	424	Да	f
1332	424	Нет	t
1333	425	Да	f
1334	425	Нет	t
1335	426	Интерпретируемый язык для веб-страниц	t
1336	426	Язык разметки	f
1337	426	База данных	f
1338	426	Операционная система	f
1339	427	Брендан Эйх	t
1340	427	Бьёрн Страуструп	f
1341	427	Джеймс Гослинг	f
1342	427	Гвидо ван Россум	f
1343	428	1995	t
1344	428	1990	f
1345	428	2000	f
1346	428	1985	f
1347	429	8 типов (7 примитивных, 1 ссылочный)	t
1348	429	Только 5	f
1349	429	Только 6	f
1350	429	Только 10	f
1351	430	var, let или const	t
1352	430	Только var	f
1353	430	Только let	f
1354	430	Только const	f
1355	431	var - функциональная, let - блочная область	t
1356	431	let - функциональная, var - блочная	f
1357	431	Разницы нет	f
1358	431	Оба имеют блочную область	f
1359	432	const нельзя переопределить, let можно	t
1360	432	let нельзя переопределить, const можно	f
1361	432	Разницы нет	f
1362	432	Оба можно переопределить	f
1363	433	Переменная объявлена, но не инициализирована	t
1364	433	Переменная не объявлена	f
1365	433	Пустое значение	f
1366	433	Ошибка	f
1367	434	Специальное значение "ничего"	t
1368	434	Неопределенное значение	f
1369	434	Ошибка	f
1370	434	Число	f
1371	435	Not a Number	t
1372	435	Null	f
1373	435	Undefined	f
1374	435	Empty	f
1375	436	Оператор typeof	t
1376	436	Оператор instanceof	f
1377	436	Оператор in	f
1378	436	Метод typeOf()	f
1379	437	Сравнение с приведением типов	t
1380	437	Строгое сравнение	f
1381	437	Присваивание	f
1382	437	Сложение	f
1383	438	Строгое сравнение без приведения	t
1384	438	Сравнение с приведением	f
1385	438	Присваивание	f
1386	438	Вычитание	f
1387	439	Функция, запоминающая своё окружение	t
1388	439	Встроенная функция	f
1389	439	Глобальная функция	f
1390	439	Анонимная функция	f
1391	440	Синтаксис () => {} с лексическим this	t
1392	440	Обычная функция	f
1393	440	Функция с this	f
1394	440	Функция без аргументов	f
1395	441	Функция, принимающая или возвращающая функцию	t
1396	441	Глобальная функция	f
1397	441	Встроенная функция	f
1398	441	Простая функция	f
1399	442	Функция, переданная как аргумент	t
1400	442	Функция, возвращаемая из функции	f
1401	442	Встроенная функция	f
1402	442	Глобальная функция	f
1403	443	Немедленно вызываемая функция	t
1404	443	Обычная функция	f
1405	443	Стрелочная функция	f
1406	443	Асинхронная функция	f
1407	444	Механизм наследования в JavaScript	t
1408	444	Тип данных	f
1409	444	Функция	f
1410	444	Массив	f
1411	445	Синтаксический сахар над прототипами	t
1412	445	Отдельный язык	f
1413	445	Тип данных	f
1414	445	Функция	f
1415	446	Объект для работы с асинхронными операциями	t
1416	446	Синхронная операция	f
1417	446	Тип данных	f
1418	446	Функция	f
1419	447	Синтаксический сахар для Promise	t
1420	447	Новый тип данных	f
1421	447	Новая функция	f
1422	447	Новый объект	f
1423	448	Представление HTML-документа	t
1424	448	База данных	f
1425	448	Операционная система	f
1426	448	Язык программирования	f
1427	449	Стандарт ECMAScript 2015	t
1428	449	Версия браузера	f
1429	449	Операционная система	f
1430	449	База данных	f
1431	450	Контекст выполнения функции	t
1432	450	Глобальный объект	f
1433	450	Переменная	f
1434	450	Функция	f
1435	451	number	t
1436	451	string	t
1437	451	boolean	t
1438	451	null	t
1439	451	undefined	t
1440	451	symbol	t
1441	451	bigint	t
1442	451	object	f
1443	452	var	t
1444	452	let	t
1445	452	const	t
1446	452	function	f
1447	452	class	f
1448	453	false	t
1449	453	0	t
1450	453	""	t
1451	453	null	t
1452	453	undefined	t
1453	453	NaN	t
1454	453	[]	f
1455	453	{}	f
1456	454	Function declaration	t
1457	454	Function expression	t
1458	454	Стрелочные функции	t
1459	454	Классы	f
1460	454	Методы	f
1461	455	map	t
1462	455	filter	t
1463	455	slice	t
1464	455	concat	t
1465	455	push	f
1466	455	pop	f
1467	456	push	t
1468	456	pop	t
1469	456	shift	t
1470	456	unshift	t
1471	456	splice	t
1472	456	sort	t
1473	456	reverse	t
1474	456	map	f
1475	456	filter	f
1476	457	find	t
1477	457	findIndex	t
1478	457	filter	f
1479	457	map	f
1480	458	some	t
1481	458	every	t
1482	458	includes	t
1483	458	map	f
1484	458	filter	f
1485	459	trim	t
1486	459	split	t
1487	459	join	t
1488	459	replace	t
1489	459	replaceAll	t
1490	459	startsWith	t
1491	459	endsWith	t
1492	459	push	f
1493	459	pop	f
1494	460	pending	t
1495	460	fulfilled	t
1496	460	rejected	t
1497	460	resolved	f
1498	460	error	f
1499	461	then	t
1500	461	catch	t
1501	461	finally	t
1502	461	resolve	f
1503	461	reject	f
1504	462	getElementById	t
1505	462	querySelector	t
1506	462	querySelectorAll	t
1507	462	getElementsByClassName	t
1508	462	find	f
1509	462	findAll	f
1510	463	classList.add	t
1511	463	classList.remove	t
1512	463	classList.toggle	t
1513	463	classList.contains	t
1514	463	classList.replace	f
1515	463	classList.set	f
1516	464	appendChild	t
1517	464	append	t
1518	464	prepend	t
1519	464	insertBefore	t
1520	464	addChild	f
1521	464	insertAfter	f
1522	465	remove	t
1523	465	removeChild	t
1524	465	delete	f
1525	465	removeElement	f
1526	466	Литерал {}	t
1527	466	new Object()	t
1528	466	Object.create()	t
1529	466	Классы	t
1530	466	new Function()	f
1531	466	create()	f
1532	467	in	t
1533	467	hasOwnProperty	t
1534	467	Object.hasOwn	t
1535	467	exists	f
1536	467	has	f
1537	468	Object.getPrototypeOf	t
1538	468	Object.setPrototypeOf	t
1539	468	Object.create	t
1540	468	prototype	f
1541	468	__proto__	f
1542	469	bind	t
1543	469	call	t
1544	469	apply	t
1545	469	attach	f
1546	469	set	f
1547	470	JSON.stringify	t
1548	470	JSON.parse	t
1549	470	JSON.serialize	f
1550	470	JSON.deserialize	f
1551	470	toJSON	f
1552	471	new Date()	t
1553	471	Date.now()	t
1554	471	getTime()	t
1555	471	toISOString()	t
1556	471	now()	f
1557	471	current()	f
1558	472	Number	t
1559	472	parseInt	t
1560	472	parseFloat	t
1561	472	isNaN	t
1562	472	isFinite	t
1563	472	toNumber	f
1564	472	toInt	f
1565	473	test	t
1566	473	exec	t
1567	473	match	t
1568	473	replace	t
1569	473	search	t
1570	473	find	f
1571	473	contains	f
1572	474	click	t
1573	474	input	t
1574	474	submit	t
1575	474	load	t
1576	474	DOMContentLoaded	t
1577	474	keydown	t
1578	474	hover	f
1579	474	doubleclick	f
1580	475	classList.add	t
1581	475	classList.remove	t
1582	475	classList.toggle	t
1583	475	classList.contains	t
1584	475	classList.replace	f
1585	475	classList.set	f
1586	476	Брендан Эйх	t
1587	477	1995	t
1588	478	===	t
1589	479	==	t
1590	480	let	t
1591	481	const	t
1592	482	prototype	t
1593	483	рекурсия	t
1594	484	замыкание	t
1595	485	IIFE	t
1596	486	Promise	t
1597	487	async/await	t
1598	488	map	t
1599	489	filter	t
1600	490	reduce	t
1601	491	includes	t
1602	492	forEach	t
1603	493	split	t
1604	494	join	t
1605	495	DOM	t
1606	496	querySelector	t
1607	497	classList.add	t
1608	498	classList.remove	t
1609	499	document.createElement	t
1610	500	addEventListener	t
1611	501	Да	t
1612	501	Нет	f
1613	502	Да	f
1614	502	Нет	t
1615	503	Да	t
1616	503	Нет	f
1617	504	Да	f
1618	504	Нет	t
1619	505	Да	f
1620	505	Нет	t
1621	506	Да	f
1622	506	Нет	t
1623	507	Да	t
1624	507	Нет	f
1625	508	Да	f
1626	508	Нет	t
1627	509	Да	f
1628	509	Нет	t
1629	510	Да	f
1630	510	Нет	t
1631	511	Да	t
1632	511	Нет	f
1633	512	Да	t
1634	512	Нет	f
1635	513	Да	f
1636	513	Нет	t
1637	514	Да	t
1638	514	Нет	f
1639	515	Да	f
1640	515	Нет	t
1641	516	Да	t
1642	516	Нет	f
1643	517	Да	t
1644	517	Нет	f
1645	518	Да	t
1646	518	Нет	f
1647	519	Да	t
1648	519	Нет	f
1649	520	Да	t
1650	520	Нет	f
1651	521	Да	f
1652	521	Нет	t
1653	522	Да	f
1654	522	Нет	t
1655	523	Да	f
1656	523	Нет	t
1657	524	Да	t
1658	524	Нет	f
1659	525	Да	t
1660	525	Нет	f
1661	526	list, dict, set, bytearray	t
1662	526	int, str, tuple	f
1663	526	Только list	f
1664	526	Только dict	f
1665	527	int, str, tuple, frozenset, bytes	t
1666	527	list, dict, set	f
1667	527	Только int	f
1668	527	Только str	f
1669	528	Анонимная функция для простых операций в одну строку	t
1670	528	Функция с именем	f
1671	528	Функция с несколькими выражениями	f
1672	528	Обычная функция	f
1673	529	Строка документации в тройных кавычках	t
1674	529	Комментарий с #	f
1675	529	Строка для отладки	f
1676	529	Ошибка в коде	f
1677	530	list изменяемый, tuple неизменяемый	t
1678	530	tuple изменяемый, list неизменяемый	f
1679	530	Оба неизменяемые	f
1680	530	Оба изменяемые	f
1681	531	Ссылка на текущий экземпляр класса	t
1682	531	Ссылка на родительский класс	f
1683	531	Глобальная переменная	f
1684	531	Имя класса	f
1685	532	Функция, расширяющая поведение другой функции	t
1686	532	Функция для декорирования строк	f
1687	532	Класс для GUI	f
1688	532	Метод класса	f
1689	533	Неизменяемые (hashable) объекты	t
1690	533	Любые объекты	f
1691	533	Только строки	f
1692	533	Только числа	f
1693	534	Функция с yield, генерирующая значения лениво	t
1694	534	Обычная функция	f
1695	534	Список значений	f
1696	534	Класс	f
1697	535	Объект с __iter__() и __next__() для обхода	t
1698	535	Список	f
1699	535	Кортеж	f
1700	535	Словарь	f
1701	536	Объект с __enter__() и __exit__() для управления ресурсами	t
1702	536	Менеджер памяти	f
1703	536	Управление потоками	f
1704	536	Класс	f
1705	537	Глобальная блокировка интерпретатора	t
1706	537	Глобальный интерпретатор	f
1707	537	Язык программирования	f
1708	537	Библиотека	f
1709	538	Порядок разрешения методов (алгоритм C3)	t
1710	538	Метод сортировки	f
1711	538	Оптимизация памяти	f
1712	538	Метод классов	f
1713	539	Ограничивает атрибуты и экономит память	t
1714	539	Увеличивает память	f
1715	539	Добавляет атрибуты	f
1716	539	Удаляет атрибуты	f
1717	540	Класс, создающий другие классы	t
1718	540	Обычный класс	f
1719	540	Декоратор	f
1720	540	Функция	f
1721	541	Руководство по стилю кода Python	t
1722	541	Новая версия Python	f
1723	541	Библиотека	f
1724	541	Фреймворк	f
1725	542	Указание ожидаемых типов для статической проверки	t
1726	542	Обязательные типы, как в C	f
1727	542	Только для документации	f
1728	542	Для ускорения кода	f
1729	543	Библиотека для асинхронного программирования	t
1730	543	Библиотека для работы с файлами	f
1731	543	Библиотека для работы с сетью	f
1732	543	Фреймворк	f
1733	544	Декоратор для автоматической генерации методов	t
1734	544	Класс для данных	f
1735	544	Модуль для работы с БД	f
1736	544	Утилита для отладки	f
1737	545	Модуль для создания перечислений	t
1738	545	Модуль для работы с числами	f
1739	545	Модуль для работы со строками	f
1740	545	Модуль для работы с файлами	f
1741	546	Форматированные строки с префиксом f	t
1742	546	Строки для файлов	f
1743	546	Функция форматирования	f
1744	546	Метод строк	f
1745	547	Проверка прямого запуска скрипта	t
1746	547	Проверка имени модуля	f
1747	547	Всегда True	f
1748	547	Проверка типа	f
1749	548	Формальное представление объекта для разработчиков	t
1750	548	Представление для пользователей	f
1751	548	Метод для вывода	f
1752	548	Строка документации	f
1753	549	Читаемое представление объекта для пользователей	t
1754	549	Представление для разработчиков	f
1755	549	Метод для вывода	f
1756	549	Строка документации	f
1757	550	Оператор := для присваивания в выражении	t
1758	550	Оператор сравнения	f
1759	550	Оператор сложения	f
1760	550	Оператор умножения	f
1761	551	list	t
1762	551	dict	t
1763	551	set	t
1764	551	bytearray	t
1765	551	int	f
1766	551	str	f
1767	551	tuple	f
1768	552	int	t
1769	552	str	t
1770	552	tuple	t
1771	552	frozenset	t
1772	552	bytes	t
1773	552	list	f
1774	552	dict	f
1775	552	set	f
1776	553	class	t
1777	553	type()	t
1778	553	метаклассы	t
1779	553	dataclasses	t
1780	553	function	f
1781	553	lambda	f
1782	554	type()	t
1783	554	isinstance()	t
1784	554	issubclass()	t
1785	554	typeof()	f
1786	554	gettype()	f
1787	555	len()	t
1788	555	min()	t
1789	555	max()	t
1790	555	sorted()	t
1791	555	reversed()	t
1792	555	sum()	t
1793	555	count()	f
1794	555	length()	f
1795	556	lower()	t
1796	556	upper()	t
1797	556	split()	t
1798	556	join()	t
1799	556	replace()	t
1800	556	strip()	t
1801	556	append()	f
1802	556	pop()	f
1803	557	append()	t
1804	557	pop()	t
1805	557	insert()	t
1806	557	remove()	t
1807	557	sort()	t
1808	557	reverse()	t
1809	557	lower()	f
1810	557	upper()	f
1811	558	get()	t
1812	558	keys()	t
1813	558	values()	t
1814	558	items()	t
1815	558	update()	t
1816	558	pop()	t
1817	558	append()	f
1818	558	push()	f
1819	559	add()	t
1820	559	remove()	t
1821	559	union()	t
1822	559	intersection()	t
1823	559	difference()	t
1824	559	append()	f
1825	559	push()	f
1826	560	map()	t
1827	560	filter()	t
1828	560	reduce()	t
1829	560	sorted()	t
1830	560	forEach()	f
1831	560	each()	f
1832	561	@classmethod	t
1833	561	@staticmethod	t
1834	561	@property	t
1835	561	@decorator	f
1836	561	@method	f
1837	562	pip	t
1838	562	poetry	t
1839	562	pipenv	t
1840	562	conda	t
1841	562	npm	f
1842	562	gem	f
1843	563	numpy	t
1844	563	pandas	t
1845	563	matplotlib	t
1846	563	scipy	t
1847	563	sklearn	t
1848	563	django	f
1849	563	flask	f
1850	564	django	t
1851	564	flask	t
1852	564	fastapi	t
1853	564	aiohttp	t
1854	564	numpy	f
1855	564	pandas	f
1856	565	pylint	t
1857	565	flake8	t
1858	565	mypy	t
1859	565	black	t
1860	565	jupyter	f
1861	565	pytest	f
1862	566	copy.copy()	t
1863	566	copy.deepcopy()	t
1864	566	присваивание	t
1865	566	clone()	f
1866	566	duplicate()	f
1867	567	open()	t
1868	567	read()	t
1869	567	write()	t
1870	567	close()	t
1871	567	with	t
1872	567	create()	f
1873	567	delete()	f
1874	568	os	t
1875	568	pathlib	t
1876	568	shutil	t
1877	568	tempfile	t
1878	568	glob	t
1879	568	json	f
1880	568	csv	f
1881	569	__iter__()	t
1882	569	__next__()	t
1883	569	iter()	t
1884	569	next()	t
1885	569	forEach()	f
1886	569	each()	f
1887	570	datetime	t
1888	570	time	t
1889	570	calendar	t
1890	570	dateutil	t
1891	570	os	f
1892	570	sys	f
1893	571	json	t
1894	571	pickle	t
1895	571	xml	t
1896	571	csv	t
1897	571	yaml	t
1898	571	os	f
1899	571	sys	f
1900	572	try	t
1901	572	except	t
1902	572	else	t
1903	572	finally	t
1904	572	raise	t
1905	572	catch	f
1906	572	throw	f
1907	573	import	t
1908	573	from ... import	t
1909	573	importlib	t
1910	573	include	f
1911	573	require	f
1912	574	re.search()	t
1913	574	re.match()	t
1914	574	re.findall()	t
1915	574	re.sub()	t
1916	574	re.compile()	t
1917	574	re.find()	f
1918	574	re.replace()	f
1919	575	threading	t
1920	575	multiprocessing	t
1921	575	asyncio	t
1922	575	concurrent.futures	t
1923	575	subprocess	f
1924	575	os	f
1925	576	лямбда	t
1926	577	tuple	t
1927	578	docstring	t
1928	579	self	t
1929	580	декоратор	t
1930	581	генератор	t
1931	582	итератор	t
1932	583	GIL	t
1933	584	MRO	t
1934	585	PEP8	t
1935	586	asyncio	t
1936	587	dataclasses	t
1937	588	enum	t
1938	589	walrus	t
1939	590	__name__ == "__main__"	t
1940	591	__repr__	t
1941	592	__str__	t
1942	593	typing	t
1943	594	with	t
1944	595	pass	t
1945	596	dir	t
1946	597	help	t
1947	598	pdb	t
1948	599	re	t
1949	600	os	t
1950	601	Да	t
1951	601	Нет	f
1952	602	Да	t
1953	602	Нет	f
1954	603	Да	t
1955	603	Нет	f
1956	604	Да	t
1957	604	Нет	f
1958	605	Да	f
1959	605	Нет	t
1960	606	Да	f
1961	606	Нет	t
1962	607	Да	t
1963	607	Нет	f
1964	608	Да	f
1965	608	Нет	t
1966	609	Да	t
1967	609	Нет	f
1968	610	Да	t
1969	610	Нет	f
1970	611	Да	f
1971	611	Нет	t
1972	612	Да	t
1973	612	Нет	f
1974	613	Да	f
1975	613	Нет	t
1976	614	Да	t
1977	614	Нет	f
1978	615	Да	t
1979	615	Нет	f
1980	616	Да	f
1981	616	Нет	t
1982	617	Да	t
1983	617	Нет	f
1984	618	Да	t
1985	618	Нет	f
1986	619	Да	f
1987	619	Нет	t
1988	620	Да	f
1989	620	Нет	t
1990	621	Да	t
1991	621	Нет	f
1992	622	Да	f
1993	622	Нет	t
1994	623	Да	t
1995	623	Нет	f
1996	624	Да	f
1997	624	Нет	t
1998	625	Да	f
1999	625	Нет	t
2000	626	Семейство Unix-подобных ОС с открытым исходным кодом	t
2001	626	Язык программирования	f
2002	626	База данных	f
2003	626	Офисный пакет	f
2004	627	Линус Торвальдс	t
2005	627	Ричард Столлман	f
2006	627	Билл Гейтс	f
2007	627	Стив Джобс	f
2008	628	Сборка ядра с ПО и менеджером пакетов	t
2009	628	Ядро Linux	f
2010	628	Только менеджер пакетов	f
2011	628	Только система инициализации	f
2012	629	Центральная часть ОС, управляющая аппаратными ресурсами	t
2013	629	Графический интерфейс	f
2014	629	Текстовый редактор	f
2015	629	Браузер	f
2016	630	Интерпретатор командной строки	t
2017	630	Оболочка ядра	f
2018	630	Графическая оболочка	f
2019	630	Файловая система	f
2020	631	Наиболее популярный командный интерпретатор	t
2021	631	Язык программирования	f
2022	631	Редактор кода	f
2023	631	Файловый менеджер	f
2024	632	Способ организации и хранения файлов на диске	t
2025	632	Программа для работы с файлами	f
2026	632	Тип файлов	f
2027	632	Менеджер файлов	f
2028	633	Структура данных с метаданными файла	t
2029	633	Имя файла	f
2030	633	Содержимое файла	f
2031	633	Путь к файлу	f
2032	634	Файл, указывающий на другой файл или каталог	t
2033	634	Прямая ссылка на inode	f
2034	634	Копия файла	f
2035	634	Дубликат файла	f
2036	635	Прямая ссылка на inode файла	t
2037	635	Файл, указывающий на имя файла	f
2038	635	Копия файла	f
2039	635	Ярлык	f
2040	636	Подключение файловой системы к корневому каталогу	t
2041	636	Создание файловой системы	f
2042	636	Удаление файловой системы	f
2043	636	Форматирование диска	f
2044	637	Фоновый процесс без привязки к терминалу	t
2045	637	Злой дух	f
2046	637	Программа с GUI	f
2047	637	Интерактивная программа	f
2048	638	Уникальный идентификатор процесса	t
2049	638	Идентификатор пользователя	f
2050	638	Идентификатор группы	f
2051	638	Идентификатор файла	f
2052	639	Современная система инициализации и управления службами	t
2053	639	Сервис для логов	f
2054	639	Сервис для сети	f
2055	639	Сервис для файлов	f
2056	640	Суперпользователь с полными правами	t
2057	640	Обычный пользователь	f
2058	640	Гостевой пользователь	f
2059	640	Системный пользователь	f
2060	641	pwd	t
2061	641	cd	f
2062	641	ls	f
2063	641	dir	f
2064	642	cd	t
2065	642	pwd	f
2066	642	ls	f
2067	642	mkdir	f
2068	643	ls	t
2069	643	pwd	f
2070	643	cd	f
2071	643	cat	f
2072	644	mkdir	t
2073	644	touch	f
2074	644	create	f
2075	644	newdir	f
2076	645	rm	t
2077	645	rmdir	f
2078	645	delete	f
2079	645	remove	f
2080	646	cp	t
2081	646	mv	f
2082	646	copy	f
2083	646	clone	f
2084	647	mv	t
2085	647	cp	f
2086	647	move	f
2087	647	rename	f
2088	648	find	t
2089	648	grep	f
2090	648	search	f
2091	648	lookup	f
2092	649	grep	t
2093	649	find	f
2094	649	search	f
2095	649	lookup	f
2096	650	df	t
2097	650	du	f
2098	650	free	f
2099	650	space	f
2100	651	APT	t
2101	651	DNF/YUM	t
2102	651	Pacman	t
2103	651	Zypper	t
2104	651	npm	f
2105	651	pip	f
2106	652	Systemd	t
2107	652	SysV init	t
2108	652	Upstart	t
2109	652	OpenRC	t
2110	652	Systemctl	f
2111	652	Initd	f
2112	653	cat	t
2113	653	less	t
2114	653	more	t
2115	653	head	t
2116	653	tail	t
2117	653	grep	f
2118	653	find	f
2119	654	Чтение (r)	t
2120	654	Запись (w)	t
2121	654	Выполнение (x)	t
2122	654	Удаление (d)	f
2123	654	Создание (c)	f
2124	655	ps	t
2125	655	top	t
2126	655	htop	t
2127	655	kill	t
2128	655	pkill	t
2129	655	ls	f
2130	655	cd	f
2131	656	SIGTERM	t
2132	656	SIGKILL	t
2133	656	SIGHUP	t
2134	656	SIGSTOP	f
2135	656	SIGCONT	f
2136	657	iptables	t
2137	657	ufw	t
2138	657	firewalld	t
2139	657	selinux	f
2140	657	apparmor	f
2141	658	ping	t
2142	658	traceroute	t
2143	658	nslookup	t
2144	658	dig	t
2145	658	curl	t
2146	658	wget	t
2147	658	ifconfig	f
2148	658	ip	f
2149	659	useradd	t
2150	659	usermod	t
2151	659	userdel	t
2152	659	passwd	t
2153	659	chmod	f
2154	659	chown	f
2155	660	/var/log/syslog	t
2156	660	/var/log/auth.log	t
2157	660	/var/log/kern.log	t
2158	660	/var/log/nginx	f
2159	660	/var/log/apache2	f
2160	661	tar	t
2161	661	gzip	t
2162	661	bzip2	t
2163	661	xz	t
2164	661	zip	t
2165	661	cp	f
2166	661	mv	f
2167	662	chmod	t
2168	662	chown	t
2169	662	chgrp	t
2170	662	passwd	f
2171	662	useradd	f
2172	663	systemctl start	t
2173	663	systemctl stop	t
2174	663	systemctl restart	t
2175	663	systemctl status	t
2176	663	systemctl enable	t
2177	663	systemctl disable	t
2178	663	service	f
2179	663	init	f
2180	664	Символическая ссылка	t
2181	664	Жесткая ссылка	t
2182	664	Мягкая ссылка	f
2183	664	Твердая ссылка	f
2184	665	ps -u	t
2185	665	top -u	t
2186	665	htop -u	t
2187	665	ps -p	f
2188	665	top -p	f
2189	666	nice	t
2190	666	renice	t
2191	666	kill	f
2192	666	pkill	f
2193	667	ip	t
2194	667	ifconfig	t
2195	667	ip link	t
2196	667	ip addr	t
2197	667	route	f
2198	667	netstat	f
2199	668	ss	t
2200	668	netstat	t
2201	668	lsof -i	t
2202	668	ip	f
2203	668	ifconfig	f
2204	669	crontab -e	t
2205	669	crontab -l	t
2206	669	crontab -r	t
2207	669	cron -e	f
2208	669	cron -l	f
2209	670	ssh	t
2210	670	ssh-keygen	t
2211	670	ssh-copy-id	t
2212	670	scp	f
2213	670	sftp	f
2214	671	Обычный файл	t
2215	671	Каталог	t
2216	671	Символьная ссылка	t
2217	671	Блочное устройство	t
2218	671	Символьное устройство	t
2219	671	Сокет	t
2220	671	Pipe	t
2221	671	Жесткая ссылка	f
2222	672	md5sum	t
2223	672	sha256sum	t
2224	672	sha512sum	t
2225	672	sha1sum	t
2226	672	checksum	f
2227	672	hash	f
2228	673	SELinux	t
2229	673	AppArmor	t
2230	673	Tomoyo	t
2231	673	Systemd	f
2232	673	Cron	f
2233	674	apt update	t
2234	674	apt install	t
2235	674	apt remove	t
2236	674	add-apt-repository	t
2237	674	apt upgrade	t
2238	674	apt search	t
2239	674	dnf	f
2240	674	yum	f
2241	675	Bash	t
2242	675	Zsh	t
2243	675	Fish	t
2244	675	Sh	t
2245	675	Ksh	t
2246	675	Python	f
2247	675	Perl	f
2248	676	Линус Торвальдс	t
2249	677	Bash	t
2250	678	cd	t
2251	679	ls	t
2252	680	mkdir	t
2253	681	rm	t
2254	682	cp	t
2255	683	mv	t
2256	684	find	t
2257	685	grep	t
2258	686	df	t
2259	687	chmod	t
2260	688	chown	t
2261	689	root	t
2262	690	systemd	t
2263	691	cron	t
2264	692	SSH	t
2265	693	systemctl	t
2266	694	journalctl	t
2267	695	APT	t
2268	696	DNF	t
2269	697	SELinux	t
2270	698	AppArmor	t
2271	699	/etc/passwd	t
2272	700	/etc/shadow	t
2273	701	Да	t
2274	701	Нет	f
2275	702	Да	t
2276	702	Нет	f
2277	703	Да	t
2278	703	Нет	f
2279	704	Да	f
2280	704	Нет	t
2281	705	Да	f
2282	705	Нет	t
2283	706	Да	t
2284	706	Нет	f
2285	707	Да	t
2286	707	Нет	f
2287	708	Да	f
2288	708	Нет	t
2289	709	Да	f
2290	709	Нет	t
2291	710	Да	t
2292	710	Нет	f
2293	711	Да	f
2294	711	Нет	t
2295	712	Да	f
2296	712	Нет	t
2297	713	Да	f
2298	713	Нет	t
2299	714	Да	f
2300	714	Нет	t
2301	715	Да	f
2302	715	Нет	t
2303	716	Да	f
2304	716	Нет	t
2305	717	Да	f
2306	717	Нет	t
2307	718	Да	f
2308	718	Нет	t
2309	719	Да	f
2310	719	Нет	t
2311	720	Да	t
2312	720	Нет	f
2313	721	Да	f
2314	721	Нет	t
2315	722	Да	f
2316	722	Нет	t
2317	723	Да	t
2318	723	Нет	f
2319	724	Да	f
2320	724	Нет	t
2321	725	Да	f
2322	725	Нет	t
2323	726	Процесс проверки ПО на соответствие требованиям	t
2324	726	Написание кода	f
2325	726	Разработка архитектуры	f
2326	726	Внедрение системы	f
2327	727	Обнаружение дефектов, проверка соответствия, оценка качества	t
2328	727	Только обнаружение дефектов	f
2329	727	Только проверка соответствия	f
2330	727	Только оценка качества	f
2331	728	Проверка соответствия продукта спецификациям	t
2332	728	Проверка в реальных условиях	f
2333	728	Тестирование с пользователями	f
2334	728	Оценка удовлетворенности	f
2335	729	Проверка удовлетворения потребностей пользователя	t
2336	729	Проверка кода на ошибки	f
2337	729	Тестирование модулей	f
2338	729	Анализ производительности	f
2339	730	Несоответствие фактического результата ожидаемому	t
2340	730	Ошибка человека	f
2341	730	Отказ системы	f
2342	730	Сбой оборудования	f
2343	731	Модульное, интеграционное, системное, приемочное	t
2344	731	Только модульное и системное	f
2345	731	Только интеграционное и приемочное	f
2346	731	Только модульное	f
2347	732	Тестирование отдельных компонентов в изоляции	t
2348	732	Тестирование всей системы	f
2349	732	Тестирование интерфейсов	f
2350	732	Тестирование с пользователями	f
2351	733	Тестирование взаимодействия между модулями	t
2352	733	Тестирование отдельных модулей	f
2353	733	Тестирование всей системы	f
2354	733	Тестирование с пользователями	f
2355	734	Тестирование полностью интегрированной системы	t
2356	734	Тестирование отдельных модулей	f
2357	734	Тестирование взаимодействия	f
2358	734	Тестирование пользовательского интерфейса	f
2359	735	Тестирование готовности системы к передаче заказчику	t
2360	735	Тестирование отдельных модулей	f
2361	735	Тестирование взаимодействия	f
2362	735	Тестирование производительности	f
2363	736	Проверка, что изменения не нарушили существующую функциональность	t
2364	736	Тестирование новых функций	f
2365	736	Первое тестирование	f
2366	736	Тестирование производительности	f
2367	737	Базовая проверка критической функциональности	t
2368	737	Детальное тестирование	f
2369	737	Тестирование безопасности	f
2370	737	Тестирование производительности	f
2371	738	Набор условий, шагов и ожидаемых результатов	t
2372	738	Список проверяемых пунктов	f
2373	738	Отчет о дефектах	f
2374	738	План тестирования	f
2375	739	Документ с описанием дефекта	t
2376	739	План тестирования	f
2377	739	Тест-кейс	f
2378	739	Отчет о тестировании	f
2379	740	Мера покрытия кода или требований тестами	t
2380	740	Процент прохождения тестов	f
2381	740	Количество дефектов	f
2382	740	Время выполнения тестов	f
2383	741	Использование инструментов для автоматического выполнения тестов	t
2384	741	Ручное тестирование	f
2385	741	Написание тест-кейсов	f
2386	741	Планирование тестирования	f
2387	742	Фреймворк для автоматизации веб-приложений	t
2388	742	Фреймворк для модульного тестирования	f
2389	742	База данных	f
2390	742	Язык программирования	f
2391	743	Фреймворк для модульного тестирования Java	t
2392	743	Фреймворк для Python	f
2393	743	Фреймворк для веб-автоматизации	f
2394	743	Инструмент для нагрузочного тестирования	f
2395	744	Практика автоматической сборки, тестирования и развертывания	t
2396	744	Только сборка	f
2397	744	Только тестирование	f
2398	744	Только развертывание	f
2399	745	Разработка через тестирование (сначала тест, потом код)	t
2400	745	Разработка через поведение	f
2401	745	Разработка без тестов	f
2402	745	Разработка через приемочные тесты	f
2403	746	Разработка через поведение с Given-When-Then сценариями	t
2404	746	Разработка через тестирование	f
2405	746	Разработка через приемочные тесты	f
2406	746	Разработка без тестов	f
2407	747	Тестирование поведения системы под нагрузкой	t
2408	747	Тестирование функциональности	f
2409	747	Тестирование интерфейса	f
2410	747	Тестирование безопасности	f
2411	748	Тестирование за пределами нормальной нагрузки	t
2412	748	Тестирование с обычной нагрузкой	f
2413	748	Тестирование функциональности	f
2414	748	Тестирование интерфейса	f
2415	749	Тестирование интерфейсов программного взаимодействия	t
2416	749	Тестирование пользовательского интерфейса	f
2417	749	Тестирование базы данных	f
2418	749	Тестирование производительности	f
2419	750	Степень удовлетворения требованиям и ожиданиям	t
2420	750	Отсутствие дефектов	f
2421	750	Быстрое выполнение	f
2422	750	Красивый интерфейс	f
2423	751	Модульное	t
2424	751	Интеграционное	t
2425	751	Системное	t
2426	751	Приемочное	t
2427	751	Автоматическое	f
2428	751	Ручное	f
2429	752	Белый ящик	t
2430	752	Черный ящик	t
2431	752	Серый ящик	t
2432	752	Зеленый ящик	f
2433	752	Красный ящик	f
2434	753	Эквивалентное разбиение	t
2435	753	Анализ граничных значений	t
2436	753	Таблицы решений	t
2437	753	Попарное тестирование	t
2438	753	Монте-Карло	f
2439	753	Метод наименьших квадратов	f
2440	754	ID	t
2441	754	Название	t
2442	754	Предусловия	t
2443	754	Шаги	t
2444	754	Ожидаемый результат	t
2445	754	Приоритет	t
2446	754	Цена	f
2447	754	Вес	f
2448	755	ID	t
2449	755	Заголовок	t
2450	755	Приоритет	t
2451	755	Серьезность	t
2452	755	Шаги воспроизведения	t
2453	755	Фактический/ожидаемый результат	t
2454	755	Цена	f
2455	755	Вес	f
2456	756	New	t
2457	756	Assigned	t
2458	756	Open	t
2459	756	Fixed	t
2460	756	Retest	t
2461	756	Verified	t
2462	756	Closed	t
2463	756	Canceled	f
2464	756	Deleted	f
2465	757	Плотность дефектов	t
2466	757	Эффективность	t
2467	757	Процент прохождения	t
2468	757	Покрытие кода	t
2469	757	Количество строк	f
2470	757	Цена	f
2471	758	Скорость	t
2472	758	Повторяемость	t
2473	758	Уменьшение человеческого фактора	t
2474	758	Высокая цена	f
2475	758	Сложность поддержки	f
2476	759	Высокие затраты на разработку	t
2477	759	Поддержка	t
2478	759	Не все тесты автоматизируемы	t
2479	759	Нет недостатков	f
2480	759	Только скорость	f
2481	760	Selenium	t
2482	760	JUnit	t
2483	760	PyTest	t
2484	760	TestNG	t
2485	760	Django	f
2486	760	Flask	f
2487	761	Page Object Model	t
2488	761	Factory	t
2489	761	Singleton	t
2490	761	MVC	f
2491	761	MVVM	f
2492	762	Нагрузочное	t
2493	762	Стресс-тестирование	t
2494	762	Объемное	t
2495	762	Тестирование стабильности	t
2496	762	Функциональное	f
2497	762	Модульное	f
2498	763	TDD	t
2499	763	BDD	t
2500	763	ATDD	t
2501	763	Waterfall	t
2502	763	Agile	t
2503	763	Scrum	f
2504	763	Kanban	f
2505	764	TestRail	t
2506	764	Zephyr	t
2507	764	PractiTest	t
2508	764	Xray	t
2509	764	qTest	t
2510	764	Jira	f
2511	764	Confluence	f
2512	765	Jira	t
2513	765	Bugzilla	t
2514	765	Mantis	t
2515	765	Redmine	t
2516	765	Confluence	f
2517	765	SharePoint	f
2518	766	Функциональность	t
2519	766	Надежность	t
2520	766	Удобство	t
2521	766	Эффективность	t
2522	766	Сопровождаемость	t
2523	766	Скорость	f
2524	766	Цена	f
2525	767	Ревью кода	t
2526	767	Инспекции	t
2527	767	Статический анализ инструментами	t
2528	767	Модульное тестирование	f
2529	767	Интеграционное тестирование	f
2530	768	Модульное	t
2531	768	Интеграционное	t
2532	768	Системное	t
2533	768	Приемочное	t
2534	768	Статическое	f
2535	768	Ревью	f
2536	769	Статическое	t
2537	769	Динамическое	t
2538	769	Автоматическое	f
2539	769	Ручное	f
2540	770	Обнаружение	t
2541	770	Регистрация	t
2542	770	Назначение	t
2543	770	Исправление	t
2544	770	Проверка	t
2545	770	Закрытие	t
2546	770	Удаление	f
2547	770	Архивация	f
2548	771	Частота запуска	t
2549	771	Повторяемость	t
2550	771	Объем данных	t
2551	771	Критичность	t
2552	771	Цена	f
2553	771	Цвет	f
2554	772	Валидные	t
2555	772	Невалидные	t
2556	772	Граничные	t
2557	772	Случайные	t
2558	772	Только валидные	f
2559	772	Только невалидные	f
2560	773	Аппаратное обеспечение	t
2561	773	ПО	t
2562	773	Сеть	t
2563	773	Тестовые данные	t
2564	773	Только ПО	f
2565	773	Только данные	f
2566	774	Покрытие строк	t
2567	774	Покрытие ветвей	t
2568	774	Покрытие функций	t
2569	774	Покрытие всех возможных путей	f
2570	774	Покрытие всех условий	f
2571	775	Альфа-тестирование	t
2572	775	Бета-тестирование	t
2573	775	UAT (User Acceptance Testing)	t
2574	775	Приемочное тестирование	t
2575	775	Модульное	f
2576	775	Интеграционное	f
2577	776	тестирование	t
2578	777	верификация	t
2579	778	валидация	t
2580	779	дефект	t
2581	780	модульное	t
2582	781	интеграционное	t
2583	782	системное	t
2584	783	приемочное	t
2585	784	белый ящик	t
2586	785	черный ящик	t
2587	786	эквивалентное разбиение	t
2588	787	тест-кейс	t
2589	788	баг-репорт	t
2590	789	регрессионное	t
2591	790	смоук	t
2592	791	Selenium	t
2593	792	JUnit	t
2594	793	CI/CD	t
2595	794	TDD	t
2596	795	BDD	t
2597	796	Page Object	t
2598	797	баг-трекинг	t
2599	798	плотность дефектов	t
2600	799	ревью	t
2601	800	API	t
2602	801	Да	t
2603	801	Нет	f
2604	802	Да	f
2605	802	Нет	t
2606	803	Да	t
2607	803	Нет	f
2608	804	Да	f
2609	804	Нет	t
2610	805	Да	t
2611	805	Нет	f
2612	806	Да	t
2613	806	Нет	f
2614	807	Да	t
2615	807	Нет	f
2616	808	Да	t
2617	808	Нет	f
2618	809	Да	t
2619	809	Нет	f
2620	810	Да	f
2621	810	Нет	t
2622	811	Да	f
2623	811	Нет	t
2624	812	Да	f
2625	812	Нет	t
2626	813	Да	f
2627	813	Нет	t
2628	814	Да	f
2629	814	Нет	t
2630	815	Да	t
2631	815	Нет	f
2632	816	Да	f
2633	816	Нет	t
2634	817	Да	f
2635	817	Нет	t
2636	818	Да	t
2637	818	Нет	f
2638	819	Да	t
2639	819	Нет	f
2640	820	Да	f
2641	820	Нет	t
2642	821	Да	t
2643	821	Нет	f
2644	822	Да	t
2645	822	Нет	f
2646	823	Да	f
2647	823	Нет	t
2648	824	Да	t
2649	824	Нет	f
2650	825	Да	t
2651	825	Нет	f
2652	826	Управление, настройка и обслуживание серверов	t
2653	826	Только установка серверов	f
2654	826	Только мониторинг серверов	f
2655	826	Только резервное копирование	f
2656	827	Установка ПО, мониторинг, безопасность, резервное копирование, управление пользователями	t
2657	827	Только мониторинг	f
2658	827	Только безопасность	f
2659	827	Только резервное копирование	f
2660	828	Компьютер или программа, предоставляющая ресурсы и услуги	t
2661	828	Только компьютер	f
2662	828	Только программа	f
2663	828	Сетевое оборудование	f
2664	829	Управление через сеть без физического доступа	t
2665	829	Управление с физическим доступом	f
2666	829	Управление только через консоль	f
2667	829	Управление через USB	f
2668	830	SSH, RDP, VNC, IPMI, iDRAC, iLO	t
2669	830	Только SSH	f
2670	830	Только RDP	f
2671	830	Только VNC	f
2672	831	Пара ключей для безопасного доступа без пароля	t
2673	831	Пароль для SSH	f
2674	831	Логин для SSH	f
2675	831	Сертификат SSH	f
2676	832	ПО для отслеживания состояния серверов и сервисов	t
2677	832	ПО для установки серверов	f
2678	832	ПО для резервного копирования	f
2679	832	ПО для безопасности	f
2680	833	Создание копий данных для восстановления	t
2681	833	Удаление данных	f
2682	833	Сжатие данных	f
2683	833	Шифрование данных	f
2684	834	Полное, инкрементное, дифференциальное	t
2685	834	Только полное	f
2686	834	Только инкрементное	f
2687	834	Только дифференциальное	f
2688	835	3 копии, 2 носителя, 1 вне офиса	t
2689	835	3 копии, 2 сервера, 1 год	f
2690	835	3 бэкапа, 2 дня, 1 неделя	f
2691	835	3 пользователя, 2 пароля, 1 сервер	f
2692	836	Объединение серверов для отказоустойчивости	t
2693	836	Разделение серверов	f
2694	836	Удаление серверов	f
2695	836	Замена серверов	f
2696	837	Распределение нагрузки между серверами	t
2697	837	Сбор нагрузки на один сервер	f
2698	837	Удаление нагрузки	f
2699	837	Игнорирование нагрузки	f
2700	838	Соглашение об уровне обслуживания	t
2701	838	Сервисный уровень администратора	f
2702	838	Системный логический анализатор	f
2703	838	Стандартный локальный агент	f
2704	839	useradd или adduser	t
2705	839	Только useradd	f
2706	839	Только adduser	f
2707	839	newuser	f
2708	840	userdel или deluser	t
2709	840	Только userdel	f
2710	840	Только deluser	f
2711	840	deleteuser	f
2712	841	passwd	t
2713	841	changepass	f
2714	841	password	f
2715	841	setpass	f
2716	842	Добавить в группу sudo или настроить /etc/sudoers	t
2717	842	Только добавить в группу sudo	f
2718	842	Только настроить /etc/sudoers	f
2719	842	Изменить права на файлы	f
2720	843	Служба каталогов Microsoft для управления пользователями	t
2721	843	База данных SQL	f
2722	843	Веб-сервер	f
2723	843	Почтовый сервер	f
2724	844	Протокол для доступа к службам каталогов	t
2725	844	Язык программирования	f
2726	844	База данных	f
2727	844	Операционная система	f
2728	845	Список контроля доступа для детальных прав	t
2729	845	Активный список пользователей	f
2730	845	Автоматический список контроля	f
2731	845	Альтернативный список доступа	f
2732	846	Установить и настроить в /etc/nginx/sites-available/	t
2733	846	Только установить nginx	f
2734	846	Только настроить конфиг	f
2735	846	nginx install	f
2736	847	Установить и настроить в /etc/apache2/sites-available/	t
2737	847	Только установить apache2	f
2738	847	Только настроить конфиг	f
2739	847	apache install	f
2740	848	Сервер, перенаправляющий запросы к внутренним серверам	t
2741	848	Сервер, принимающий запросы от внутренних серверов	f
2742	848	Сервер для кэширования	f
2743	848	Сервер для балансировки	f
2744	849	Система фильтрации сетевого трафика	t
2745	849	Антивирус	f
2746	849	Антиспам	f
2747	849	Сборщик логов	f
2748	850	Управление инфраструктурой через файлы конфигурации	t
2749	850	Ручное управление	f
2750	850	Управление через GUI	f
2751	850	Управление через консоль	f
2752	851	SSH	t
2753	851	RDP	t
2754	851	VNC	t
2755	851	IPMI	t
2756	851	iDRAC	t
2757	851	iLO	t
2758	851	Telnet	t
2759	851	HTTP	f
2760	851	FTP	f
2761	852	Nagios	t
2762	852	Zabbix	t
2763	852	Prometheus	t
2764	852	Grafana	t
2765	852	Datadog	t
2766	852	New Relic	t
2767	852	Apache	f
2768	852	Nginx	f
2769	853	Полное	t
2770	853	Инкрементное	t
2771	853	Дифференциальное	t
2772	853	Синтетическое	t
2773	853	Частичное	f
2774	853	Выборочное	f
2775	854	rsync	t
2776	854	Bacula	t
2777	854	Amanda	t
2778	854	Veeam	t
2779	854	Duplicity	t
2780	854	Restic	t
2781	854	BorgBackup	t
2782	854	tar	f
2783	854	zip	f
2784	855	Round-robin	t
2785	855	Least connections	t
2786	855	IP hash	t
2787	855	Weighted	t
2788	855	Random	t
2789	855	First come	f
2790	855	Last come	f
2791	856	/etc/passwd	t
2792	856	/etc/shadow	t
2793	856	/etc/group	t
2794	856	/etc/gshadow	t
2795	856	/etc/hosts	f
2796	856	/etc/resolv.conf	f
2797	857	Ansible	t
2798	857	Puppet	t
2799	857	Chef	t
2800	857	SaltStack	t
2801	857	Terraform	t
2802	857	Docker	f
2803	857	Kubernetes	f
2804	858	Kubernetes	t
2805	858	Docker Swarm	t
2806	858	Nomad	t
2807	858	Docker	f
2808	858	Podman	f
2809	859	Snort	t
2810	859	Suricata	t
2811	859	OSSEC	t
2812	859	Wazuh	t
2813	859	Fail2ban	t
2814	859	ClamAV	f
2815	859	SELinux	f
2816	860	top	t
2817	860	htop	t
2818	860	mpstat	t
2819	860	vmstat	t
2820	860	uptime	t
2821	860	free	f
2822	860	df	f
2823	861	free	t
2824	861	vmstat	t
2825	861	top	t
2826	861	htop	t
2827	861	/proc/meminfo	t
2828	861	df	f
2829	861	du	f
2830	862	df	t
2831	862	du	t
2832	862	iostat	t
2833	862	iotop	t
2834	862	dstat	t
2835	862	free	f
2836	862	top	f
2837	863	iftop	t
2838	863	nethogs	t
2839	863	vnstat	t
2840	863	iperf	t
2841	863	tcpdump	t
2842	863	top	f
2843	863	htop	f
2844	864	ufw	t
2845	864	firewalld	t
2846	864	iptables	t
2847	864	nftables	t
2848	864	selinux	f
2849	864	apparmor	f
2850	865	SELinux	t
2851	865	AppArmor	t
2852	865	Tomoyo	t
2853	865	Systemd	f
2854	865	Cron	f
2855	866	/etc/login.defs	t
2856	866	pam_pwquality	t
2857	866	chage	t
2858	866	passwd	t
2859	866	sudo	f
2860	866	visudo	f
2861	867	Веб-серверы	t
2862	867	Файловые серверы	t
2863	867	Почтовые серверы	t
2864	867	DNS-серверы	t
2865	867	Серверы БД	t
2866	867	Прокси-серверы	t
2867	867	Принтерные	f
2868	867	Сканерные	f
2869	868	Jenkins	t
2870	868	GitLab CI	t
2871	868	GitHub Actions	t
2872	868	Travis CI	t
2873	868	CircleCI	t
2874	868	Ansible	f
2875	868	Terraform	f
2876	869	mdadm	t
2877	869	LVM	t
2878	869	fdisk	t
2879	869	parted	t
2880	869	lsblk	t
2881	869	df	f
2882	869	du	f
2883	870	FTP	t
2884	870	SFTP	t
2885	870	SCP	t
2886	870	RSync	t
2887	870	NFS	t
2888	870	SMB/CIFS	t
2889	870	HTTP	f
2890	870	HTTPS	f
2891	871	Сбор метрик	t
2892	871	Визуализация	t
2893	871	Оповещения	t
2894	871	Анализ логов	t
2895	871	Бэкап	f
2896	871	Шифрование	f
2897	872	CDN	t
2898	872	Rate limiting	t
2899	872	WAF	t
2900	872	Ограничения по IP	t
2901	872	Антивирус	f
2902	872	Брандмауэр	f
2903	873	Domain Validation	t
2904	873	Organization Validation	t
2905	873	Extended Validation	t
2906	873	Wildcard	t
2907	873	Self-signed	f
2908	873	Internal	f
2909	874	Ceph	t
2910	874	GlusterFS	t
2911	874	HDFS	t
2912	874	MooseFS	t
2913	874	NFS	f
2914	874	SMB	f
2915	875	Docker	t
2916	875	Podman	t
2917	875	containerd	t
2918	875	CRI-O	t
2919	875	Kubernetes	f
2920	875	Swarm	f
2921	876	SSH	t
2922	877	RDP	t
2923	878	SSH-ключи	t
2924	879	Grafana	t
2925	880	Grafana	t
2926	881	3-2-1	t
2927	882	кластеризация	t
2928	883	балансировка	t
2929	884	SLA	t
2930	885	useradd	t
2931	886	passwd	t
2932	887	chown	t
2933	888	chmod	t
2934	889	usermod	t
2935	890	Active Directory	t
2936	891	LDAP	t
2937	892	ACL	t
2938	893	SELinux	t
2939	894	AppArmor	t
2940	895	Fail2ban	t
2941	896	Ansible	t
2942	897	Terraform	t
2943	898	Kubernetes	t
2944	899	GitOps	t
2945	900	mdadm	t
2946	901	Да	t
2947	901	Нет	f
2948	902	Да	t
2949	902	Нет	f
2950	903	Да	f
2951	903	Нет	t
2952	904	Да	t
2953	904	Нет	f
2954	905	Да	t
2955	905	Нет	f
2956	906	Да	t
2957	906	Нет	f
2958	907	Да	f
2959	907	Нет	t
2960	908	Да	f
2961	908	Нет	t
2962	909	Да	f
2963	909	Нет	t
2964	910	Да	f
2965	910	Нет	t
2966	911	Да	t
2967	911	Нет	f
2968	912	Да	t
2969	912	Нет	f
2970	913	Да	f
2971	913	Нет	t
2972	914	Да	t
2973	914	Нет	f
2974	915	Да	t
2975	915	Нет	f
2976	916	Да	f
2977	916	Нет	t
2978	917	Да	t
2979	917	Нет	f
2980	918	Да	t
2981	918	Нет	f
2982	919	Да	t
2983	919	Нет	f
2984	920	Да	t
2985	920	Нет	f
2986	921	Да	t
2987	921	Нет	f
2988	922	Да	t
2989	922	Нет	f
2990	923	Да	t
2991	923	Нет	f
2992	924	Да	t
2993	924	Нет	f
2994	925	Да	t
2995	925	Нет	f
2996	926	Скриптовый язык для веб-приложений	t
2997	926	Язык разметки	f
2998	926	База данных	f
2999	926	Операционная система	f
3000	927	Расмус Лердорф	t
3001	927	Линус Торвальдс	f
3002	927	Бьёрн Страуструп	f
3003	927	Джеймс Гослинг	f
3004	928	FastCGI Process Manager для PHP	t
3005	928	Фреймворк для PHP	f
3006	928	База данных для PHP	f
3007	928	Система кэширования PHP	f
3008	929	$_GET, $_POST, $_REQUEST, $_SESSION, $_COOKIE, $_SERVER, $_FILES, $_ENV, $GLOBALS	t
3009	929	Только $_GET и $_POST	f
3010	929	Только $_SESSION и $_COOKIE	f
3011	929	Только $_SERVER	f
3012	930	echo не возвращает, print возвращает 1	t
3013	930	print не возвращает, echo возвращает	f
3014	930	Разницы нет	f
3015	930	Оба возвращают значение	f
3016	931	Неизменяемое значение во время выполнения	t
3017	931	Изменяемая переменная	f
3018	931	Массив	f
3019	931	Функция	f
3020	932	define() во время выполнения, const во время компиляции	t
3021	932	const во время выполнения, define() во время компиляции	f
3022	932	Разницы нет	f
3023	932	Оба во время выполнения	f
3024	933	== с приведением, === строгое без приведения	t
3025	933	=== с приведением, == строгое	f
3026	933	Разницы нет	f
3027	933	Оба с приведением	f
3028	934	Возвращает -1, 0 или 1 при сравнении	t
3029	934	Сравнивает как строки	f
3159	956	array_push	f
3030	934	Сравнивает как числа	f
3031	934	Возвращает true или false	f
3032	935	function name($param) { }	t
3033	935	func name($param) { }	f
3034	935	def name($param) { }	f
3035	935	create name($param) { }	f
3036	936	Функция без имени	t
3037	936	Именованная функция	f
3038	936	Глобальная функция	f
3039	936	Статическая функция	f
3040	937	Короткий синтаксис fn() => expr	t
3041	937	Обычная функция	f
3042	937	Анонимная функция	f
3043	937	Рекурсивная функция	f
3044	938	Анонимная функция с захватом переменных через use()	t
3045	938	Глобальная функция	f
3046	938	Статическая функция	f
3047	938	Встроенная функция	f
3048	939	Шаблон для создания объектов	t
3049	939	Функция	f
3050	939	Массив	f
3051	939	Строка	f
3052	940	public, protected, private	t
3053	940	Только public	f
3054	940	Только protected	f
3055	940	Только private	f
3056	941	Наследование через extends	t
3057	941	Копирование класса	f
3058	941	Удаление класса	f
3059	941	Переименование класса	f
3060	942	Контракт с методами для реализации	t
3061	942	Класс с реализацией	f
3062	942	Трейт	f
3063	942	Абстрактный класс	f
3064	943	Класс, который не может быть инстанциирован	t
3065	943	Класс, который всегда инстанциируется	f
3066	943	Обычный класс	f
3067	943	Интерфейс	f
3068	944	Механизм обработки ошибок через try/catch/throw	t
3069	944	Простая обработка ошибок	f
3070	944	Только логирование	f
3071	944	Игнорирование ошибок	f
3072	945	Запросы с плейсхолдерами, защита от SQL-инъекций	t
3073	945	Обычные запросы	f
3074	945	Запросы без параметров	f
3075	945	Запросы с жестко заданными значениями	f
3076	946	Сохранение данных между запросами через $_SESSION	t
3077	946	Сохранение в базе данных	f
3078	946	Сохранение в файлах	f
3079	946	Сохранение в куках	f
3080	947	Менеджер зависимостей для PHP	t
3081	947	Фреймворк	f
3082	947	База данных	f
3083	947	Веб-сервер	f
3084	948	Механизм организации кода (namespace)	t
3085	948	Тип данных	f
3086	948	Функция	f
3087	948	Класс	f
3088	949	Механизм для повторного использования кода в классах	t
3089	949	Тип данных	f
3090	949	Функция	f
3091	949	Класс	f
3092	950	Функции с yield для ленивой итерации	t
3093	950	Обычные функции	f
3094	950	Классы	f
3095	950	Массивы	f
3096	951	int	t
3097	951	float	t
3098	951	string	t
3099	951	bool	t
3100	951	array	t
3101	951	object	t
3102	951	null	t
3103	951	resource	t
3104	951	callable	t
3105	951	class	f
3106	951	function	f
3107	952	$_GET	t
3108	952	$_POST	t
3109	952	$_REQUEST	t
3110	952	$_SESSION	t
3111	952	$_COOKIE	t
3112	952	$_SERVER	t
3113	952	$_FILES	t
3114	952	$_ENV	t
3115	952	$GLOBALS	t
3116	952	$_PUT	f
3117	952	$_DELETE	f
3118	953	==	t
3119	953	===	t
3120	953	!=	t
3121	953	!==	t
3122	953	<	t
3123	953	>	t
3124	953	<=	t
3125	953	>=	t
3126	953	<=>	t
3127	953	=	f
3128	953	===	f
3129	954	__LINE__	t
3130	954	__FILE__	t
3131	954	__DIR__	t
3132	954	__FUNCTION__	t
3133	954	__CLASS__	t
3134	954	__METHOD__	t
3135	954	__NAMESPACE__	t
3136	954	__TRAIT__	t
3137	954	__VERSION__	f
3138	954	__DATE__	f
3139	955	strlen	t
3140	955	strpos	t
3141	955	substr	t
3142	955	str_replace	t
3143	955	strtolower	t
3144	955	strtoupper	t
3145	955	trim	t
3146	955	explode	t
3147	955	implode	t
3148	955	join	t
3149	955	array_push	f
3150	955	array_pop	f
3151	956	array_merge	t
3152	956	array_keys	t
3153	956	array_values	t
3154	956	in_array	t
3155	956	array_search	t
3156	956	array_map	t
3157	956	array_filter	t
3158	956	array_reduce	t
3160	956	array_pop	f
3161	957	public	t
3162	957	protected	t
3163	957	private	t
3164	957	internal	f
3165	957	static	f
3166	957	final	f
3167	958	array()	t
3168	958	[]	t
3169	958	list()	f
3170	958	new Array()	f
3171	959	try-catch	t
3172	959	set_error_handler	t
3173	959	error_log	t
3174	959	throw	t
3175	959	finally	t
3176	959	assert	t
3177	959	try-catch-finally	t
3178	960	mysqli	t
3179	960	PDO_MySQL	t
3180	960	mysql	f
3181	960	MySQLi	t
3182	961	r	t
3183	961	w	t
3184	961	a	t
3185	961	r+	t
3186	961	w+	t
3187	961	a+	t
3188	961	x	f
3189	961	x+	f
3190	962	echo	t
3191	962	print	t
3192	962	print_r	t
3193	962	var_dump	t
3194	962	printf	f
3195	962	sprintf	f
3196	963	session_start	t
3197	963	$_SESSION	t
3198	963	session_destroy	t
3199	963	session_unset	t
3200	963	session_write_close	t
3201	963	session_begin	f
3202	964	setcookie	t
3203	964	$_COOKIE	t
3204	964	cookie_set	f
3205	964	cookie_get	f
3206	965	Exception	t
3207	965	RuntimeException	t
3208	965	InvalidArgumentException	t
3209	965	TypeError	t
3210	965	ValueError	t
3211	965	Error	t
3212	965	Throwable	t
3213	965	FatalException	f
3214	965	WarningException	f
3215	966	fopen	t
3216	966	fread	t
3217	966	fwrite	t
3218	966	fclose	t
3219	966	file_get_contents	t
3220	966	file_put_contents	t
3221	966	fgets	t
3222	966	fgetc	t
3223	966	readfile	t
3224	966	file	t
3225	967	password_hash	t
3226	967	password_verify	t
3227	967	md5	f
3228	967	sha1	f
3229	967	hash	f
3230	968	PSR-1	t
3231	968	PSR-4	t
3232	968	PSR-7	t
3233	968	PSR-12	t
3234	968	PSR-2	t
3235	968	PSR-3	t
3236	968	PSR-6	t
3237	968	PSR-11	t
3238	968	PSR-15	t
3239	968	PSR-18	t
3240	969	Атрибуты	t
3241	969	match	t
3242	969	union types	t
3243	969	named arguments	t
3244	969	constructor property promotion	t
3245	969	nullsafe оператор	t
3246	969	enum	f
3247	969	readonly	f
3248	970	Enum	t
3249	970	readonly	t
3250	970	Fibers	t
3251	970	Атрибуты	f
3252	970	match	f
3253	970	union types	f
3254	971	define()	t
3255	971	const	t
3256	971	define	t
3257	971	CONST	f
3258	971	constant	f
3259	972	Индексированные	t
3260	972	Ассоциативные	t
3261	972	Многомерные	t
3262	972	Смешанные	t
3263	972	Вложенные	t
3264	972	Одномерные	f
3265	972	Двумерные	f
3266	973	foreach	t
3267	973	for	t
3268	973	while	t
3269	973	array_walk	t
3270	973	array_map	t
3271	973	each	f
3272	973	next	f
3273	974	E_ERROR	t
3274	974	E_WARNING	t
3275	974	E_NOTICE	t
3276	974	E_PARSE	t
3277	974	E_DEPRECATED	t
3278	974	E_STRICT	t
3279	974	E_ALL	t
3280	974	E_FATAL	f
3281	974	E_CRITICAL	f
3282	975	include	t
3283	975	include_once	t
3284	975	require	t
3285	975	require_once	t
3286	975	import	f
3287	975	load	f
3288	976	PHP	t
3289	977	Расмус Лердорф	t
3290	978	PHP-FPM	t
3291	979	$_GET	t
3292	980	$_POST	t
3293	981	$_SESSION	t
3294	982	$_COOKIE	t
3295	983	===	t
3296	984	==	t
3297	985	<=>	t
3298	986	implode	t
3299	987	explode	t
3300	988	password_hash	t
3301	989	password_verify	t
3302	990	Composer	t
3303	991	composer.json	t
3304	992	пространства имен	t
3305	993	class	t
3306	994	__construct	t
3307	995	__destruct	t
3308	996	public	t
3309	997	private	t
3310	998	protected	t
3311	999	try	t
3312	1000	catch	t
3313	1001	Да	t
3314	1001	Нет	f
3315	1002	Да	t
3316	1002	Нет	f
3317	1003	Да	f
3318	1003	Нет	t
3319	1004	Да	f
3320	1004	Нет	t
3321	1005	Да	f
3322	1005	Нет	t
3323	1006	Да	f
3324	1006	Нет	t
3325	1007	Да	f
3326	1007	Нет	t
3327	1008	Да	f
3328	1008	Нет	t
3329	1009	Да	f
3330	1009	Нет	t
3331	1010	Да	t
3332	1010	Нет	f
3333	1011	Да	f
3334	1011	Нет	t
3335	1012	Да	f
3336	1012	Нет	t
3337	1013	Да	t
3338	1013	Нет	f
3339	1014	Да	f
3340	1014	Нет	t
3341	1015	Да	t
3342	1015	Нет	f
3343	1016	Да	f
3344	1016	Нет	t
3345	1017	Да	f
3346	1017	Нет	t
3347	1018	Да	f
3348	1018	Нет	t
3349	1019	Да	t
3350	1019	Нет	f
3351	1020	Да	t
3352	1020	Нет	f
3353	1021	Да	t
3354	1021	Нет	f
3355	1022	Да	t
3356	1022	Нет	f
3357	1023	Да	t
3358	1023	Нет	f
3359	1024	Да	f
3360	1024	Нет	t
3361	1025	Да	t
3362	1025	Нет	f
3363	1026	Объектно-ориентированный язык для JVM	t
3364	1026	Язык разметки	f
3365	1026	База данных	f
3366	1026	Операционная система	f
3367	1027	Джеймс Гослинг	t
3368	1027	Расмус Лердорф	f
3369	1027	Линус Торвальдс	f
3370	1027	Бьёрн Страуструп	f
3371	1028	Виртуальная машина для байт-кода Java	t
3372	1028	Среда разработки	f
3373	1028	База данных	f
3374	1028	Веб-сервер	f
3375	1029	Среда выполнения Java (JVM + библиотеки)	t
3376	1029	Комплект для разработки	f
3377	1029	Только JVM	f
3378	1029	Только библиотеки	f
3379	1030	Комплект для разработки (JRE + компилятор + инструменты)	t
3380	1030	Только JVM	f
3381	1030	Только библиотеки	f
3382	1030	Среда выполнения	f
3383	1031	Промежуточный код для JVM	t
3384	1031	Машинный код	f
3385	1031	Исходный код	f
3386	1031	Скомпилированный код	f
3387	1032	byte, short, int, long, float, double, char, boolean	t
3388	1032	Только int и double	f
3389	1032	Только boolean и char	f
3390	1032	Только long и float	f
3391	1033	public, protected, default, private	t
3392	1033	Только public и private	f
3393	1033	Только protected и default	f
3394	1033	Только public	f
3395	1034	Принадлежит классу, а не экземпляру	t
3396	1034	Принадлежит экземпляру	f
3397	1034	Только для методов	f
3398	1034	Только для полей	f
3399	1035	Неизменяемая переменная, непереопределяемый метод, ненаследуемый класс	t
3400	1035	Только для переменных	f
3401	1035	Только для методов	f
3402	1035	Только для классов	f
3403	1036	Класс не инстанциируется или метод должен быть переопределен	t
3404	1036	Класс инстанциируется	f
3405	1036	Только для методов	f
3406	1036	Только для классов	f
3407	1037	Неизменяемый класс для строк	t
3408	1037	Изменяемый класс	f
3409	1037	Примитивный тип	f
3410	1037	Интерфейс	f
3411	1038	String неизменяемый, StringBuilder несинхронизированный, StringBuffer синхронизированный	t
3412	1038	Все неизменяемые	f
3413	1038	Все изменяемые	f
3414	1038	Разницы нет	f
3415	1039	equals() по содержимому, == по ссылкам	t
3416	1039	== по содержимому, equals() по ссылкам	f
3417	1039	Разницы нет	f
3418	1039	Оба по содержимому	f
3419	1040	Шаблон для создания объектов	t
3420	1040	Тип данных	f
3421	1040	Интерфейс	f
3422	1040	Объект	f
3423	1041	Метод для инициализации объекта	t
3424	1041	Метод для удаления объекта	f
3425	1041	Метод для копирования	f
3426	1041	Метод для сравнения	f
3427	1042	Методы с одинаковым именем, разными параметрами	t
3428	1042	Методы с разными именами	f
3429	1042	Методы с одинаковыми параметрами	f
3430	1042	Методы в разных классах	f
3431	1043	Изменение реализации в подклассе	t
3432	1043	Создание нового метода	f
3433	1043	Удаление метода	f
3434	1043	Копирование метода	f
3435	1044	Наследование полей и методов через extends	t
3436	1044	Копирование класса	f
3437	1044	Удаление класса	f
3438	1044	Переименование класса	f
3439	1045	Контракт с методами для реализации	t
3440	1045	Класс с реализацией	f
3441	1045	Абстрактный класс	f
3442	1045	Трейт	f
3443	1046	Класс, который не может быть инстанциирован	t
3444	1046	Класс, который всегда инстанциируется	f
3445	1046	Интерфейс	f
3446	1046	Обычный класс	f
3447	1047	Фреймворк для хранения групп объектов	t
3448	1047	Тип данных	f
3449	1047	Класс	f
3450	1047	Интерфейс	f
3451	1048	События, нарушающие нормальный поток выполнения	t
3452	1048	Нормальные события	f
3453	1048	Логирование	f
3454	1048	Отладка	f
3455	1049	Поток выполнения (Thread)	t
3456	1049	Stream API	f
3457	1049	File	f
3458	1049	Socket	f
3459	1050	Обобщенные типы для типобезопасности	t
3460	1050	Типы данных	f
3461	1050	Методы	f
3462	1050	Классы	f
3463	1051	byte	t
3464	1051	short	t
3465	1051	int	t
3466	1051	long	t
3467	1051	float	t
3468	1051	double	t
3469	1051	char	t
3470	1051	boolean	t
3471	1051	String	f
3472	1051	Integer	f
3473	1052	public	t
3474	1052	protected	t
3475	1052	default	t
3476	1052	private	t
3477	1052	static	f
3478	1052	final	f
3479	1053	static	t
3480	1053	final	t
3481	1053	abstract	t
3482	1053	synchronized	t
3483	1053	native	t
3484	1053	volatile	t
3485	1053	transient	t
3486	1053	public	f
3487	1053	private	f
3488	1054	String	t
3489	1054	StringBuilder	t
3490	1054	StringBuffer	t
3491	1054	StringWriter	f
3492	1054	StringReader	f
3493	1055	ArrayList	t
3494	1055	LinkedList	t
3495	1055	Vector	t
3496	1055	Stack	t
3497	1055	HashSet	f
3498	1055	TreeSet	f
3499	1056	HashSet	t
3500	1056	TreeSet	t
3501	1056	LinkedHashSet	t
3502	1056	ArrayList	f
3503	1056	LinkedList	f
3504	1057	HashMap	t
3505	1057	TreeMap	t
3506	1057	LinkedHashMap	t
3507	1057	Hashtable	t
3508	1057	ConcurrentHashMap	t
3509	1057	ArrayList	f
3510	1057	HashSet	f
3511	1058	try	t
3512	1058	catch	t
3513	1058	finally	t
3514	1058	throw	t
3515	1058	throws	t
3516	1058	except	f
3517	1058	error	f
3518	1059	FileReader	t
3519	1059	BufferedReader	t
3520	1059	Scanner	t
3521	1059	InputStream	t
3522	1059	FileWriter	f
3523	1059	BufferedWriter	f
3524	1060	FileWriter	t
3525	1060	BufferedWriter	t
3526	1060	PrintWriter	t
3527	1060	OutputStream	t
3528	1060	FileReader	f
3529	1060	BufferedReader	f
3530	1061	toString	t
3531	1061	equals	t
3532	1061	hashCode	t
3533	1061	clone	t
3534	1061	wait	t
3535	1061	notify	t
3536	1061	getClass	t
3537	1061	notifyAll	t
3538	1061	finalize	t
3539	1061	compareTo	f
3540	1061	compare	f
3541	1062	Collection	t
3542	1062	List	t
3543	1062	Set	t
3544	1062	Queue	t
3545	1062	Deque	t
3546	1062	Map	t
3547	1062	Vector	f
3548	1062	ArrayList	f
3549	1063	Наследование Thread	t
3550	1063	Реализация Runnable	t
3551	1063	Реализация Callable	f
3552	1063	ExecutorService	f
3553	1064	start	t
3554	1064	run	t
3555	1064	sleep	t
3556	1064	wait	t
3557	1064	notify	t
3558	1064	join	t
3559	1064	stop	f
3560	1064	suspend	f
3561	1065	filter	t
3562	1065	map	t
3563	1065	reduce	t
3564	1065	forEach	t
3565	1065	collect	t
3566	1065	findFirst	t
3567	1065	anyMatch	t
3568	1065	allMatch	t
3569	1065	noneMatch	t
3570	1065	sort	f
3571	1065	reverse	f
3572	1066	JVM	t
3573	1066	JRE	t
3574	1066	JDK	t
3575	1066	JNI	f
3576	1066	JIT	f
3577	1067	По умолчанию	t
3578	1067	Параметризованный	t
3579	1067	Копирования	t
3580	1067	Статический	f
3581	1067	Финализирующий	f
3582	1068	concat	t
3583	1068	substring	t
3584	1068	replace	t
3585	1068	toLowerCase	t
3586	1068	toUpperCase	t
3587	1068	trim	t
3588	1068	split	t
3589	1068	join	t
3590	1068	append	f
3591	1068	insert	f
3592	1069	synchronized	t
3593	1069	wait	t
3594	1069	notify	t
3595	1069	notifyAll	t
3596	1069	Lock	t
3597	1069	sleep	f
3598	1069	join	f
3599	1070	Лямбда-выражения	t
3600	1070	Stream API	t
3601	1070	Optional	t
3602	1070	Method References	t
3603	1070	Модули	f
3604	1070	Records	f
3605	1071	Модули	t
3606	1071	Collection工廠методы	t
3607	1071	try-with-resources улучшения	t
3608	1071	Лямбда-выражения	f
3609	1071	Stream API	f
3610	1072	HTTP Client	t
3611	1072	local-variable syntax for lambda	t
3612	1072	ZGC	t
3613	1072	Модули	f
3614	1072	Records	f
3615	1073	Records	t
3616	1073	Sealed classes	t
3617	1073	Pattern Matching	t
3618	1073	Switch expressions	t
3619	1073	Лямбда-выражения	f
3620	1073	Stream API	f
3621	1074	File	t
3622	1074	FileReader	t
3623	1074	FileWriter	t
3624	1074	BufferedReader	t
3625	1074	BufferedWriter	t
3626	1074	Path	t
3627	1074	Files	t
3628	1074	FileInputStream	t
3629	1074	FileOutputStream	t
3630	1074	Socket	f
3631	1074	ServerSocket	f
3632	1075	Collections	t
3633	1075	Arrays	t
3634	1075	Collections.sort	t
3635	1075	Collections.shuffle	t
3636	1075	Collections.reverse	t
3637	1075	Collections.binarySearch	t
3638	1075	Collections.max	t
3639	1075	Collections.min	t
3640	1075	Collections.synchronizedList	t
3641	1075	Collections.unmodifiableList	t
3642	1076	Джеймс Гослинг	t
3643	1077	JVM	t
3644	1078	JRE	t
3645	1079	JDK	t
3646	1080	байт-код	t
3647	1081	String	t
3648	1082	StringBuilder	t
3649	1083	StringBuffer	t
3650	1084	public	t
3651	1085	private	t
3652	1086	protected	t
3653	1087	static	t
3654	1088	final	t
3655	1089	abstract	t
3656	1090	Iterator	t
3657	1091	Map	t
3658	1092	ArrayList	t
3659	1093	HashSet	t
3660	1094	HashMap	t
3661	1095	synchronized	t
3662	1096	throw	t
3663	1097	throws	t
3664	1098	Stream API	t
3665	1099	Optional	t
3666	1100	модули	t
3667	1101	Да	t
3668	1101	Нет	f
3669	1102	Да	f
3670	1102	Нет	t
3671	1103	Да	t
3672	1103	Нет	f
3673	1104	Да	f
3674	1104	Нет	t
3675	1105	Да	f
3676	1105	Нет	t
3677	1106	Да	f
3678	1106	Нет	t
3679	1107	Да	f
3680	1107	Нет	t
3681	1108	Да	f
3682	1108	Нет	t
3683	1109	Да	f
3684	1109	Нет	t
3685	1110	Да	f
3686	1110	Нет	t
3687	1111	Да	t
3688	1111	Нет	f
3689	1112	Да	f
3690	1112	Нет	t
3691	1113	Да	f
3692	1113	Нет	t
3693	1114	Да	f
3694	1114	Нет	t
3695	1115	Да	f
3696	1115	Нет	t
3697	1116	Да	t
3698	1116	Нет	f
3699	1117	Да	t
3700	1117	Нет	f
3701	1118	Да	f
3702	1118	Нет	t
3703	1119	Да	t
3704	1119	Нет	f
3705	1120	Да	t
3706	1120	Нет	f
3707	1121	Да	f
3708	1121	Нет	t
3709	1122	Да	t
3710	1122	Нет	f
3711	1123	Да	t
3712	1123	Нет	f
3713	1124	Да	f
3714	1124	Нет	t
3715	1125	Да	t
3716	1125	Нет	f
3717	1126	Компилируемый язык общего назначения, расширение C	t
3718	1126	Интерпретируемый язык	f
3719	1126	Язык разметки	f
3720	1126	База данных	f
3721	1127	Бьёрн Страуструп	t
3722	1127	Джеймс Гослинг	f
3723	1127	Расмус Лердорф	f
3724	1127	Линус Торвальдс	f
3725	1128	ООП, процедурное, обобщенное, функциональное	t
3726	1128	Только ООП	f
3727	1128	Только процедурное	f
3728	1128	Только функциональное	f
3729	1129	Переменная, хранящая адрес памяти	t
3730	1129	Переменная, хранящая значение	f
3731	1129	Ссылка на переменную	f
3732	1129	Тип данных	f
3733	1130	Альтернативное имя для существующей переменной	t
3734	1130	Указатель на память	f
3735	1130	Отдельная переменная	f
3736	1130	Тип данных	f
3737	1131	Указатель может быть null, ссылка — нет; указатель меняет адрес, ссылка — нет	t
3738	1131	Ссылка может быть null	f
3739	1131	Указатель не может менять адрес	f
3740	1131	Разницы нет	f
3741	1132	Вычисление во время компиляции	t
3742	1132	Вычисление во время выполнения	f
3743	1132	Только для функций	f
3744	1132	Только для классов	f
3745	1133	Автоматическое определение типа компилятором	t
3746	1133	Явное указание типа	f
3747	1133	Только для переменных	f
3748	1133	Только для функций	f
3749	1134	Безопасный нулевой указатель	t
3750	1134	Целочисленная константа	f
3751	1134	Строковая константа	f
3752	1134	Ключевое слово для NULL	f
3753	1135	Пользовательский тип с данными и методами	t
3754	1135	Функция	f
3755	1135	Массив	f
3756	1135	Указатель	f
3757	1136	Метод для инициализации объекта при создании	t
3758	1136	Метод для удаления объекта	f
3759	1136	Метод для копирования	f
3760	1136	Метод для сравнения	f
3761	1137	Метод для очистки ресурсов при уничтожении объекта	t
3762	1137	Метод для создания объекта	f
3763	1137	Метод для копирования	f
3764	1137	Метод для сравнения	f
3765	1138	public, protected, private	t
3766	1138	Только public	f
3767	1138	Только private	f
3768	1138	Только protected	f
3769	1139	Создание нового класса на основе существующего	t
3770	1139	Копирование класса	f
3771	1139	Удаление класса	f
3772	1139	Переименование класса	f
3773	1140	Объекты с одинаковым интерфейсом ведут себя по-разному	t
3774	1140	Объекты с разным интерфейсом	f
3775	1140	Только наследование	f
3776	1140	Только перегрузка	f
3777	1141	Функция, переопределяемая в производном классе	t
3778	1141	Обычная функция	f
3779	1141	Статическая функция	f
3780	1141	Дружественная функция	f
3781	1142	Класс с чисто виртуальной функцией, не инстанциируется	t
3782	1142	Обычный класс	f
3783	1142	Интерфейс	f
3784	1142	Структура	f
3785	1143	Обобщенный код, работающий с разными типами	t
3786	1143	Готовый код	f
3787	1143	Конкретный тип	f
3788	1143	Класс	f
3789	1144	Standard Template Library — контейнеры, алгоритмы, итераторы	t
3790	1144	Стандартная библиотека C	f
3791	1144	Библиотека для графики	f
3792	1144	Библиотека для сети	f
3793	1145	unique_ptr, shared_ptr, weak_ptr для автоматического управления памятью	t
3794	1145	Обычные указатели	f
3795	1145	Ссылки	f
3796	1145	Массивы	f
3797	1146	Resource Acquisition Is Initialization — управление ресурсами через конструкторы/деструкторы	t
3798	1146	Resource Allocation Is Initialization	f
3799	1146	Resource Acquisition In Initialization	f
3800	1146	Return Acquisition Is Initialization	f
3801	1147	Перемещение ресурсов вместо копирования (C++11)	t
3802	1147	Копирование ресурсов	f
3803	1147	Удаление ресурсов	f
3804	1147	Создание ресурсов	f
3805	1148	Анонимные функции: [capture](params) -> ret { body }	t
3806	1148	Обычные функции	f
3807	1148	Функторы	f
3808	1148	Методы класса	f
3809	1149	Механизм обработки ошибок через try, catch, throw	t
3810	1149	Обычные ошибки	f
3811	1149	Логирование	f
3812	1149	Отладка	f
3813	1150	Ограничения для шаблонов (concept, requires)	t
3814	1150	Новые контейнеры	f
3815	1150	Новые алгоритмы	f
3816	1150	Новые итераторы	f
3817	1151	ООП	t
3818	1151	Процедурное	t
3819	1151	Обобщенное	t
3820	1151	Функциональное	t
3821	1151	Императивное	f
3822	1151	Декларативное	f
3823	1152	int	t
3824	1152	float	t
3825	1152	double	t
3826	1152	char	t
3827	1152	bool	t
3828	1152	void	t
3829	1152	long	t
3830	1152	short	t
3831	1152	String	f
3832	1152	Integer	f
3833	1153	public	t
3834	1153	protected	t
3835	1153	private	t
3836	1153	internal	f
3837	1153	default	f
3838	1154	public	t
3839	1154	protected	t
3840	1154	private	t
3841	1154	default	f
3842	1154	internal	f
3843	1155	vector	t
3844	1155	list	t
3845	1155	deque	t
3846	1155	set	t
3847	1155	map	t
3848	1155	unordered_set	t
3849	1155	unordered_map	t
3850	1155	queue	t
3851	1155	stack	t
3852	1155	ArrayList	f
3853	1155	HashMap	f
3854	1156	unique_ptr	t
3855	1156	shared_ptr	t
3856	1156	weak_ptr	t
3857	1156	auto_ptr	t
3858	1156	raw_ptr	f
3859	1156	smart_ptr	f
3860	1157	Input	t
3861	1157	Output	t
3862	1157	Forward	t
3863	1157	Bidirectional	t
3864	1157	Random Access	t
3865	1157	Sequential	f
3866	1157	Continuous	f
3867	1158	try	t
3868	1158	catch	t
3869	1158	throw	t
3870	1158	noexcept	t
3871	1158	except	f
3872	1158	error	f
3873	1159	auto	t
3874	1159	nullptr	t
3875	1159	constexpr	t
3876	1159	лямбда-выражения	t
3877	1159	move-семантика	t
3878	1159	умные указатели	t
3879	1159	концепты	f
3880	1159	модули	f
3881	1159	корутины	f
3882	1160	constexpr улучшения	t
3883	1160	generic lambdas	t
3884	1160	binary literals	t
3885	1160	digit separators	t
3886	1160	концепты	f
3887	1160	модули	f
3888	1160	корутины	f
3889	1161	if constexpr	t
3890	1161	structured bindings	t
3891	1161	filesystem	t
3892	1161	optional	t
3893	1161	variant	t
3894	1161	any	t
3895	1161	концепты	f
3896	1161	модули	f
3897	1161	корутины	f
3898	1162	Концепты	t
3899	1162	Корутины	t
3900	1162	Модули	t
3901	1162	Ranges	t
3902	1162	Трехстороннее сравнение	t
3903	1162	constexpr improvements	t
3904	1162	Лямбда-выражения	f
3905	1162	move-семантика	f
3906	1163	& (адрес)	t
3907	1163	* (разыменование)	t
3908	1163	-> (доступ к члену)	t
3909	1163	. (доступ к члену)	f
3910	1163	:: (разрешение области)	f
3911	1164	По умолчанию	t
3912	1164	Параметризованный	t
3913	1164	Копирования	t
3914	1164	Move	t
3915	1164	Делегирующий	t
3916	1164	Статический	f
3917	1164	Виртуальный	f
3918	1165	sort	t
3919	1165	find	t
3920	1165	copy	t
3921	1165	for_each	t
3922	1165	accumulate	t
3923	1165	transform	t
3924	1165	push	f
3925	1165	pop	f
3926	1166	Поля	t
3927	1166	Методы	t
3928	1166	Функции	t
3929	1166	Конструкторы	f
3930	1166	Деструкторы	f
3931	1167	Copy initialization	t
3932	1167	Direct initialization	t
3933	1167	Uniform initialization ({})	t
3934	1167	Value initialization	t
3935	1167	Default initialization	t
3936	1167	Zero initialization	t
3937	1167	Aggregate initialization	t
3938	1167	Constructor initialization	f
3939	1167	Method initialization	f
3940	1168	new	t
3941	1168	new[]	t
3942	1168	delete	t
3943	1168	delete[]	t
3944	1168	placement new	t
3945	1168	malloc	f
3946	1168	free	f
3947	1169	lvalue	t
3948	1169	rvalue	t
3949	1169	xvalue	t
3950	1169	glvalue	t
3951	1169	prvalue	t
3952	1169	zvalue	f
3953	1169	tvalue	f
3954	1170	signed	t
3955	1170	unsigned	t
3956	1170	short	t
3957	1170	long	t
3958	1170	long long	t
3959	1170	byte	f
3960	1170	word	f
3961	1171	const	t
3962	1171	volatile	t
3963	1171	constexpr	t
3964	1171	static	f
3965	1171	extern	f
3966	1172	Одинарное	t
3967	1172	Множественное	t
3968	1172	Виртуальное	t
3969	1172	Интерфейсное	f
3970	1172	Абстрактное	f
3971	1173	Методы класса	t
3972	1173	Деструкторы	t
3973	1173	Нестатические методы	t
3974	1173	Статические методы	f
3975	1173	Конструкторы	f
3976	1173	Функции вне класса	f
3977	1174	set	t
3978	1174	map	t
3979	1174	multiset	t
3980	1174	multimap	t
3981	1174	unordered_set	t
3982	1174	unordered_map	t
3983	1174	vector	f
3984	1174	list	f
3985	1175	vector	t
3986	1175	list	t
3987	1175	deque	t
3988	1175	forward_list	t
3989	1175	array	t
3990	1175	set	f
3991	1175	map	f
3992	1176	Бьёрн Страуструп	t
3993	1177	C++	t
3994	1178	указатель	t
3995	1179	ссылка	t
3996	1180	nullptr	t
3997	1181	constexpr	t
3998	1182	auto	t
3999	1183	конструктор	t
4000	1184	деструктор	t
4001	1185	public	t
4002	1186	private	t
4003	1187	protected	t
4004	1188	наследование	t
4005	1189	виртуальная	t
4006	1190	абстрактный	t
4007	1191	STL	t
4008	1192	vector	t
4009	1193	list	t
4010	1194	set	t
4011	1195	map	t
4012	1196	unique_ptr	t
4013	1197	shared_ptr	t
4014	1198	лямбда	t
4015	1199	исключения	t
4016	1200	концепты	t
4017	1201	1967	f
4018	1201	1997	f
4019	1201	1998	t
4020	1201	2001	f
4021	1202	Налоговое планирование	t
4022	1202	Электронный документооборот	f
4023	1202	Бухгалтерия и учет	f
4024	1202	Маркировка товаров	f
4025	1203	Нет	f
4026	1203	Да	t
4028	1204	7	f
4029	1204	11	t
4030	1204	12	f
4031	1205	Нет	t
4032	1205	Да	f
4027	1204	6	f
4033	1206	Екатеринбург	f
4034	1206	Ярославль	f
4035	1206	Новосибирск	t
4036	1206	Самара	f
4037	1207	saby	f
4039	1207	papirus	f
4040	1207	sbis	f
4041	1208	Шайтан	t
4042	1208	Джин	f
4043	1208	Хоттабыч	f
4044	1208	Аид	f
4045	1209	Птичка	f
4046	1209	Гусь	t
4047	1209	Капибара	f
4048	1209	Жук	f
4049	1210	Кострома	t
4050	1210	Самара	f
4051	1210	Ярославль	f
4052	1210	Казань	f
4038	1207	setty	t
\.


--
-- Data for Name: card_types; Type: TABLE DATA; Schema: z1; Owner: z1
--

COPY z1.card_types (id, name) FROM stdin;
1	bool
2	regular
3	multiple-choice
4	input
\.


--
-- Data for Name: cards; Type: TABLE DATA; Schema: z1; Owner: z1
--

COPY z1.cards (id, topic_id, title, description, card_type_id) FROM stdin;
1	1	HTML является языком программирования?	HTML — язык разметки, а не программирования	1
2	1	CSS расшифровывается как "Cascading Style Sheets"?	Cascading Style Sheets — каскадные таблицы стилей	1
3	1	DOM - это программный интерфейс для работы с HTML?	Document Object Model — программный интерфейс	1
4	1	Тег <html> является корневым элементом HTML-документа?	Тег <html> — корневой элемент документа	1
5	1	Тег <body> содержит метаданные документа?	Body — видимое содержимое, Head — метаданные	1
6	1	Тег <p> используется для создания списков?	Параграф — блок текста, а не список	1
7	1	Тег <br> является парным тегом?	Перенос строки — одиночный тег	1
8	1	Тег <hr> создает горизонтальный разделитель?	Горизонтальная линия — тематический разделитель	1
9	1	Тег <h1> является наименее важным заголовком?	h1 — самый важный, h6 — наименее важный	1
10	1	Тег <ul> создает нумерованный список?	ul — неупорядоченный (маркированный) список	1
11	1	Тег <ol> создает маркированный список?	ol — упорядоченный (нумерованный) список	1
12	1	Тег <div> является строчным элементом?	div — блочный контейнер	1
13	1	Тег <span> является блочным элементом?	span — строчный контейнер	1
14	1	Атрибут href используется в теге <a> для указания адреса ссылки?	href определяет URL ссылки	1
15	1	Атрибут alt используется для задания пути к изображению?	alt — альтернативный текст, а не путь	1
16	1	Тег <header> обычно используется для подвала сайта?	header — шапка сайта, footer — подвал	1
17	1	Тег <main> должен быть уникальным на каждой странице?	Основной контент уникален для каждой страницы	1
18	1	Тег <article> предназначен для боковой панели?	article — самостоятельный контент, aside — боковая панель	1
19	1	Тег <section> используется для группировки тематически связанного контента?	Секция группирует тематически связанный контент	1
20	1	Атрибут required делает поле формы обязательным?	required запускает валидацию браузера	1
21	1	Тег <label> используется для создания кнопок?	label — подпись для элемента формы	1
22	1	Атрибут action в форме указывает метод отправки данных?	action указывает URL сервера, method — метод	1
23	1	Тег <video> может использоваться без сторонних плагинов?	Видео-тег обеспечивает нативное воспроизведение	1
24	1	Атрибут autoplay включает автоматическое воспроизведение видео?	autoplay запускает видео после загрузки	1
25	1	Тег <iframe> используется для вставки другого HTML-документа?	Iframe встраивает другой HTML-документ	1
26	1	Что такое HTML?	HyperText Markup Language — язык разметки для создания веб-страниц	2
27	1	Что означает аббревиатура CSS?	Cascading Style Sheets — каскадные таблицы стилей	2
28	1	Что такое DOM?	Document Object Model — объектная модель документа	2
29	1	Какой тег является корневым в HTML-документе?	Тег <html> — корневой элемент документа	2
30	1	Какие основные части содержит HTML-документ?	Head — метаданные, Body — видимое содержимое	2
31	1	Для чего используется тег <p>?	Параграф — блок текста, отделённый от других абзацев	2
32	1	Для чего используется тег <br>?	Перенос строки — одиночный тег	2
33	1	Для чего используется тег <hr>?	Горизонтальная линия — тематический разделитель	2
34	1	Для чего используется тег <ul>?	Неупорядоченный список — маркированный список	2
35	1	Для чего используется тег <ol>?	Упорядоченный список — нумерованный список	2
36	1	Для чего используется тег <li>?	Пункт списка — элемент внутри <ul> или <ol>	2
37	1	Для чего используется тег <div>?	Универсальный блочный контейнер для группировки	2
38	1	Для чего используется тег <span>?	Универсальный строчный контейнер	2
39	1	Для чего используется тег <a>?	Гиперссылка — создаёт ссылки на другие страницы	2
40	1	Для чего используется тег <form>?	Форма для отправки данных на сервер	2
41	1	Какой тег используется для создания кнопки?	Тег <button> создает кликабельную кнопку	2
42	1	Для чего используется тег <input>?	Универсальный элемент для полей ввода	2
43	1	Для чего используется тег <select>?	Выпадающий список для выбора вариантов	2
44	1	Что такое семантическая вёрстка?	Использование тегов по их смыслу	2
45	1	Для чего используется тег <header>?	Шапка сайта с логотипом и навигацией	2
46	1	Для чего используется тег <footer>?	Подвал сайта с контактами и копирайтом	2
47	1	Для чего используется тег <nav>?	Навигационные ссылки по сайту	2
48	1	Для чего используется тег <main>?	Основное содержимое страницы	2
49	1	Для чего используется тег <article>?	Самостоятельный контент	2
50	1	Для чего используется тег <section>?	Раздел документа	2
51	1	Какие из перечисленных тегов являются семантическими?	Семантические теги описывают смысл контента	3
52	1	Какие атрибуты используются для валидации форм?	HTML5 предоставляет встроенные атрибуты валидации	3
53	1	Какие форматы изображений поддерживаются в HTML?	Браузеры поддерживают множество форматов	3
54	1	Какие типы имеет тег <input>?	Атрибут type определяет поведение поля	3
55	1	Какие элементы должны быть в каждом HTML-документе?	Базовые элементы HTML-документа	3
56	1	Какие теги используются для создания списков?	HTML имеет три типа списков	3
57	1	Какие атрибуты тега <video> управляют воспроизведением?	Атрибуты управления видео	3
58	1	Какие методы отправки данных поддерживает тег <form>?	Методы отправки данных	3
59	1	Какие теги используются для группировки элементов формы?	Теги для структурирования форм	3
60	1	Какие атрибуты помогают улучшить доступность?	Атрибуты для доступности	3
61	1	Какие теги предназначены для работы с цитатами?	Теги для цитирования	3
62	1	Какие теги относятся к текстовому форматированию?	Теги для стилизации текста	3
63	1	Какие элементы используются для ввода данных в форме?	Элементы ввода HTML	3
64	1	Какие атрибуты управления фокусировкой существуют?	Атрибуты для навигации	3
65	1	Какие технологии используются вместе с HTML?	Стек веб-технологий	3
66	1	Какие элементы используются для создания таблиц?	Структура HTML-таблиц	3
67	1	Какие атрибуты изображения важны для SEO?	Атрибуты оптимизации изображений	3
68	1	Какие теги помогают структурировать контент страницы?	Структурные теги	3
69	1	Какие элементы используются для воспроизведения медиа?	Медиа-элементы HTML	3
70	1	Какие теги относятся к inline-элементам?	Строчные элементы	3
71	1	Какие атрибуты используются для управления формой?	Атрибуты управления формами	3
72	1	Какие теги используются для выделения текста?	Теги выделения текста	3
73	1	Какие элементы могут быть использованы как контейнеры?	Контейнерные элементы	3
74	1	Какие атрибуты относятся к универсальным?	Глобальные атрибуты	3
75	1	Какие теги используются для создания навигации?	Навигационные элементы	3
76	1	Как расшифровывается HTML? (введите полное название)	HyperText Markup Language	4
77	1	Как расшифровывается CSS? (введите полное название)	Cascading Style Sheets	4
78	1	Какой тег является корневым в HTML-документе? (введите тег без угловых скобок)	html	4
79	1	Какой тег используется для создания самого большого заголовка? (введите тег без угловых скобок)	h1	4
80	1	Какой атрибут используется для указания адреса ссылки?	href	4
81	1	Какой атрибут используется для альтернативного текста изображения?	alt	4
82	1	Какой тег используется для создания неупорядоченного списка? (введите тег без угловых скобок)	ul	4
83	1	Какой тег используется для создания упорядоченного списка? (введите тег без угловых скобок)	ol	4
84	1	Какой тег используется для пункта списка? (введите тег без угловых скобок)	li	4
85	1	Какой тег используется для параграфа? (введите тег без угловых скобок)	p	4
86	1	Какой тег используется для переноса строки? (введите тег без угловых скобок)	br	4
87	1	Какой тег используется для горизонтальной линии? (введите тег без угловых скобок)	hr	4
88	1	Какой тег используется для гиперссылки? (введите тег без угловых скобок)	a	4
89	1	Какой тег используется для вставки изображения? (введите тег без угловых скобок)	img	4
90	1	Какой тег используется для шапки сайта? (введите тег без угловых скобок)	header	4
91	1	Какой тег используется для подвала сайта? (введите тег без угловых скобок)	footer	4
92	1	Какой тег используется для навигации? (введите тег без угловых скобок)	nav	4
93	1	Какой тег используется для основного контента? (введите тег без угловых скобок)	main	4
94	1	Какой тег используется для самостоятельного контента? (введите тег без угловых скобок)	article	4
95	1	Какой тег используется для боковой панели? (введите тег без угловых скобок)	aside	4
96	1	Какой тег используется для выделения текста маркером? (введите тег без угловых скобок)	mark	4
97	1	Какой тег используется для отображения кода? (введите тег без угловых скобок)	code	4
98	1	Какой тег используется для предварительно форматированного текста? (введите тег без угловых скобок)	pre	4
99	1	Какой тег используется для вставки видео? (введите тег без угловых скобок)	video	4
100	1	Какой тег используется для вставки аудио? (введите тег без угловых скобок)	audio	4
101	2	Go был создан в Google?	Go создан в Google для решения проблем масштабируемости	1
102	2	Go является языком с динамической типизацией?	Go статически типизирован, типы проверяются на этапе компиляции	1
103	2	Горутины легче потоков операционной системы?	Горутины имеют стек 2-4 КБ против 1 МБ у потоков ОС	1
104	2	Каналы в Go используются для коммуникации между горутинами?	Каналы реализуют принцип "общайтесь через сообщения"	1
105	2	Оператор <- используется только для отправки данных в канал?	Оператор <- используется и для отправки, и для получения данных	1
106	2	Defer выполняется до возврата из функции?	Defer откладывает выполнение до возврата из функции	1
107	2	Defer выполняется в порядке объявления (FIFO)?	Defer выполняется в обратном порядке (LIFO)	1
108	2	Panic можно перехватить с помощью recover?	Recover позволяет восстановиться после паники	1
109	2	В Go есть ключевое слово implements для реализации интерфейсов?	В Go нет implements, интерфейсы реализуются неявно	1
110	2	Пустой интерфейс interface{} может хранить значение любого типа?	Пустой интерфейс не требует методов и подходит для любого типа	1
111	2	Type assertion используется для преобразования типов?	Type assertion извлекает конкретный тип из интерфейса	1
112	2	Type switch проверяет тип значения интерфейса?	Type switch выполняет разный код для разных типов интерфейса	1
113	2	Rune в Go - это псевдоним int32?	Rune представляет Unicode кодовую точку как int32	1
114	2	Byte в Go - это псевдоним int8?	Byte - это псевдоним uint8, а не int8	1
115	2	Zero value для int в Go равна nil?	Zero value для int равна 0, а не nil	1
116	2	Iota в Go используется для создания перечислений?	Iota автоматически инкрементируется в блоке const	1
117	2	Массивы в Go могут изменять свой размер?	Массивы имеют фиксированный размер в отличие от слайсов	1
118	2	Слайсы в Go ссылаются на массивы?	Слайс - это ссылка на массив с динамической длиной	1
119	2	Карты в Go требуют, чтобы ключи были сравнимыми типами?	Ключи карты должны быть сравнимыми типами	1
120	2	Функции в Go могут возвращать только одно значение?	Функции в Go могут возвращать несколько значений	1
121	2	GOMAXPROCS определяет количество ядер для выполнения?	GOMAXPROCS ограничивает число потоков ОС	1
122	2	Context используется для передачи дедлайнов и отмены?	Context передает дедлайны и сигналы отмены через вызовы	1
123	2	sync.WaitGroup используется для синхронизации горутин?	WaitGroup отслеживает завершение группы горутин	1
124	2	Мьютексы в Go могут использоваться для защиты общих данных?	Mutex обеспечивает эксклюзивный доступ к данным	1
347	4	Что такое HTTPS?	HTTP с шифрованием через SSL/TLS	2
125	2	Рефлексия в Go позволяет исследовать типы во время выполнения?	Reflect позволяет работать с типами и значениями в рантайме	1
126	2	Что такое Go?	Язык программирования от Google	2
127	2	Кто создал язык Go?	Роберт Гриземер, Роб Пайк, Кен Томпсон	2
128	2	В каком году был выпущен Go?	2009 год	2
129	2	Что такое горутина?	Легковесный поток выполнения	2
130	2	Как создать горутину?	Использовать ключевое слово go	2
131	2	Что такое каналы в Go?	Средство для коммуникации между горутинами	2
132	2	Как создать канал?	Использовать make с chan	2
133	2	Что делает оператор <-?	Отправляет или получает данные из канала	2
134	2	Что такое select в Go?	Ожидание операций на нескольких каналах	2
135	2	Что такое defer в Go?	Откладывает выполнение до возврата из функции	2
136	2	В каком порядке выполняются defer?	В обратном порядке (LIFO)	2
137	2	Что такое panic в Go?	Встроенная функция для создания паники	2
138	2	Что такое recover в Go?	Восстановление после паники	2
139	2	Что такое интерфейс в Go?	Тип, определяющий набор методов	2
140	2	Как реализовать интерфейс в Go?	Неявно - реализовав все методы	2
141	2	Что такое пустой интерфейс interface{}?	Может хранить значение любого типа	2
142	2	Что такое type assertion в Go?	Извлечение значения интерфейса конкретного типа	2
143	2	Что такое type switch в Go?	Проверка типа значения интерфейса	2
144	2	Что такое пакет в Go?	Способ организации и повторного использования кода	2
145	2	Как импортировать пакет в Go?	Использовать ключевое слово import	2
146	2	Что такое rune в Go?	Псевдоним int32 для Unicode	2
147	2	Что такое byte в Go?	Псевдоним uint8 для байта	2
148	2	Как объявить переменную в Go?	var или :=	2
149	2	Какая разница между var и :=?	var везде, := только внутри функций	2
150	2	Что такое zero value в Go?	Значение по умолчанию для неинициализированных переменных	2
151	2	Какие ключевые особенности языка Go?	Статическая типизация, горутины, быстрая компиляция	3
152	2	Какие инструменты входят в стандартную библиотеку Go?	net/http, encoding/json, sync, context	3
153	2	Какие типы данных являются встроенными в Go?	bool, string, int, float64, byte, rune	3
154	2	Какие способы объявления переменных существуют в Go?	var name type, var name = value, name := value	3
155	2	Какие типы коллекций есть в Go?	Массивы, слайсы, карты, структуры	3
156	2	Какие возможности для конкурентности предоставляет Go?	Горутины, каналы, select, sync.WaitGroup, мьютексы	3
157	2	Какие пакеты используются для работы с вводом-выводом?	io, os, bufio, fmt	3
158	2	Какие интерфейсы являются основными в Go для работы с данными?	io.Reader, io.Writer, io.Closer	3
159	2	Какие стратегии синхронизации существуют в Go?	Каналы, мьютексы, атомарные операции, WaitGroup	3
160	2	Какие инструменты для профилирования есть в Go?	pprof, go test -bench, go test -cpuprofile, -memprofile	3
161	2	Какие пакеты используются для работы с текстовыми форматами?	encoding/json, encoding/xml, regexp	3
162	2	Какие типы получателей методов существуют в Go?	Value receiver, pointer receiver	3
163	2	Какие способы обработки ошибок есть в Go?	Возврат ошибки, panic/recover, явная проверка	3
164	2	Какие стандартные интерфейсы для работы с контекстом?	context.Context, context.WithCancel, WithTimeout, WithDeadline	3
165	2	Какие типы чисел поддерживаются в Go?	int, int8, int16, int32, int64, uint, float32, float64	3
166	2	Какие функции для работы со строками есть в Go?	len, strings.Contains, strings.Split, strings.Join	3
167	2	Какие структуры данных для синхронизации есть в Go?	Mutex, RWMutex, WaitGroup, Once, Cond	3
168	2	Какие способы управления зависимостями есть в Go?	Go modules, go.mod, go.sum, go get, go mod tidy	3
169	2	Какие функции для работы с файлами есть в Go?	os.Open, os.Create, os.ReadFile, os.WriteFile	3
170	2	Какие методы HTTP есть в Go?	http.Get, http.Post, http.NewRequest, http.Client	3
171	2	Какие форматы кодирования поддерживает Go?	JSON, XML, Base64, Gob	3
172	2	Какие операторы для работы с указателями есть в Go?	& (получение адреса), * (разыменование)	3
348	4	Что такое FTP?	Протокол для передачи файлов	2
173	2	Какие пакеты для работы с датой и временем?	time, time.Time, time.Duration	3
174	2	Какие инструменты для тестирования в Go?	testing, go test, табличные тесты, моки	3
175	2	Какие атрибуты сборщика мусора в Go?	Трехцветная маркировка, параллельная сборка, низкие паузы	3
176	2	Как называется язык программирования от Google? (введите название)	Go	4
177	2	Как расшифровывается язык Go? (введите аббревиатуру)	Golang	4
178	2	Как называется легковесный поток выполнения в Go? (введите термин)	горутина	4
179	2	Как создать горутину в Go? (введите ключевое слово)	go	4
180	2	Как называется средство для коммуникации между горутинами? (введите термин)	канал	4
181	2	Как создать канал в Go? (введите функцию)	make	4
182	2	Что используется для ожидания операций на нескольких каналах? (введите термин)	select	4
183	2	Как называется отложенное выполнение в Go? (введите термин)	defer	4
184	2	Как называется восстановление после паники в Go? (введите термин)	recover	4
185	2	Как называется псевдоним int32 для Unicode в Go? (введите термин)	rune	4
186	2	Как называется псевдоним uint8 в Go? (введите термин)	byte	4
187	2	Какой оператор используется для объявления переменной с автоматическим выводом типа? (введите оператор)	:=	4
188	2	Как называется значение по умолчанию для неинициализированных переменных? (введите термин)	zero value	4
189	2	Как называется генератор последовательных констант в Go? (введите термин)	iota	4
190	2	Как называется динамическая коллекция в Go? (введите термин)	слайс	4
191	2	Как называется коллекция ключ-значение в Go? (введите термин)	карта	4
192	2	Как называется структура данных с именованными полями в Go? (введите термин)	структура	4
193	2	Как называется тип, определяющий набор методов в Go? (введите термин)	интерфейс	4
194	2	Как называется функция с получателем в Go? (введите термин)	метод	4
195	2	Как называется переменная, хранящая адрес памяти? (введите термин)	указатель	4
196	2	Как называется контейнер для рабочих горутин? (введите термин)	воркер пул	4
197	2	Как называется инструмент для профилирования в Go? (введите термин)	pprof	4
198	2	Как называется синхронизация через счётчик в Go? (введите термин)	WaitGroup	4
199	2	Как называется файл модуля с зависимостями в Go? (введите имя файла)	go.mod	4
200	2	Как называется тестирование производительности в Go? (введите термин)	бенчмарк	4
201	3	Docker использует контейнеризацию на уровне операционной системы?	Docker использует контейнеризацию на уровне ОС, а не аппаратную виртуализацию	1
202	3	Контейнеры Docker требуют отдельную операционную систему для каждого контейнера?	Контейнеры используют ядро хоста и не требуют отдельной ОС	1
203	3	Docker-образы являются неизменяемыми?	Docker-образы неизменяемы и состоят из слоев	1
204	3	Dockerfile используется для описания шагов сборки образа?	Dockerfile содержит инструкции для сборки Docker-образа	1
205	3	Команда docker build собирает образ из Dockerfile?	docker build читает Dockerfile и создает образ	1
206	3	Команда docker run запускает контейнер из образа?	docker run создает и запускает контейнер из образа	1
207	3	Docker-демон управляет контейнерами и образами?	Демон dockerd управляет всеми операциями с контейнерами	1
208	3	Инструкция COPY в Dockerfile может скачивать файлы по URL?	COPY не поддерживает URL, это делает ADD	1
209	3	Инструкция ADD автоматически распаковывает tar-архивы?	ADD поддерживает автоматическую распаковку tar-архивов	1
210	3	Инструкция CMD всегда выполняется, даже если указан ENTRYPOINT?	CMD передается как аргументы ENTRYPOINT, если он задан	1
211	3	Инструкция ENV задает переменные только во время сборки?	ENV доступны и при сборке, и в работающем контейнере	1
212	3	Многоэтапная сборка помогает уменьшить размер образа?	Многоэтапная сборка позволяет создать минимальный образ с бинарными файлами	1
213	3	docker pause замораживает процессы в контейнере?	pause использует cgroups freezer для заморозки процессов	1
214	3	docker commit создает новый образ из контейнера?	commit фиксирует текущее состояние контейнера в образ	1
215	3	docker save экспортирует файловую систему контейнера?	save сохраняет образ со слоями, export сохраняет только файловую систему	1
216	3	Docker Compose используется для управления одним контейнером?	Compose управляет многоконтейнерными приложениями	1
217	3	docker-compose up запускает все сервисы из compose файла?	up создает и запускает все сервисы из конфигурации	1
218	3	docker-compose down удаляет контейнеры, сети и тома?	down удаляет контейнеры и сети, тома сохраняются без флага -v	1
219	3	Bridge сеть в Docker обеспечивает изоляцию контейнеров?	Bridge изолирует контейнеры и использует NAT для доступа наружу	1
220	3	Host сеть в Docker использует сетевой стек хоста?	Host сеть позволяет контейнеру использовать сеть хоста напрямую	1
221	3	Overlay сеть используется для соединения контейнеров на разных хостах?	Overlay сеть используется в Swarm-кластере для соединения хостов	1
222	3	Тома в Docker сохраняют данные после удаления контейнера?	Тома переживают удаление контейнера и сохраняют данные	1
223	3	Bind mounts управляются Docker и не видны хосту?	Bind mounts используют путь на хосте и доступны вне Docker	1
224	3	Docker Swarm является оркестратором контейнеров?	Swarm — встроенный оркестратор для кластеризации Docker	1
225	3	Команда docker swarm init инициализирует кластер Swarm?	swarm init создает новый кластер с текущим хостом как менеджером	1
226	3	Что такое Docker?	Платформа для контейнеризации приложений	2
227	3	Что такое контейнеризация?	Метод виртуализации на уровне операционной системы	2
228	3	В чем отличие контейнера от виртуальной машины?	Контейнеры используют ядро хоста, а ВМ имеют свою ОС	2
229	3	Что такое Docker-образ?	Неизменяемый шаблон для создания контейнеров	2
230	3	Что такое Docker-контейнер?	Запущенный экземпляр Docker-образа	2
231	3	Что такое Docker Hub?	Публичный реестр Docker-образов	2
232	3	Что такое Dockerfile?	Файл с инструкциями для сборки образа	2
233	3	Какая команда собирает образ?	docker build	2
234	3	Какая команда запускает контейнер?	docker run	2
235	3	Какая команда показывает список контейнеров?	docker ps	2
236	3	Как остановить контейнер?	docker stop	2
237	3	Как удалить контейнер?	docker rm	2
238	3	Как удалить образ?	docker rmi	2
239	3	Что такое слой в Docker?	Неизменяемая часть Docker-образа	2
240	3	Как работает кэширование слоёв?	Кэширует слои при повторной сборке образа	2
241	3	Что такое Docker-демон?	Фоновый процесс управления контейнерами	2
242	3	Что такое Docker-клиент?	Интерфейс для взаимодействия с Docker-демоном	2
243	3	Для чего используется инструкция FROM?	Указывает базовый образ для сборки	2
244	3	Для чего используется инструкция RUN?	Выполняет команды во время сборки образа	2
245	3	Для чего используется инструкция COPY?	Копирует файлы из хоста в образ	2
246	3	Для чего используется инструкция CMD?	Задает команду по умолчанию для контейнера	2
247	3	Для чего используется инструкция ENTRYPOINT?	Задает исполняемый файл для контейнера	2
248	3	Что такое Docker Compose?	Инструмент для многоконтейнерных приложений	2
249	3	Какая команда запускает Docker Compose?	docker-compose up	2
250	3	Какой файл используется для Docker Compose?	docker-compose.yml или compose.yaml	2
251	3	Какие преимущества у Docker-контейнеров перед ВМ?	Быстрый запуск, легковесность, эффективное использование ресурсов	3
252	3	Какие компоненты входят в Docker-движок?	Демон dockerd, REST API, CLI клиент, система плагинов	3
253	3	Какие инструкции используются в Dockerfile для копирования файлов?	COPY, ADD	3
254	3	Какие инструкции в Dockerfile определяют команды выполнения?	CMD, ENTRYPOINT, RUN	3
255	3	Какие типы монтирования данных поддерживает Docker?	Named volumes, Bind mounts, tmpfs	3
256	3	Какие типы сетей поддерживает Docker?	bridge, host, overlay, macvlan, none	3
257	3	Какие команды работают с контейнерами?	docker run, docker stop, docker rm, docker ps	3
258	3	Какие команды работают с образами?	docker build, docker images, docker rmi, docker tag	3
259	3	Какие команды для работы с томами?	docker volume create, docker volume ls, docker volume rm, docker volume prune	3
260	3	Какие команды для работы с сетями?	docker network create, docker network ls, docker network rm, docker network connect	3
261	3	Какие опции можно использовать с docker run?	-d, --name, -p, -v, -e, --network	3
262	3	Какие функции есть в Docker Compose?	Запуск сервисов, масштабирование, сети, тома, зависимости	3
263	3	Какие команды Docker Compose существуют?	up, down, logs, exec, ps, config	3
264	3	Какие best practices для Dockerfile?	Минимум слоев, официальные образы, .dockerignore, конкретные теги	3
265	3	Какие стратегии оптимизации размера образа?	Многоэтапная сборка, Alpine-образы, объединение RUN	3
266	3	Какие возможности Docker Swarm?	Кластеризация, балансировка, отказоустойчивость, масштабирование	3
267	3	Какие типы нод в Swarm?	Менеджеры, рабочие ноды	3
268	3	Какие сущности есть в Swarm?	Сервисы, стеки, задачи, ноды	3
269	3	Какие методы сохранения данных в Docker?	Тома, Bind mounts, хранение внутри контейнера	3
270	3	Какие команды для работы с образами в реестре?	docker push, docker pull, docker login	3
271	3	Какие опции для docker-compose up?	-d, --build, --scale, --force-recreate	3
272	3	Какие функции Docker для безопасности?	USER инструкция, read-only тома, капсистемы, секреты	3
273	3	Какие переменные окружения можно использовать в Docker?	ENV, ARG, --env-file, .env файл	3
274	3	Какие способы получения логов в Docker?	docker logs, docker-compose logs, journalctl, syslog	3
275	3	Какие инструменты для мониторинга Docker?	docker stats, docker events, cAdvisor, Prometheus	3
276	3	Как называется инструмент для контейнеризации приложений? (введите название)	Docker	4
277	3	Как называется файл с инструкциями для сборки образа? (введите название файла)	Dockerfile	4
278	3	Как называется неизменяемый шаблон для создания контейнеров? (введите термин)	образ	4
279	3	Как называется запущенный экземпляр образа? (введите термин)	контейнер	4
280	3	Какая команда собирает образ из Dockerfile? (введите команду)	docker build	4
281	3	Какая команда запускает контейнер? (введите команду)	docker run	4
282	3	Какая команда показывает список запущенных контейнеров? (введите команду)	docker ps	4
283	3	Какая команда останавливает контейнер? (введите команду)	docker stop	4
284	3	Какая команда удаляет контейнер? (введите команду)	docker rm	4
285	3	Какая команда удаляет образ? (введите команду)	docker rmi	4
286	3	Какая инструкция задает базовый образ в Dockerfile? (введите инструкцию)	FROM	4
287	3	Какая инструкция выполняет команды при сборке? (введите инструкцию)	RUN	4
288	3	Какая инструкция копирует файлы в образ? (введите инструкцию)	COPY	4
289	3	Какая инструкция задает команду по умолчанию? (введите инструкцию)	CMD	4
290	3	Какая инструкция задает исполняемый файл? (введите инструкцию)	ENTRYPOINT	4
291	3	Как называется инструмент для многоконтейнерных приложений? (введите название)	Docker Compose	4
292	3	Какая команда запускает сервисы Docker Compose? (введите команду)	docker-compose up	4
293	3	Какая команда останавливает и удаляет сервисы Compose? (введите команду)	docker-compose down	4
294	3	Как называется сеть по умолчанию в Docker? (введите термин)	bridge	4
295	3	Как называется тип томов, управляемых Docker? (введите термин)	named volumes	4
296	3	Как называется тип монтирования с путем на хосте? (введите термин)	bind mounts	4
297	3	Как называется оркестратор, встроенный в Docker? (введите название)	Docker Swarm	4
298	3	Как называется узел кластера в Swarm? (введите термин)	нода	4
299	3	Как называется файл конфигурации Docker Compose? (введите имя файла)	docker-compose.yml	4
300	3	Какая команда показывает логи контейнера? (введите команду)	docker logs	4
301	4	OSI модель состоит из 7 уровней?	OSI — теоретическая модель, разделяющая сетевое взаимодействие на 7 уровней	1
302	4	TCP/IP модель состоит из 4 уровней?	TCP/IP — практическая модель, состоит из 4 уровней	1
935	10	Как объявить функцию?	function name($param) { }	2
303	4	IPv4 адрес состоит из 32 бит?	32 бита дают около 4.3 миллиарда адресов	1
304	4	IPv6 адрес состоит из 64 бит?	128 бит обеспечивают практически неисчерпаемое адресное пространство	1
305	4	DNS преобразует IP-адреса в доменные имена?	DNS преобразует домены в IP-адреса для маршрутизации	1
306	4	DHCP автоматически выдаёт IP-адреса устройствам?	DHCP автоматически выдаёт IP-адреса, маску, шлюз и DNS	1
307	4	NAT позволяет устройствам с частными адресами выходить в интернет?	NAT позволяет множеству устройств с частными адресами выходить в интернет	1
308	4	MAC-адрес состоит из 32 бит?	MAC-адрес состоит из 48 бит (6 байт)	1
309	4	Коммутатор работает на сетевом уровне OSI?	Коммутатор работает на канальном уровне (2-й уровень OSI)	1
310	4	Маршрутизатор работает на канальном уровне OSI?	Маршрутизатор работает на сетевом уровне (3-й уровень OSI)	1
311	4	В полнодуплексном режиме передача происходит одновременно в обе стороны?	Полный дуплекс позволяет передавать и принимать одновременно	1
312	4	В полудуплексном режиме передача происходит одновременно?	Полудуплекс требует поочерёдной передачи	1
313	4	STP предотвращает петли в сети?	STP блокирует резервные пути, предотвращая петли коммутации	1
314	4	ARP определяет MAC-адрес по IP-адресу?	ARP отправляет запрос "кто имеет этот IP?" и получает MAC	1
315	4	RARP определяет IP-адрес по MAC-адресу?	RARP решает обратную задачу — по MAC-адресу узнать IP	1
316	4	OSPF является протоколом состояния каналов?	OSPF строит карту сети через состояние каналов	1
317	4	BGP используется внутри одной автономной системы?	BGP — протокол интернета, обменивающий маршрутами между автономными системами	1
318	4	TCP является протоколом без установки соединения?	TCP устанавливает соединение перед передачей данных	1
319	4	UDP гарантирует доставку данных?	UDP отправляет без подтверждений и переотправки	1
320	4	HTTPS добавляет шифрование к HTTP?	HTTPS добавляет TLS-шифрование к HTTP	1
321	4	SSH является защищённой заменой Telnet?	SSH шифрует весь трафик, заменяя небезопасный Telnet	1
322	4	SNMP используется для управления сетевыми устройствами?	SNMP собирает метрики и управляет сетевыми устройствами	1
323	4	VPN создаёт зашифрованный туннель через публичную сеть?	VPN создаёт зашифрованный туннель через публичную сеть	1
324	4	IDS блокирует атаки в реальном времени?	IDS только обнаруживает и сигнализирует, не блокируя	1
325	4	IPS блокирует атаки в реальном времени?	IPS не только обнаруживает, но и автоматически блокирует атаки	1
326	4	Что такое компьютерная сеть?	Совокупность устройств для обмена данными	2
327	4	Что такое OSI модель?	7-уровневая эталонная модель	2
328	4	Сколько уровней в OSI модели?	7 уровней	2
329	4	Что такое TCP/IP модель?	4-уровневая практическая модель	2
330	4	Сколько уровней в TCP/IP модели?	4 уровня	2
331	4	Что такое IP-адрес?	Уникальный идентификатор устройства в сети	2
332	4	Сколько бит в IPv4 адресе?	32 бита	2
333	4	Сколько бит в IPv6 адресе?	128 бит	2
334	4	Что такое маска подсети?	Определяет границы сети и хостов	2
335	4	Что такое DNS?	Преобразует домены в IP-адреса	2
336	4	Что такое DHCP?	Автоматическая настройка сети	2
337	4	Что такое NAT?	Преобразование сетевых адресов	2
338	4	Что такое порт?	Идентификатор процесса (0-65535)	2
339	4	Что такое MAC-адрес?	Физический адрес сетевого интерфейса, 48 бит	2
340	4	Что такое Ethernet?	Семейство технологий для локальных сетей	2
341	4	Что такое коммутатор (switch)?	Устройство канального уровня	2
342	4	Что такое маршрутизатор (router)?	Устройство сетевого уровня	2
343	4	Что такое VLAN?	Виртуальная локальная сеть	2
344	4	Что такое TCP?	Протокол с соединением и гарантией доставки	2
345	4	Что такое UDP?	Протокол без соединения и гарантии	2
346	4	Что такое HTTP?	Протокол передачи гипертекста	2
349	4	Что такое SSH?	Протокол для безопасного удалённого управления	2
350	4	Что такое VPN?	Виртуальная частная сеть для безопасного соединения	2
351	4	Какие уровни есть в OSI модели?	Физический, канальный, сетевой, транспортный, сеансовый, представительный, прикладной	3
352	4	Какие уровни есть в TCP/IP модели?	Прикладной, транспортный, межсетевой, сетевой интерфейс	3
353	4	Какие протоколы работают на транспортном уровне?	TCP, UDP, SCTP, DCCP	3
354	4	Какие протоколы работают на прикладном уровне?	HTTP, FTP, SMTP, DNS, SSH, SNMP	3
355	4	Какие протоколы маршрутизации существуют?	RIP, OSPF, BGP, EIGRP	3
356	4	Какие методы HTTP существуют?	GET, POST, PUT, DELETE, PATCH, HEAD	3
357	4	Какие коды состояния HTTP бывают?	2xx Успех, 3xx Перенаправление, 4xx Ошибка клиента, 5xx Ошибка сервера	3
358	4	Какие протоколы электронной почты существуют?	SMTP, POP3, IMAP	3
359	4	Какие устройства используются в компьютерных сетях?	Коммутаторы, маршрутизаторы, сетевые карты, хабы	3
360	4	Какие типы кабелей используются в сетях?	Витая пара, коаксиальный, оптоволокно	3
361	4	Какие топологии сетей существуют?	Звезда, шина, кольцо, ячеистая	3
362	4	Какие типы передачи данных существуют?	Unicast, Multicast, Broadcast, Anycast	3
363	4	Какие протоколы используются для защиты сети?	IPsec, SSL/TLS, SSH, VPN	3
364	4	Какие системы безопасности сети существуют?	Firewall, IDS, IPS, DMZ, VPN	3
365	4	Какие протоколы используются для маршрутизации внутри AS?	OSPF, RIP, EIGRP	3
366	4	Какие протоколы используются для внешней маршрутизации?	BGP	3
367	4	Какие атрибуты IP-пакета?	Source IP, Destination IP, TTL, Protocol	3
368	4	Какие характеристики TCP?	Соединение, гарантия доставки, управление потоком, управление перегрузкой	3
369	4	Какие характеристики UDP?	Без соединения, без гарантии, быстрый, без управления потоком	3
370	4	Какие службы предоставляет DHCP?	IP-адрес, маска подсети, шлюз по умолчанию, DNS-сервер	3
371	4	Какие атаки на сети существуют?	DDoS, ARP-spoofing, DNS-spoofing, MITM	3
372	4	Какие протоколы для удалённого управления?	SSH, Telnet	3
373	4	Какие протоколы для диагностики сети?	ICMP (ping, traceroute)	3
374	4	Какие технологии для VLAN?	802.1Q, VTP, DTP	3
375	4	Какие протоколы для агрегации каналов?	LACP, PAgP	3
376	4	Как называется 7-уровневая эталонная модель сети? (введите название)	OSI	4
377	4	Как называется 4-уровневая практическая модель сети? (введите название)	TCP/IP	4
378	4	Сколько бит в IPv4 адресе? (введите число)	32	4
379	4	Сколько бит в IPv6 адресе? (введите число)	128	4
380	4	Как называется система преобразования доменов в IP-адреса? (введите аббревиатуру)	DNS	4
381	4	Как называется протокол автоматической настройки сети? (введите аббревиатуру)	DHCP	4
382	4	Как называется преобразование сетевых адресов? (введите аббревиатуру)	NAT	4
383	4	Как называется физический адрес сетевой карты? (введите название)	MAC-адрес	4
384	4	Как называется устройство канального уровня? (введите название)	коммутатор	4
385	4	Как называется устройство сетевого уровня? (введите название)	маршрутизатор	4
386	4	Как называется протокол с установкой соединения? (введите аббревиатуру)	TCP	4
387	4	Как называется протокол без установки соединения? (введите аббревиатуру)	UDP	4
388	4	Как называется протокол передачи гипертекста? (введите аббревиатуру)	HTTP	4
389	4	Как называется защищённая версия HTTP? (введите аббревиатуру)	HTTPS	4
390	4	Как называется протокол передачи файлов? (введите аббревиатуру)	FTP	4
391	4	Как называется протокол для безопасного удалённого управления? (введите аббревиатуру)	SSH	4
392	4	Как называется протокол для отправки почты? (введите аббревиатуру)	SMTP	4
393	4	Как называется протокол для получения почты? (введите аббревиатуру)	POP3	4
394	4	Как называется протокол для работы с почтой на сервере? (введите аббревиатуру)	IMAP	4
936	10	Что такое анонимная функция?	Функция без имени	2
395	4	Как называется протокол для управления сетевыми устройствами? (введите аббревиатуру)	SNMP	4
396	4	Как называется протокол для синхронизации времени? (введите аббревиатуру)	NTP	4
397	4	Как называется виртуальная частная сеть? (введите аббревиатуру)	VPN	4
398	4	Как называется система обнаружения вторжений? (введите аббревиатуру)	IDS	4
399	4	Как называется система предотвращения вторжений? (введите аббревиатуру)	IPS	4
400	4	Как называется протокол для диагностики сети? (введите аббревиатуру)	ICMP	4
401	5	JavaScript был создан Бренданом Эйхом?	Брендан Эйх создал JavaScript за 10 дней в 1995 году	1
402	5	JavaScript был создан в 1995 году?	JavaScript был создан в 1995 году для браузера Netscape	1
404	5	const позволяет переприсваивать значение?	const запрещает переприсваивание значения	1
406	5	Оператор == сравнивает значения без приведения типов?	== сравнивает с приведением типов, === без приведения	1
407	5	Стрелочные функции имеют свой this?	Стрелочные функции берут this из внешнего контекста	1
408	5	Function declaration поднимается вверх области видимости?	Function declaration поднимается и доступна до объявления	1
409	5	Function expression поднимается вверх области видимости?	Function expression не поднимается и доступна только после присваивания	1
411	5	forEach() возвращает новый массив?	forEach() не возвращает новый массив, в отличие от map()	1
412	5	filter() создаёт новый массив?	filter() создаёт новый массив с элементами, прошедшими проверку	1
413	5	reduce() сворачивает массив к одному значению?	reduce() сворачивает массив к одному значению через аккумулятор	1
414	5	Promise имеет состояние "pending"?	Promise имеет 3 состояния: pending, fulfilled, rejected	1
415	5	async/await - это синтаксический сахар над Promise?	async/await позволяет писать асинхронный код как синхронный	1
416	5	DOM - это объектная модель HTML-документа?	DOM (Document Object Model) — объектная модель HTML-документа	1
417	5	querySelector возвращает все элементы по селектору?	querySelector возвращает первый элемент, querySelectorAll - все	1
418	5	classList.add() добавляет класс к элементу?	classList.add() добавляет класс, если его ещё нет	1
419	5	appendChild() добавляет элемент в начало родителя?	appendChild() добавляет в конец, prepend() - в начало	1
420	5	События в DOM всплывают снизу вверх?	События всплывают от целевого элемента к родителям	1
421	5	this в стрелочной функции ссылается на функцию?	this в стрелочной функции ссылается на внешний контекст	1
422	5	bind() создаёт новую функцию с привязанным this?	bind() создаёт новую функцию с привязанным контекстом	1
423	5	Генераторы в JS могут возвращать несколько значений?	Генераторы используют yield для возврата нескольких значений	1
424	5	typeof null возвращает "null"?	typeof null возвращает "object" (историческая ошибка)	1
425	5	NaN равен самому себе?	NaN не равен самому себе, NaN === NaN возвращает false	1
426	5	Что такое JavaScript?	Интерпретируемый язык для веб-страниц	2
427	5	Кто создал JavaScript?	Брендан Эйх	2
428	5	В каком году создан JavaScript?	1995	2
429	5	Сколько типов данных в JavaScript?	8 типов (7 примитивных, 1 ссылочный)	2
430	5	Как объявить переменную в JavaScript?	var, let или const	2
431	5	В чем отличие var от let?	var - функциональная, let - блочная область	2
432	5	В чем отличие let от const?	const нельзя переопределить, let можно	2
433	5	Что такое undefined?	Переменная объявлена, но не инициализирована	2
434	5	Что такое null?	Специальное значение "ничего"	2
435	5	Что такое NaN?	Not a Number	2
436	5	Как проверить тип переменной?	Оператор typeof	2
437	5	Что такое оператор ==?	Сравнение с приведением типов	2
438	5	Что такое оператор ===?	Строгое сравнение без приведения	2
403	5	let имеет блочную область видимости в js?	let имеет блочную область видимости и не поднимается	1
405	5	null в js - это то же самое, что undefined?	null явно указывает на отсутствие объекта, undefined — переменная не инициализирована	1
439	5	Что такое замыкание?	Функция, запоминающая своё окружение	2
440	5	Что такое стрелочная функция?	Синтаксис () => {} с лексическим this	2
441	5	Что такое функция высшего порядка?	Функция, принимающая или возвращающая функцию	2
442	5	Что такое колбэк?	Функция, переданная как аргумент	2
443	5	Что такое IIFE?	Немедленно вызываемая функция	2
444	5	Что такое prototype?	Механизм наследования в JavaScript	2
445	5	Что такое классы в JS?	Синтаксический сахар над прототипами	2
446	5	Что такое Promise?	Объект для работы с асинхронными операциями	2
447	5	Что такое async/await?	Синтаксический сахар для Promise	2
448	5	Что такое DOM?	Представление HTML-документа	2
449	5	Что такое ES6?	Стандарт ECMAScript 2015	2
450	5	Что такое this в JavaScript?	Контекст выполнения функции	2
451	5	Какие примитивные типы данных есть в JavaScript?	number, string, boolean, null, undefined, symbol, bigint	3
452	5	Какие способы объявления переменных есть в JavaScript?	var, let, const	3
453	5	Какие значения являются фальшивыми?	false, 0, "", null, undefined, NaN	3
454	5	Какие способы объявления функций существуют?	Function declaration, function expression, стрелочные функции	3
455	5	Какие методы массивов создают новый массив?	map, filter, slice, concat	3
456	5	Какие методы массивов изменяют исходный массив?	push, pop, shift, unshift, splice, sort, reverse	3
457	5	Какие методы массивов возвращают один элемент?	find, findIndex	3
458	5	Какие методы массивов проверяют условия?	some, every, includes	3
459	5	Какие методы работы со строками существуют?	trim, split, join, replace, replaceAll, startsWith, endsWith	3
460	5	Какие состояния есть у Promise?	pending, fulfilled, rejected	3
461	5	Какие методы есть у Promise?	then, catch, finally	3
462	5	Какие методы для работы с DOM существуют?	getElementById, querySelector, querySelectorAll, getElementsByClassName	3
463	5	Какие методы для работы с классами есть?	classList.add, classList.remove, classList.toggle, classList.contains	3
464	5	Какие методы для добавления элементов в DOM?	appendChild, append, prepend, insertBefore	3
465	5	Какие методы для удаления элементов из DOM?	remove, removeChild	3
466	5	Какие способы создания объектов существуют?	Литерал {}, new Object(), Object.create(), классы	3
467	5	Какие методы для проверки свойств объекта существуют?	in, hasOwnProperty, Object.hasOwn	3
468	5	Какие методы для работы с прототипами есть?	Object.getPrototypeOf, Object.setPrototypeOf, Object.create	3
469	5	Какие методы для привязки this существуют?	bind, call, apply	3
470	5	Какие методы для работы с JSON есть?	JSON.stringify, JSON.parse	3
471	5	Какие методы работы с датой есть?	new Date(), Date.now(), getTime(), toISOString	3
472	5	Какие методы работы с числами есть?	Number, parseInt, parseFloat, isNaN, isFinite	3
473	5	Какие методы работы с регулярными выражениями есть?	test, exec, match, replace, search	3
474	5	Какие события DOM существуют?	click, input, submit, load, DOMContentLoaded, keydown	3
475	5	Какие методы для управления классами в JS?	classList.add, classList.remove, classList.toggle, classList.contains	3
476	5	Как называется создатель JavaScript? (введите имя)	Брендан Эйх	4
477	5	В каком году был создан JavaScript? (введите число)	1995	4
478	5	Как называется оператор для строгого сравнения? (введите символы)	===	4
479	5	Как называется оператор для сравнения с приведением? (введите символы)	==	4
480	5	Как объявить переменную с блочной областью видимости? (введите ключевое слово)	let	4
481	5	Как объявить переменную, которую нельзя переопределить? (введите ключевое слово)	const	4
482	5	Как называется механизм наследования в JS? (введите термин)	prototype	4
483	5	Как называется функция, вызывающая саму себя? (введите термин)	рекурсия	4
484	5	Как называется функция, запоминающая своё окружение? (введите термин)	замыкание	4
485	5	Как называется немедленно вызываемая функция? (введите аббревиатуру)	IIFE	4
486	5	Как называется объект для работы с асинхронными операциями? (введите термин)	Promise	4
487	5	Как называется синтаксический сахар для Promise? (введите ключевые слова)	async/await	4
1027	11	Кто создал Java?	Джеймс Гослинг	2
488	5	Как называется метод массива, создающий новый массив с результатами функции? (введите название)	map	4
489	5	Как называется метод массива, создающий новый массив по условию? (введите название)	filter	4
490	5	Как называется метод массива, сворачивающий массив к одному значению? (введите название)	reduce	4
491	5	Как называется метод массива, проверяющий наличие элемента? (введите название)	includes	4
492	5	Как называется метод массива, выполняющий функцию для каждого элемента? (введите название)	forEach	4
493	5	Как называется метод строки для разбиения на массив? (введите название)	split	4
494	5	Как называется метод строки для объединения массива в строку? (введите название)	join	4
495	5	Как называется объектная модель HTML-документа? (введите аббревиатуру)	DOM	4
496	5	Как найти элемент по CSS-селектору? (введите метод)	querySelector	4
497	5	Как добавить класс к элементу? (введите метод)	classList.add	4
498	5	Как удалить класс из элемента? (введите метод)	classList.remove	4
499	5	Как создать новый элемент в DOM? (введите метод)	document.createElement	4
500	5	Как добавить обработчик события? (введите метод)	addEventListener	4
501	6	В Python всё является объектом?	Python полностью объектно-ориентированный: всё является объектом, включая функции и классы	1
502	6	Tuple является изменяемым типом данных?	Tuple — неизменяемый тип данных, в отличие от list	1
503	6	Строки в Python являются неизменяемыми?	Строки в Python неизменяемы, любые операции создают новую строку	1
504	6	Оператор == сравнивает ссылки на объекты?	== сравнивает значения, is сравнивает ссылки (идентичность)	1
505	6	Функция id() возвращает хеш объекта?	id() возвращает уникальный идентификатор объекта (адрес в памяти)	1
506	6	GIL позволяет выполнять код на нескольких ядрах одновременно?	GIL разрешает выполнение байт-кода только в одном потоке за раз	1
507	6	В Python есть множественное наследование?	Да, Python поддерживает множественное наследование	1
508	6	Аннотации типов в Python проверяются во время выполнения?	Аннотации типов не проверяются во время выполнения, используются для статического анализа	1
509	6	None и Null в Python — это одно и то же?	В Python используется None, Null нет. None — объект-синглтон	1
510	6	Лямбда-функции могут содержать несколько выражений?	Лямбда-функции могут содержать только одно выражение	1
511	6	Декораторы изменяют исходный код функции?	Декораторы оборачивают функцию, изменяя её поведение без изменения исходного кода	1
512	6	Модуль csv входит в стандартную библиотеку Python?	Да, csv — встроенный модуль для работы с CSV-файлами	1
513	6	pip является единственным менеджером пакетов в Python?	Существуют также poetry, pipenv, conda и другие	1
514	6	pass — это оператор, который ничего не делает?	pass — оператор-заглушка, который ничего не делает	1
515	6	Ключевое слово global позволяет изменять локальную переменную?	global позволяет работать с глобальной переменной внутри функции	1
516	6	Метаклассы создают экземпляры классов?	Метаклассы создают классы, а классы создают экземпляры	1
517	6	В Python есть switch-case конструкция?	В Python 3.10+ есть match-case для структурного сопоставления	1
518	6	Модуль re входит в стандартную библиотеку Python?	Да, re — встроенный модуль для работы с регулярными выражениями	1
519	6	Dict и Set используют хеш-таблицы для хранения данных?	Dict и Set реализованы как хеш-таблицы	1
520	6	Списки в Python могут содержать элементы разных типов?	Да, списки могут содержать элементы любых типов	1
521	6	Цикл for в Python всегда создаёт новую область видимости?	Цикл for не создаёт новую область видимости в Python	1
522	6	В Python есть оптимизация хвостовой рекурсии?	Нет, Python не оптимизирует хвостовую рекурсию	1
523	6	Модуль typing используется для проверки типов во время выполнения?	typing используется для аннотаций, проверка через mypy статически	1
524	6	Контекстный менеджер всегда освобождает ресурсы при исключении?	with гарантирует вызов __exit__ даже при исключении	1
525	6	Функция dir() возвращает список методов объекта?	dir() возвращает список атрибутов и методов объекта	1
526	6	Какие изменяемые типы данных есть в Python?	list, dict, set, bytearray	2
527	6	Какие неизменяемые типы данных есть в Python?	int, str, tuple, frozenset, bytes	2
528	6	Что такое лямбда-функция?	Анонимная функция для простых операций в одну строку	2
529	6	Что такое docstring?	Строка документации в тройных кавычках	2
530	6	В чём разница между list и tuple?	list изменяемый, tuple неизменяемый	2
531	6	Что такое self в Python?	Ссылка на текущий экземпляр класса	2
532	6	Что такое декоратор?	Функция, расширяющая поведение другой функции	2
533	6	Что может быть ключом в словаре?	Неизменяемые (hashable) объекты	2
534	6	Что такое генератор?	Функция с yield, генерирующая значения лениво	2
535	6	Что такое итератор?	Объект с __iter__() и __next__() для обхода	2
536	6	Что такое контекстный менеджер?	Объект с __enter__() и __exit__() для управления ресурсами	2
537	6	Что такое GIL?	Глобальная блокировка интерпретатора	2
538	6	Что такое MRO?	Порядок разрешения методов (алгоритм C3)	2
539	6	Что такое __slots__?	Ограничивает атрибуты и экономит память	2
540	6	Что такое метакласс?	Класс, создающий другие классы	2
541	6	Что такое PEP8?	Руководство по стилю кода Python	2
542	6	Что такое аннотации типов?	Указание ожидаемых типов для статической проверки	2
543	6	Что такое asyncio?	Библиотека для асинхронного программирования	2
544	6	Что такое dataclasses?	Декоратор для автоматической генерации методов	2
545	6	Что такое enum?	Модуль для создания перечислений	2
546	6	Что такое f-строки?	Форматированные строки с префиксом f	2
547	6	Что такое __name__ == "__main__"?	Проверка прямого запуска скрипта	2
548	6	Что такое __repr__?	Формальное представление объекта для разработчиков	2
549	6	Что такое __str__?	Читаемое представление объекта для пользователей	2
550	6	Что такое walrus оператор?	Оператор := для присваивания в выражении	2
551	6	Какие изменяемые типы данных существуют в Python?	list, dict, set, bytearray	3
552	6	Какие неизменяемые типы данных существуют в Python?	int, str, tuple, frozenset, bytes	3
553	6	Какие способы создания классов существуют?	class, type(), метаклассы, dataclasses	3
554	6	Какие методы для проверки типов существуют?	type(), isinstance(), issubclass	3
555	6	Какие функции для работы с последовательностями существуют?	len(), min(), max(), sorted(), reversed(), sum()	3
556	6	Какие методы для работы со строками существуют?	lower(), upper(), split(), join(), replace(), strip()	3
557	6	Какие методы для работы со списками существуют?	append(), pop(), insert(), remove(), sort(), reverse()	3
558	6	Какие методы для работы со словарями существуют?	get(), keys(), values(), items(), update(), pop()	3
559	6	Какие методы для работы с множествами существуют?	add(), remove(), union(), intersection(), difference()	3
560	6	Какие встроенные функции высшего порядка существуют?	map(), filter(), reduce(), sorted()	3
561	6	Какие декораторы используются в классах?	@classmethod, @staticmethod, @property	3
562	6	Какие менеджеры пакетов существуют для Python?	pip, poetry, pipenv, conda	3
563	6	Какие библиотеки для анализа данных существуют?	numpy, pandas, matplotlib, scipy, sklearn	3
564	6	Какие библиотеки для веб-разработки существуют?	django, flask, fastapi, aiohttp	3
565	6	Какие инструменты для статического анализа кода существуют?	pylint, flake8, mypy, black	3
566	6	Какие способы создания копий объектов существуют?	copy.copy(), copy.deepcopy(), присваивание	3
567	6	Какие методы для работы с файлами существуют?	open(), read(), write(), close(), with	3
568	6	Какие модули для работы с файлами и путями существуют?	os, pathlib, shutil, tempfile, glob	3
569	6	Какие протоколы итерации существуют?	__iter__(), __next__(), iter(), next()	3
570	6	Какие методы для работы с датой и временем существуют?	datetime, time, calendar, dateutil	3
571	6	Какие модули для работы с сериализацией существуют?	json, pickle, xml, csv, yaml	3
572	6	Какие методы для обработки исключений существуют?	try, except, else, finally, raise	3
573	6	Какие способы импорта модулей существуют?	import, from ... import, importlib	3
574	6	Какие методы для работы с регулярными выражениями существуют?	re.search(), re.match(), re.findall(), re.sub()	3
575	6	Какие способы многозадачности существуют в Python?	threading, multiprocessing, asyncio, concurrent.futures	3
576	6	Как называется анонимная функция в Python? (введите название)	лямбда	4
577	6	Как называется неизменяемый тип данных, похожий на список? (введите название)	tuple	4
578	6	Как называется строка документации в тройных кавычках? (введите термин)	docstring	4
579	6	Как называется ссылка на текущий экземпляр класса? (введите ключевое слово)	self	4
580	6	Как называется функция, расширяющая поведение другой функции? (введите термин)	декоратор	4
581	6	Как называется функция с yield, генерирующая значения лениво? (введите термин)	генератор	4
582	6	Как называется объект с __iter__() и __next__()? (введите термин)	итератор	4
583	6	Как называется глобальная блокировка интерпретатора? (введите аббревиатуру)	GIL	4
584	6	Как называется порядок разрешения методов? (введите аббревиатуру)	MRO	4
585	6	Как называется руководство по стилю кода Python? (введите название)	PEP8	4
586	6	Как называется библиотека для асинхронного программирования? (введите название)	asyncio	4
587	6	Как называется декоратор для автоматической генерации методов? (введите название)	dataclasses	4
588	6	Как называется модуль для создания перечислений? (введите название)	enum	4
589	6	Как называется оператор := в Python? (введите название)	walrus	4
590	6	Как называется проверка прямого запуска скрипта? (введите выражение)	__name__ == "__main__"	4
591	6	Как называется формальное представление объекта? (введите метод)	__repr__	4
592	6	Как называется читаемое представление объекта? (введите метод)	__str__	4
593	6	Как называется модуль для аннотаций типов? (введите название)	typing	4
594	6	Как называется менеджер контекста для работы с файлами? (введите ключевое слово)	with	4
595	6	Как называется оператор-заглушка, который ничего не делает? (введите ключевое слово)	pass	4
596	6	Как называется функция для просмотра атрибутов объекта? (введите название)	dir	4
597	6	Как называется функция для получения документации? (введите название)	help	4
598	6	Как называется модуль для отладки кода? (введите название)	pdb	4
599	6	Как называется модуль для работы с регулярными выражениями? (введите название)	re	4
600	6	Как называется модуль для работы с операционной системой? (введите название)	os	4
601	7	Ядро Linux было создано Линусом Торвальдсом?	Линус Торвальдс создал ядро Linux в 1991 году	1
602	7	Linux является Unix-подобной операционной системой?	Linux — семейство Unix-подобных ОС с открытым исходным кодом	1
603	7	Bash является интерпретатором командной строки?	Bash — наиболее популярный командный интерпретатор	1
604	7	Файловая система ext4 является журналируемой?	ext4 поддерживает журналирование для восстановления после сбоев	1
605	7	Символическая ссылка указывает на inode файла?	Символическая ссылка указывает на имя файла, жесткая — на inode	1
606	7	Жесткая ссылка может указывать на каталог?	Жесткая ссылка не может указывать на каталоги	1
607	7	SUID бит позволяет выполнять файл с правами владельца?	SUID позволяет выполнять файл с правами владельца	1
608	7	Sticky bit на каталоге позволяет удалять файлы любому пользователю?	Sticky bit позволяет удалять файлы только владельцу	1
609	7	systemd является системой инициализации?	Systemd — система инициализации, управляющая службами	1
610	7	PID является уникальным идентификатором процесса?	PID — уникальный идентификатор процесса	1
611	7	Команда pwd показывает содержимое текущего каталога?	pwd показывает текущий каталог, ls — содержимое	1
612	7	Команда rm удаляет файлы без возможности восстановления?	rm удаляет файлы без возможности восстановления	1
662	7	Какие команды для управления правами существуют?	chmod, chown, chgrp	3
613	7	Команда grep ищет файлы в системе?	grep ищет текст в файлах, find — файлы	1
614	7	Команда df показывает свободное место на дисках?	df показывает свободное место на файловых системах	1
615	7	Символ & в конце команды запускает процесс в фоне?	& запускает процесс в фоне, освобождая терминал	1
616	7	SIGTERM принудительно завершает процесс?	SIGTERM корректно завершает процесс, SIGKILL — принудительно	1
617	7	Cron выполняет задачи по расписанию?	Cron — планировщик задач по расписанию	1
618	7	journalctl показывает логи systemd?	journalctl показывает логи systemd	1
619	7	Пользователь root имеет ограниченные права?	Root — суперпользователь с полными правами	1
620	7	APT является менеджером пакетов в Red Hat?	APT используется в Debian/Ubuntu, DNF/YUM — в Red Hat	1
621	7	SSH шифрует весь трафик удалённого доступа?	SSH шифрует весь трафик, обеспечивая безопасность	1
622	7	SELinux используется только в Ubuntu?	SELinux используется в RHEL, AppArmor — в Ubuntu	1
623	7	Демоны в Linux работают в фоновом режиме?	Демоны — фоновые процессы без привязки к терминалу	1
624	7	Команда chown изменяет права доступа к файлу?	chown изменяет владельца, chmod — права доступа	1
625	7	Файл /etc/passwd содержит хеши паролей пользователей?	/etc/passwd содержит основные данные, /etc/shadow — хеши паролей	1
626	7	Что такое Linux?	Семейство Unix-подобных ОС с открытым исходным кодом	2
627	7	Кто создал ядро Linux?	Линус Торвальдс	2
628	7	Что такое дистрибутив Linux?	Сборка ядра с ПО и менеджером пакетов	2
629	7	Что такое ядро Linux?	Центральная часть ОС, управляющая аппаратными ресурсами	2
630	7	Что такое Shell?	Интерпретатор командной строки	2
631	7	Что такое Bash?	Наиболее популярный командный интерпретатор	2
632	7	Что такое файловая система?	Способ организации и хранения файлов на диске	2
633	7	Что такое inode?	Структура данных с метаданными файла	2
634	7	Что такое символическая ссылка?	Файл, указывающий на другой файл или каталог	2
635	7	Что такое жесткая ссылка?	Прямая ссылка на inode файла	2
636	7	Что такое mount?	Подключение файловой системы к корневому каталогу	2
637	7	Что такое демон?	Фоновый процесс без привязки к терминалу	2
638	7	Что такое PID?	Уникальный идентификатор процесса	2
639	7	Что такое systemd?	Современная система инициализации и управления службами	2
640	7	Что такое пользователь root?	Суперпользователь с полными правами	2
641	7	Какая команда показывает текущий каталог?	pwd	2
642	7	Какая команда меняет каталог?	cd	2
643	7	Какая команда выводит содержимое каталога?	ls	2
644	7	Какая команда создает каталог?	mkdir	2
645	7	Какая команда удаляет файлы и каталоги?	rm	2
646	7	Какая команда копирует файлы?	cp	2
647	7	Какая команда перемещает файлы?	mv	2
648	7	Какая команда находит файлы?	find	2
649	7	Какая команда ищет текст в файлах?	grep	2
650	7	Какая команда показывает дисковое пространство?	df	2
651	7	Какие менеджеры пакетов существуют в Linux?	APT, DNF/YUM, Pacman, Zypper	3
652	7	Какие системы инициализации существуют в Linux?	Systemd, SysV init, Upstart, OpenRC	3
653	7	Какие команды для просмотра содержимого файлов существуют?	cat, less, more, head, tail	3
654	7	Какие права доступа существуют в Linux?	Чтение (r), запись (w), выполнение (x)	3
655	7	Какие команды для управления процессами существуют?	ps, top, htop, kill, pkill	3
656	7	Какие сигналы для завершения процессов существуют?	SIGTERM, SIGKILL, SIGHUP	3
657	7	Какие команды для управления файрволом существуют?	iptables, ufw, firewalld	3
658	7	Какие команды для работы с сетью существуют?	ping, traceroute, nslookup, dig, curl, wget	3
659	7	Какие команды для управления пользователями существуют?	useradd, usermod, userdel, passwd	3
660	7	Какие каталоги для системных логов существуют?	/var/log/syslog, /var/log/auth.log, /var/log/kern.log	3
661	7	Какие команды для работы с архивами существуют?	tar, gzip, bzip2, xz, zip	3
663	7	Какие команды для управления systemd существуют?	systemctl start, systemctl stop, systemctl restart, systemctl status, systemctl enable	3
664	7	Какие типы ссылок существуют в Linux?	Символическая ссылка, жесткая ссылка	3
665	7	Какие команды для просмотра процессов пользователя существуют?	ps -u, top -u, htop -u	3
666	7	Какие команды для изменения приоритета процесса существуют?	nice, renice	3
667	7	Какие команды для сетевых интерфейсов существуют?	ip, ifconfig, ip link, ip addr	3
668	7	Какие команды для проверки сетевых соединений существуют?	ss, netstat, lsof -i	3
669	7	Какие команды для управления cron существуют?	crontab -e, crontab -l, crontab -r	3
670	7	Какие команды для работы с SSH существуют?	ssh, ssh-keygen, ssh-copy-id	3
671	7	Какие типы файлов существуют в Linux?	Обычный файл, каталог, символьная ссылка, блочное устройство, символьное устройство, сокет, pipe	3
672	7	Какие команды для проверки целостности файлов существуют?	md5sum, sha256sum, sha512sum	3
673	7	Какие системы контроля доступа существуют?	SELinux, AppArmor, Tomoyo	3
674	7	Какие команды для работы с репозиториями в Ubuntu?	apt update, apt install, apt remove, add-apt-repository	3
675	7	Какие оболочки командной строки существуют?	Bash, Zsh, Fish, Sh, Ksh	3
676	7	Как называется создатель ядра Linux? (введите имя)	Линус Торвальдс	4
677	7	Как называется популярный командный интерпретатор Linux? (введите название)	Bash	4
678	7	Как называется команда для смены каталога? (введите команду)	cd	4
679	7	Как называется команда для вывода содержимого каталога? (введите команду)	ls	4
680	7	Как называется команда для создания каталога? (введите команду)	mkdir	4
681	7	Как называется команда для удаления файлов? (введите команду)	rm	4
682	7	Как называется команда для копирования файлов? (введите команду)	cp	4
683	7	Как называется команда для перемещения файлов? (введите команду)	mv	4
684	7	Как называется команда для поиска файлов? (введите команду)	find	4
685	7	Как называется команда для поиска текста в файлах? (введите команду)	grep	4
686	7	Как называется команда для показа дискового пространства? (введите команду)	df	4
687	7	Как называется команда для изменения прав доступа? (введите команду)	chmod	4
688	7	Как называется команда для изменения владельца? (введите команду)	chown	4
689	7	Как называется суперпользователь Linux? (введите имя)	root	4
690	7	Как называется система инициализации в современных дистрибутивах? (введите название)	systemd	4
691	7	Как называется планировщик задач в Linux? (введите название)	cron	4
692	7	Как называется протокол безопасного удалённого доступа? (введите аббревиатуру)	SSH	4
693	7	Как называется команда для управления службами systemd? (введите команду)	systemctl	4
694	7	Как называется команда для просмотра логов systemd? (введите команду)	journalctl	4
695	7	Как называется менеджер пакетов в Ubuntu? (введите аббревиатуру)	APT	4
696	7	Как называется менеджер пакетов в Fedora? (введите аббревиатуру)	DNF	4
697	7	Как называется система контроля доступа в RHEL? (введите название)	SELinux	4
698	7	Как называется система контроля доступа в Ubuntu? (введите название)	AppArmor	4
699	7	Как называется файл с информацией о пользователях? (введите путь)	/etc/passwd	4
700	7	Как называется файл с хешами паролей? (введите путь)	/etc/shadow	4
701	8	Тестирование ПО — это процесс проверки соответствия требованиям?	Тестирование — процесс проверки ПО на соответствие требованиям и выявление дефектов	1
702	8	Верификация отвечает на вопрос "правильно ли мы строим продукт?"?	Верификация проверяет соответствие спецификациям, отвечая на вопрос "правильно ли строим"	1
703	8	Валидация отвечает на вопрос "тот ли продукт мы строим?"?	Валидация проверяет удовлетворение потребностей пользователя, отвечая на вопрос "то ли строим"	1
704	8	Дефект — это действие человека, приводящее к ошибке?	Дефект — несоответствие фактического результата ожидаемому, ошибка — действие человека	1
705	8	Модульное тестирование выполняется командой тестирования?	Модульное тестирование выполняется разработчиками, а не командой тестирования	1
706	8	Интеграционное тестирование проверяет взаимодействие модулей?	Интеграционное тестирование проверяет взаимодействие модулей и интерфейсы между ними	1
707	8	Системное тестирование проверяет полностью интегрированную систему?	Системное тестирование проверяет полностью интегрированную систему	1
708	8	Приемочное тестирование проводится разработчиками?	Приемочное тестирование проводится с участием заказчика или конечных пользователей	1
709	8	Тестирование белого ящика выполняется без доступа к коду?	Белый ящик — с доступом к коду, черный ящик — без доступа	1
710	8	Статическое тестирование выполняется без запуска кода?	Статическое тестирование анализирует код без выполнения	1
711	8	Эквивалентное разбиение проверяет граничные значения?	Эквивалентное разбиение делит данные на классы, анализ границ проверяет граничные значения	1
712	8	Негативное тестирование использует корректные данные?	Негативное тестирование использует некорректные данные, позитивное — корректные	1
713	8	Регрессионное тестирование проверяет новые функции?	Регрессионное тестирование проверяет, что изменения не нарушили существующую функциональность	1
714	8	Смоук-тестирование — это детальное тестирование?	Смоук-тестирование — базовая проверка критической функциональности	1
715	8	Альфа-тестирование проводится с участием реальных пользователей?	Альфа-тестирование проводится внутри компании, бета — с реальными пользователями	1
716	8	Приоритет бага — это техническая серьезность проблемы?	Приоритет — важность для бизнеса, серьезность — техническая критичность	1
717	8	Автоматизация тестирования полностью заменяет ручное тестирование?	Автоматизация не заменяет ручное тестирование полностью, дополняет его	1
718	8	Selenium используется для тестирования мобильных приложений?	Selenium — для веб-приложений, Appium — для мобильных	1
719	8	TDD — это разработка через поведение?	TDD — разработка через тестирование (сначала тест, потом код)	1
720	8	BDD использует сценарии Given-When-Then?	BDD описывает поведение на естественном языке Given-When-Then	1
721	8	Shift-left подход смещает тестирование на поздние этапы?	Shift-left смещает тестирование на ранние этапы разработки	1
722	8	Exploratory testing выполняется по заранее написанным тест-кейсам?	Exploratory testing — исследовательское тестирование без предварительной подготовки	1
723	8	Плотность дефектов — это количество дефектов на 1000 строк кода?	Плотность дефектов — количество дефектов на 1000 строк кода	1
724	8	Ревью кода — это автоматическая проверка кода?	Ревью кода — проверка кода другими разработчиками, а не автоматическая	1
725	8	Тестирование API проверяет графический интерфейс?	API тестирование проверяет программные интерфейсы, UI — графический интерфейс	1
726	8	Что такое тестирование ПО?	Процесс проверки ПО на соответствие требованиям	2
727	8	Какие основные цели тестирования?	Обнаружение дефектов, проверка соответствия, оценка качества	2
728	8	Что такое верификация?	Проверка соответствия продукта спецификациям	2
729	8	Что такое валидация?	Проверка удовлетворения потребностей пользователя	2
730	8	Что такое дефект?	Несоответствие фактического результата ожидаемому	2
731	8	Какие уровни тестирования существуют?	Модульное, интеграционное, системное, приемочное	2
732	8	Что такое модульное тестирование?	Тестирование отдельных компонентов в изоляции	2
733	8	Что такое интеграционное тестирование?	Тестирование взаимодействия между модулями	2
734	8	Что такое системное тестирование?	Тестирование полностью интегрированной системы	2
735	8	Что такое приемочное тестирование?	Тестирование готовности системы к передаче заказчику	2
811	9	NTFS — это файловая система для Linux?	NTFS — файловая система Windows, ext4 — для Linux	1
736	8	Что такое регрессионное тестирование?	Проверка, что изменения не нарушили существующую функциональность	2
737	8	Что такое смоук-тестирование?	Базовая проверка критической функциональности	2
738	8	Что такое тест-кейс?	Набор условий, шагов и ожидаемых результатов	2
739	8	Что такое баг-репорт?	Документ с описанием дефекта	2
740	8	Что такое тестовое покрытие?	Мера покрытия кода или требований тестами	2
741	8	Что такое автоматизация тестирования?	Использование инструментов для автоматического выполнения тестов	2
742	8	Что такое Selenium?	Фреймворк для автоматизации веб-приложений	2
743	8	Что такое JUnit?	Фреймворк для модульного тестирования Java	2
744	8	Что такое CI/CD?	Практика автоматической сборки, тестирования и развертывания	2
745	8	Что такое TDD?	Разработка через тестирование (сначала тест, потом код)	2
746	8	Что такое BDD?	Разработка через поведение с Given-When-Then сценариями	2
747	8	Что такое нагрузочное тестирование?	Тестирование поведения системы под нагрузкой	2
748	8	Что такое стресс-тестирование?	Тестирование за пределами нормальной нагрузки	2
749	8	Что такое API тестирование?	Тестирование интерфейсов программного взаимодействия	2
750	8	Что такое качество ПО?	Степень удовлетворения требованиям и ожиданиям	2
751	8	Какие уровни тестирования существуют?	Модульное, интеграционное, системное, приемочное	3
752	8	Какие виды тестирования по доступу к коду существуют?	Белый ящик, черный ящик, серый ящик	3
753	8	Какие техники тест-дизайна существуют?	Эквивалентное разбиение, анализ граничных значений, таблицы решений, попарное тестирование	3
754	8	Какие атрибуты тест-кейса существуют?	ID, название, предусловия, шаги, ожидаемый результат, приоритет	3
755	8	Какие атрибуты баг-репорта существуют?	ID, заголовок, приоритет, серьезность, шаги воспроизведения, фактический/ожидаемый результат	3
756	8	Какие статусы бага существуют?	New, Assigned, Open, Fixed, Retest, Verified, Closed	3
757	8	Какие метрики тестирования существуют?	Плотность дефектов, эффективность, процент прохождения, покрытие кода	3
758	8	Какие преимущества автоматизации тестирования?	Скорость, повторяемость, уменьшение человеческого фактора	3
759	8	Какие недостатки автоматизации тестирования?	Высокие затраты на разработку, поддержку, не все тесты автоматизируемы	3
760	8	Какие фреймворки для автоматизации тестирования существуют?	Selenium, JUnit, PyTest, TestNG	3
761	8	Какие паттерны используются в автоматизации?	Page Object Model, Factory, Singleton	3
762	8	Какие виды тестирования производительности существуют?	Нагрузочное, стресс-тестирование, объемное, тестирование стабильности	3
763	8	Какие подходы к разработке ПО существуют?	TDD, BDD, ATDD, Waterfall, Agile	3
764	8	Какие инструменты тест-менеджмента существуют?	TestRail, Zephyr, PractiTest, Xray, qTest	3
765	8	Какие баг-трекинг системы существуют?	Jira, Bugzilla, Mantis, Redmine	3
766	8	Какие характеристики качества ПО существуют?	Функциональность, надежность, удобство, эффективность, сопровождаемость	3
767	8	Какие виды статического тестирования существуют?	Ревью кода, инспекции, статический анализ инструментами	3
768	8	Какие виды динамического тестирования существуют?	Модульное, интеграционное, системное, приемочное	3
769	8	Какие виды тестирования по времени выполнения существуют?	Статическое, динамическое	3
770	8	Какие этапы жизненного цикла бага?	Обнаружение, регистрация, назначение, исправление, проверка, закрытие	3
771	8	Какие критерии для автоматизации тестов?	Частота запуска, повторяемость, объем данных, критичность	3
772	8	Какие типы тестовых данных существуют?	Валидные, невалидные, граничные, случайные	3
773	8	Какие компоненты тестового окружения?	Аппаратное обеспечение, ПО, сеть, тестовые данные	3
774	8	Какие метрики покрытия кода существуют?	Покрытие строк, покрытие ветвей, покрытие функций	3
775	8	Какие виды приемочного тестирования существуют?	Альфа-тестирование, бета-тестирование, UAT, приемочное тестирование	3
776	8	Как называется процесс проверки ПО на соответствие требованиям? (введите термин)	тестирование	4
777	8	Как называется проверка соответствия продукта спецификациям? (введите термин)	верификация	4
778	8	Как называется проверка удовлетворения потребностей пользователя? (введите термин)	валидация	4
779	8	Как называется несоответствие фактического результата ожидаемому? (введите термин)	дефект	4
780	8	Как называется тестирование отдельных компонентов в изоляции? (введите термин)	модульное	4
781	8	Как называется тестирование взаимодействия между модулями? (введите термин)	интеграционное	4
782	8	Как называется тестирование полностью интегрированной системы? (введите термин)	системное	4
783	8	Как называется тестирование готовности системы к передаче заказчику? (введите термин)	приемочное	4
784	8	Как называется тестирование с доступом к коду? (введите термин)	белый ящик	4
785	8	Как называется тестирование без доступа к коду? (введите термин)	черный ящик	4
786	8	Как называется техника тест-дизайна с классами эквивалентности? (введите термин)	эквивалентное разбиение	4
787	8	Как называется набор условий, шагов и ожидаемых результатов? (введите термин)	тест-кейс	4
788	8	Как называется документ с описанием дефекта? (введите термин)	баг-репорт	4
789	8	Как называется проверка, что изменения не нарушили существующую функциональность? (введите термин)	регрессионное	4
790	8	Как называется базовая проверка критической функциональности? (введите термин)	смоук	4
791	8	Как называется фреймворк для автоматизации веб-приложений? (введите название)	Selenium	4
792	8	Как называется фреймворк для модульного тестирования Java? (введите название)	JUnit	4
793	8	Как называется практика автоматической сборки и тестирования? (введите аббревиатуру)	CI/CD	4
794	8	Как называется разработка через тестирование? (введите аббревиатуру)	TDD	4
795	8	Как называется разработка через поведение? (введите аббревиатуру)	BDD	4
796	8	Как называется паттерн с классами страниц для автоматизации? (введите термин)	Page Object	4
797	8	Как называется система для управления дефектами? (введите термин)	баг-трекинг	4
798	8	Как называется количество дефектов на 1000 строк кода? (введите термин)	плотность дефектов	4
799	8	Как называется проверка кода другими разработчиками? (введите термин)	ревью	4
800	8	Как называется тестирование интерфейсов программного взаимодействия? (введите аббревиатуру)	API	4
801	9	SSH является протоколом для безопасного удаленного доступа?	SSH обеспечивает безопасное удаленное управление сервером через шифрованный канал	1
802	9	RDP используется для удаленного управления Linux серверами?	RDP используется для Windows, SSH — для Linux	1
803	9	SSH-ключи позволяют входить на сервер без пароля?	SSH-ключи обеспечивают безопасную аутентификацию без пароля	1
804	9	Root-логин по SSH рекомендуется для безопасности?	Root-логин по SSH рекомендуется отключать для безопасности	1
805	9	Стратегия 3-2-1 гарантирует защиту данных?	Стратегия 3-2-1 — лучшая практика для защиты от потери данных	1
806	9	Балансировка нагрузки увеличивает отказоустойчивость системы?	Балансировка распределяет нагрузку между серверами, повышая доступность	1
807	9	SLA определяет гарантированное время доступности системы?	SLA определяет соглашение об уровне обслуживания, включая время доступности	1
808	9	LDAP используется для централизованного управления пользователями?	LDAP — протокол для доступа к службам каталогов	1
809	9	Active Directory является службой каталогов Microsoft?	Active Directory — служба каталогов для управления пользователями и ресурсами	1
810	9	chown изменяет права доступа к файлам?	chown изменяет владельца, chmod — права доступа	1
812	9	SELinux используется в Ubuntu по умолчанию?	SELinux используется в RHEL, AppArmor — в Ubuntu	1
813	9	ufw является низкоуровневым инструментом для работы с брандмауэром?	ufw — простой интерфейс, iptables — низкоуровневый	1
814	9	DDoS-атаки можно предотвратить только с помощью аппаратных средств?	DDoS защита включает CDN, WAF, ограничения скорости, не только аппаратные средства	1
815	9	Инфраструктура как код позволяет воспроизводить инфраструктуру?	IaC описывает инфраструктуру в коде, обеспечивая воспроизводимость	1
816	9	Ansible использует агенты для управления серверами?	Ansible работает без агентов, подключаясь по SSH	1
817	9	Terraform используется для управления конфигурациями серверов?	Terraform — для создания инфраструктуры в облаке, а не управления конфигурациями	1
818	9	Kubernetes является инструментом для оркестрации контейнеров?	Kubernetes — стандарт для оркестрации контейнеров	1
819	9	GitOps использует Git как источник правды для инфраструктуры?	GitOps — подход с Git как источником правды для инфраструктуры	1
820	9	RAID 0 обеспечивает отказоустойчивость?	RAID 0 обеспечивает производительность без отказоустойчивости	1
821	9	LVM позволяет изменять размер томов без перезагрузки?	LVM позволяет гибко управлять размерами логических томов	1
822	9	cgroups используются для ограничения ресурсов процессов?	cgroups — механизм для ограничения ресурсов в Linux	1
823	9	Prometheus используется для мониторинга логов?	Prometheus — для метрик и мониторинга, не для логов	1
824	9	Fail2ban блокирует IP после неудачных попыток входа?	Fail2ban защищает серверы от подбора паролей	1
825	9	CDN используется для ускорения загрузки статического контента?	CDN доставляет контент с серверов, ближайших к пользователю	1
826	9	Что такое администрирование серверов?	Управление, настройка и обслуживание серверов	2
827	9	Какие основные задачи системного администратора?	Установка ПО, мониторинг, безопасность, резервное копирование, управление пользователями	2
828	9	Что такое сервер?	Компьютер или программа, предоставляющая ресурсы и услуги	2
829	9	Что такое удаленное управление?	Управление через сеть без физического доступа	2
830	9	Какие протоколы удаленного управления существуют?	SSH, RDP, VNC, IPMI, iDRAC, iLO	2
831	9	Что такое SSH-ключи?	Пара ключей для безопасного доступа без пароля	2
832	9	Что такое система мониторинга?	ПО для отслеживания состояния серверов и сервисов	2
833	9	Что такое резервное копирование?	Создание копий данных для восстановления	2
834	9	Какие типы резервного копирования существуют?	Полное, инкрементное, дифференциальное	2
835	9	Что такое стратегия 3-2-1?	3 копии, 2 носителя, 1 вне офиса	2
836	9	Что такое кластеризация?	Объединение серверов для отказоустойчивости	2
837	9	Что такое балансировка нагрузки?	Распределение нагрузки между серверами	2
838	9	Что такое SLA?	Соглашение об уровне обслуживания	2
839	9	Как создать пользователя в Linux?	useradd или adduser	2
840	9	Как удалить пользователя в Linux?	userdel или deluser	2
841	9	Как изменить пароль пользователя?	passwd	2
842	9	Как назначить права sudo пользователю?	Добавить в группу sudo или настроить /etc/sudoers	2
843	9	Что такое Active Directory?	Служба каталогов Microsoft для управления пользователями	2
844	9	Что такое LDAP?	Протокол для доступа к службам каталогов	2
845	9	Что такое ACL?	Список контроля доступа для детальных прав	2
846	9	Как настроить веб-сервер Nginx?	Установить и настроить в /etc/nginx/sites-available/	2
847	9	Как настроить веб-сервер Apache?	Установить и настроить в /etc/apache2/sites-available/	2
848	9	Что такое обратный прокси?	Сервер, перенаправляющий запросы к внутренним серверам	2
849	9	Что такое брандмауэр?	Система фильтрации сетевого трафика	2
850	9	Что такое инфраструктура как код?	Управление инфраструктурой через файлы конфигурации	2
851	9	Какие протоколы удаленного управления существуют?	SSH, RDP, VNC, IPMI, iDRAC, iLO, Telnet	3
852	9	Какие инструменты мониторинга существуют?	Nagios, Zabbix, Prometheus, Grafana, Datadog, New Relic	3
853	9	Какие типы резервного копирования существуют?	Полное, инкрементное, дифференциальное, синтетическое	3
854	9	Какие инструменты для резервного копирования существуют?	rsync, Bacula, Amanda, Veeam, Duplicity, Restic, BorgBackup	3
855	9	Какие алгоритмы балансировки нагрузки существуют?	Round-robin, Least connections, IP hash, Weighted, Random	3
856	9	Какие файлы отвечают за пользователей и группы в Linux?	/etc/passwd, /etc/shadow, /etc/group, /etc/gshadow	3
857	9	Какие инструменты управления конфигурациями существуют?	Ansible, Puppet, Chef, SaltStack, Terraform	3
858	9	Какие системы оркестрации контейнеров существуют?	Kubernetes, Docker Swarm, Nomad	3
859	9	Какие IDS/IPS системы существуют?	Snort, Suricata, OSSEC, Wazuh, Fail2ban	3
860	9	Какие команды для мониторинга CPU?	top, htop, mpstat, vmstat, uptime	3
861	9	Какие команды для мониторинга памяти?	free, vmstat, top, htop, /proc/meminfo	3
862	9	Какие команды для мониторинга диска?	df, du, iostat, iotop, dstat	3
863	9	Какие команды для мониторинга сети?	iftop, nethogs, vnstat, iperf, tcpdump	3
864	9	Какие инструменты для управления брандмауэром в Linux?	ufw, firewalld, iptables, nftables	3
865	9	Какие системы контроля доступа существуют?	SELinux, AppArmor, Tomoyo	3
866	9	Какие инструменты для управления паролями и политиками?	/etc/login.defs, pam_pwquality, chage, passwd	3
867	9	Какие типы серверов существуют?	Веб-серверы, файловые серверы, почтовые, DNS, БД, прокси	3
868	9	Какие средства для автоматизации развертывания существуют?	Jenkins, GitLab CI, GitHub Actions, Travis CI, CircleCI	3
869	9	Какие утилиты для работы с дисками и RAID?	mdadm, LVM, fdisk, parted, lsblk	3
870	9	Какие протоколы для передачи файлов существуют?	FTP, SFTP, SCP, RSync, NFS, SMB/CIFS	3
871	9	Какие компоненты системы мониторинга существуют?	Сбор метрик, визуализация, оповещения, анализ логов	3
872	9	Какие методы защиты от DDoS существуют?	CDN, rate limiting, WAF, ограничения по IP	3
873	9	Какие типы SSL/TLS сертификатов существуют?	Domain Validation, Organization Validation, Extended Validation	3
874	9	Какие распределенные файловые системы существуют?	Ceph, GlusterFS, HDFS, MooseFS	3
875	9	Какие инструменты для работы с контейнерами существуют?	Docker, Podman, containerd, CRI-O	3
876	9	Как называется протокол безопасного удаленного доступа в Linux? (введите аббревиатуру)	SSH	4
877	9	Как называется протокол удаленного доступа к Windows? (введите аббревиатуру)	RDP	4
878	9	Как называется пара ключей для безопасного доступа без пароля? (введите термин)	SSH-ключи	4
879	9	Как называется система мониторинга с графиками и визуализацией? (введите название)	Grafana	4
880	9	Как называется система сбора метрик от Prometheus? (введите название)	Grafana	4
881	9	Как называется стратегия с 3 копиями, 2 носителями и 1 вне офиса? (введите числа через дефис)	3-2-1	4
882	9	Как называется объединение серверов для отказоустойчивости? (введите термин)	кластеризация	4
883	9	Как называется распределение нагрузки между серверами? (введите термин)	балансировка	4
884	9	Как называется соглашение об уровне обслуживания? (введите аббревиатуру)	SLA	4
885	9	Как называется команда для создания пользователя в Linux? (введите команду)	useradd	4
886	9	Как называется команда для изменения пароля в Linux? (введите команду)	passwd	4
887	9	Как называется команда для изменения владельца файла? (введите команду)	chown	4
888	9	Как называется команда для изменения прав доступа? (введите команду)	chmod	4
889	9	Как называется команда для добавления пользователя в группу? (введите команду)	usermod	4
890	9	Как называется служба каталогов Microsoft? (введите название)	Active Directory	4
891	9	Как называется протокол для доступа к службам каталогов? (введите аббревиатуру)	LDAP	4
892	9	Как называется список контроля доступа? (введите аббревиатуру)	ACL	4
893	9	Как называется система мандатного контроля доступа в RHEL? (введите название)	SELinux	4
894	9	Как называется система контроля доступа в Ubuntu? (введите название)	AppArmor	4
895	9	Как называется инструмент для блокировки IP при неудачных попытках входа? (введите название)	Fail2ban	4
896	9	Как называется инструмент автоматизации без агентов? (введите название)	Ansible	4
897	9	Как называется инструмент для создания инфраструктуры в облаке? (введите название)	Terraform	4
898	9	Как называется система оркестрации контейнеров от Google? (введите название)	Kubernetes	4
899	9	Как называется подход с Git как источником правды для инфраструктуры? (введите название)	GitOps	4
900	9	Как называется инструмент для работы с RAID в Linux? (введите команду)	mdadm	4
901	10	PHP является серверным языком программирования?	PHP работает на серверной стороне, выполняя код до отправки HTML клиенту	1
902	10	PHP был создан Расмусом Лердорфом?	Расмус Лердорф создал PHP в 1994 году как набор CGI-скриптов	1
903	10	Переменные в PHP объявляются без знака доллара?	Переменные в PHP объявляются знаком доллара $ перед именем	1
904	10	Суперглобальные переменные доступны во всех областях видимости?	Суперглобальные массивы доступны во всех областях видимости без объявления global	1
905	10	print возвращает значение 1?	print возвращает 1 и принимает только один аргумент	1
906	10	echo может принимать несколько аргументов?	echo может принимать несколько аргументов и не возвращает значение	1
907	10	Константы в PHP могут быть изменены во время выполнения?	Константы — неизменяемые значения во время выполнения скрипта	1
908	10	const работает во время выполнения?	const работает во время компиляции, define — во время выполнения	1
909	10	Оператор === сравнивает значения с приведением типов?	=== сравнивает значения и типы без приведения, == с приведением	1
910	10	Оператор <=> (spaceship) возвращает true или false?	Оператор <=> возвращает -1, 0 или 1 при сравнении	1
911	10	Анонимные функции в PHP могут быть присвоены переменной?	Анонимные функции могут быть присвоены переменной и переданы как аргументы	1
912	10	Стрелочные функции появились в PHP 7.4?	Стрелочные функции (fn) появились в PHP 7.4	1
913	10	Типизированные аргументы появились в PHP 5?	Типизированные аргументы появились в PHP 7	1
914	10	Nullable типы появились в PHP 7.1?	Nullable типы (?int) появились в PHP 7.1	1
915	10	Union types появились в PHP 8?	Union types (int|string) появились в PHP 8	1
916	10	Трейты в PHP позволяют множественное наследование?	Трейты позволяют повторное использование кода без множественного наследования	1
917	10	Генераторы в PHP используют ключевое слово yield?	Генераторы — функции с yield для ленивой итерации	1
918	10	Атрибуты появились в PHP 8?	Атрибуты #[Attribute] появились в PHP 8	1
919	10	Match-выражение появилось в PHP 8?	Match-выражение появилось в PHP 8	1
920	10	Enum появились в PHP 8.1?	Enum (перечисления) появились в PHP 8.1	1
921	10	Readonly свойства появились в PHP 8.1?	Readonly свойства появились в PHP 8.1	1
922	10	PDO является универсальным интерфейсом для разных БД?	PDO — универсальный интерфейс для работы с разными базами данных	1
923	10	Подготовленные запросы защищают от SQL-инъекций?	Подготовленные запросы с плейсхолдерами разделяют SQL и данные	1
924	10	Composer является менеджером зависимостей для PHP?	Composer управляет сторонними библиотеками через composer.json	1
925	10	Пространства имен в PHP решают проблему конфликтов имен?	namespace — механизм организации кода и избежания конфликтов имен	1
926	10	Что такое PHP?	Скриптовый язык для веб-приложений	2
927	10	Кто создал PHP?	Расмус Лердорф	2
928	10	Что такое PHP-FPM?	FastCGI Process Manager для PHP	2
929	10	Какие суперглобальные массивы существуют?	$_GET, $_POST, $_REQUEST, $_SESSION, $_COOKIE, $_SERVER, $_FILES, $_ENV, $GLOBALS	2
930	10	В чем разница между echo и print?	echo не возвращает, print возвращает 1	2
931	10	Что такое константа?	Неизменяемое значение во время выполнения	2
932	10	В чем разница между define() и const?	define() во время выполнения, const во время компиляции	2
933	10	В чем разница между == и ===?	== с приведением, === строгое без приведения	2
934	10	Что делает оператор <=> (spaceship)?	Возвращает -1, 0 или 1 при сравнении	2
937	10	Что такое стрелочная функция?	Короткий синтаксис fn() => expr	2
938	10	Что такое замыкание?	Анонимная функция с захватом переменных через use()	2
939	10	Что такое класс?	Шаблон для создания объектов	2
940	10	Какие модификаторы доступа есть в PHP?	public, protected, private	2
941	10	Что такое наследование?	Наследование через extends	2
942	10	Что такое интерфейс?	Контракт с методами для реализации	2
943	10	Что такое абстрактный класс?	Класс, который не может быть инстанциирован	2
944	10	Что такое исключения?	Механизм обработки ошибок через try/catch/throw	2
945	10	Что такое подготовленные запросы?	Запросы с плейсхолдерами, защита от SQL-инъекций	2
946	10	Что такое сессии?	Сохранение данных между запросами через $_SESSION	2
947	10	Что такое Composer?	Менеджер зависимостей для PHP	2
948	10	Что такое пространства имен?	Механизм организации кода (namespace)	2
949	10	Что такое трейты?	Механизм для повторного использования кода в классах	2
950	10	Что такое генераторы?	Функции с yield для ленивой итерации	2
951	10	Какие типы данных есть в PHP?	int, float, string, bool, array, object, null, resource, callable	3
952	10	Какие суперглобальные массивы существуют?	$_GET, $_POST, $_REQUEST, $_SESSION, $_COOKIE, $_SERVER, $_FILES, $_ENV, $GLOBALS	3
953	10	Какие операторы сравнения есть в PHP?	==, ===, !=, !==, <, >, <=, >=, <=>	3
954	10	Какие магические константы существуют?	__LINE__, __FILE__, __DIR__, __FUNCTION__, __CLASS__, __METHOD__, __NAMESPACE__	3
955	10	Какие функции для работы со строками существуют?	strlen, strpos, substr, str_replace, strtolower, strtoupper, trim, explode, implode	3
956	10	Какие функции для работы с массивами существуют?	array_merge, array_keys, array_values, in_array, array_search, array_map, array_filter, array_reduce	3
957	10	Какие модификаторы доступа существуют в PHP?	public, protected, private	3
958	10	Какие способы создания массива существуют?	array() и []	3
959	10	Какие способы обработки ошибок существуют?	try-catch, set_error_handler, error_log	3
960	10	Какие расширения для работы с MySQL существуют?	mysqli, PDO_MySQL	3
961	10	Какие режимы открытия файлов существуют?	r, w, a, r+, w+, a+	3
962	10	Какие способы вывода данных существуют?	echo, print, print_r, var_dump	3
963	10	Какие способы работы с сессиями существуют?	session_start, $_SESSION, session_destroy	3
964	10	Какие способы работы с cookie существуют?	setcookie, $_COOKIE	3
965	10	Какие стандартные классы исключений существуют?	Exception, RuntimeException, InvalidArgumentException, TypeError, ValueError	3
966	10	Какие функции для работы с файлами существуют?	fopen, fread, fwrite, fclose, file_get_contents, file_put_contents	3
967	10	Какие способы хеширования паролей существуют?	password_hash, password_verify	3
968	10	Какие стандарты PSR существуют?	PSR-1, PSR-4, PSR-7, PSR-12	3
969	10	Какие возможности PHP 8+ существуют?	Атрибуты, match, union types, named arguments, constructor property promotion	3
970	10	Какие возможности PHP 8.1+ существуют?	Enum, readonly свойства, Fibers	3
971	10	Какие способы объявления констант существуют?	define(), const	3
972	10	Какие типы массивов существуют?	Индексированные, ассоциативные, многомерные	3
973	10	Какие способы перебора массива существуют?	foreach, for, while, array_walk	3
974	10	Какие уровни ошибок существуют?	E_ERROR, E_WARNING, E_NOTICE, E_PARSE, E_DEPRECATED, E_STRICT, E_ALL	3
975	10	Какие способы подключения файлов существуют?	include, include_once, require, require_once	3
976	10	Как называется скриптовый язык для веб-приложений? (введите аббревиатуру)	PHP	4
977	10	Как называется создатель PHP? (введите имя)	Расмус Лердорф	4
978	10	Как называется реализация FastCGI для PHP? (введите аббревиатуру)	PHP-FPM	4
979	10	Как называется массив с данными GET-запроса? (введите имя переменной)	$_GET	4
980	10	Как называется массив с данными POST-запроса? (введите имя переменной)	$_POST	4
981	10	Как называется массив с данными сессии? (введите имя переменной)	$_SESSION	4
982	10	Как называется массив с cookie? (введите имя переменной)	$_COOKIE	4
983	10	Как называется оператор строгого сравнения? (введите оператор)	===	4
984	10	Как называется оператор сравнения с приведением? (введите оператор)	==	4
985	10	Как называется оператор spaceship? (введите оператор)	<=>	4
986	10	Как называется функция для объединения массива в строку? (введите функцию)	implode	4
987	10	Как называется функция для разбиения строки на массив? (введите функцию)	explode	4
988	10	Как называется функция для создания безопасного хеша пароля? (введите функцию)	password_hash	4
989	10	Как называется функция для проверки пароля? (введите функцию)	password_verify	4
990	10	Как называется менеджер зависимостей для PHP? (введите название)	Composer	4
991	10	Как называется файл конфигурации Composer? (введите имя файла)	composer.json	4
992	10	Как называется механизм организации кода для избежания конфликтов имен? (введите термин)	пространства имен	4
993	10	Как называется ключевое слово для создания класса? (введите ключевое слово)	class	4
994	10	Как называется метод конструктора? (введите имя метода)	__construct	4
995	10	Как называется метод деструктора? (введите имя метода)	__destruct	4
996	10	Как называется модификатор доступа, доступный везде? (введите модификатор)	public	4
997	10	Как называется модификатор доступа, доступный только в классе? (введите модификатор)	private	4
998	10	Как называется модификатор доступа, доступный в классе и наследниках? (введите модификатор)	protected	4
999	10	Как называется ключевое слово для обработки исключений? (введите ключевое слово)	try	4
1000	10	Как называется ключевое слово для перехвата исключений? (введите ключевое слово)	catch	4
1001	11	Java была создана Джеймсом Гослингом?	Джеймс Гослинг создал Java в 1995 году в Sun Microsystems	1
1002	11	JVM исполняет байт-код Java?	JVM — виртуальная машина, исполняющая байт-код Java	1
1003	11	JRE включает в себя компилятор javac?	JRE — среда выполнения (JVM + библиотеки), JDK включает компилятор	1
1004	11	String в Java является изменяемым классом?	String — неизменяемый (immutable) класс	1
1005	11	StringBuilder является синхронизированным?	StringBuilder несинхронизированный, StringBuffer синхронизированный	1
1006	11	Оператор == для строк сравнивает содержимое?	== сравнивает ссылки, equals() сравнивает содержимое	1
1007	11	Абстрактный класс может быть инстанциирован?	Абстрактный класс не может быть инстанциирован	1
1008	11	Интерфейс в Java может содержать поля (состояние)?	Интерфейсы не содержат состояния (полей с данными)	1
1009	11	Перегрузка методов происходит в разных классах?	Перегрузка — в одном классе с разными параметрами	1
1010	11	Переопределение методов происходит в подклассе?	Переопределение — изменение реализации в подклассе	1
1011	11	ArrayList быстрее LinkedList для вставки в середину?	LinkedList быстрее для вставки в середину O(1)	1
1012	11	HashSet хранит элементы в отсортированном порядке?	HashSet не сортирует, TreeSet сортирует	1
1013	11	HashMap допускает null-ключи?	HashMap допускает один null-ключ и много null-значений	1
1014	11	Hashtable допускает null-ключи?	Hashtable не допускает null-ключи и null-значения	1
1015	11	Checked исключения требуют обработки на этапе компиляции?	Checked исключения компилятор требует обрабатывать	1
1016	11	Runnable является классом в Java?	Runnable — интерфейс, Thread — класс	1
1017	11	volatile обеспечивает атомарность операций?	volatile обеспечивает видимость, но не атомарность	1
1018	11	transient поля сериализуются по умолчанию?	transient исключает поле из сериализации	1
1019	11	Лямбда-выражения появились в Java 8?	Лямбда-выражения появились в Java 8	1
1020	11	Модули появились в Java 9?	Модули (module-info.java) появились в Java 9	1
1021	11	Stream API появился в Java 8?	Stream API появился в Java 8	1
1022	11	Optional появился в Java 8?	Optional появился в Java 8	1
1023	11	Концепция WORA означает "Write Once, Run Anywhere"?	WORA — Write Once, Run Anywhere (написано однажды, работает везде)	1
1024	11	Байт-код Java выполняется на любой платформе без JVM?	Байт-код требует JVM для выполнения на каждой платформе	1
1025	11	Сериализация преобразует объект в байтовый поток?	Сериализация — преобразование объекта в байтовый поток	1
1026	11	Что такое Java?	Объектно-ориентированный язык для JVM	2
1028	11	Что такое JVM?	Виртуальная машина для байт-кода Java	2
1029	11	Что такое JRE?	Среда выполнения Java (JVM + библиотеки)	2
1030	11	Что такое JDK?	Комплект для разработки (JRE + компилятор + инструменты)	2
1031	11	Что такое байт-код?	Промежуточный код для JVM	2
1032	11	Какие примитивные типы есть в Java?	byte, short, int, long, float, double, char, boolean	2
1033	11	Какие модификаторы доступа есть в Java?	public, protected, default, private	2
1034	11	Что такое static?	Принадлежит классу, а не экземпляру	2
1035	11	Что такое final?	Неизменяемая переменная, непереопределяемый метод, ненаследуемый класс	2
1036	11	Что такое abstract?	Класс не инстанциируется или метод должен быть переопределен	2
1037	11	Что такое String?	Неизменяемый класс для строк	2
1038	11	В чем разница между String, StringBuilder и StringBuffer?	String неизменяемый, StringBuilder несинхронизированный, StringBuffer синхронизированный	2
1039	11	Как сравнить строки в Java?	equals() по содержимому, == по ссылкам	2
1040	11	Что такое класс?	Шаблон для создания объектов	2
1041	11	Что такое конструктор?	Метод для инициализации объекта	2
1042	11	Что такое перегрузка методов?	Методы с одинаковым именем, разными параметрами	2
1043	11	Что такое переопределение методов?	Изменение реализации в подклассе	2
1044	11	Что такое наследование?	Наследование полей и методов через extends	2
1045	11	Что такое интерфейс?	Контракт с методами для реализации	2
1046	11	Что такое абстрактный класс?	Класс, который не может быть инстанциирован	2
1047	11	Что такое коллекции?	Фреймворк для хранения групп объектов	2
1048	11	Что такое исключения?	События, нарушающие нормальный поток выполнения	2
1049	11	Что такое поток в Java?	Поток выполнения (Thread)	2
1050	11	Что такое Generics?	Обобщенные типы для типобезопасности	2
1051	11	Какие примитивные типы данных есть в Java?	byte, short, int, long, float, double, char, boolean	3
1052	11	Какие модификаторы доступа существуют в Java?	public, protected, default, private	3
1053	11	Какие модификаторы для классов и методов существуют?	static, final, abstract, synchronized, native	3
1054	11	Какие классы для работы со строками существуют?	String, StringBuilder, StringBuffer	3
1055	11	Какие классы реализуют List?	ArrayList, LinkedList, Vector, Stack	3
1056	11	Какие классы реализуют Set?	HashSet, TreeSet, LinkedHashSet	3
1057	11	Какие классы реализуют Map?	HashMap, TreeMap, LinkedHashMap, Hashtable, ConcurrentHashMap	3
1058	11	Какие ключевые слова для работы с исключениями существуют?	try, catch, finally, throw, throws	3
1059	11	Какие классы для чтения файлов существуют?	FileReader, BufferedReader, Scanner, InputStream	3
1060	11	Какие классы для записи файлов существуют?	FileWriter, BufferedWriter, PrintWriter, OutputStream	3
1061	11	Какие методы класса Object существуют?	toString, equals, hashCode, clone, wait, notify, getClass	3
1062	11	Какие интерфейсы коллекций существуют?	Collection, List, Set, Queue, Deque, Map	3
1063	11	Какие способы создания потоков существуют?	Наследование Thread, реализация Runnable	3
1064	11	Какие методы для работы с потоками существуют?	start, run, sleep, wait, notify, join	3
1065	11	Какие функции Stream API существуют?	filter, map, reduce, forEach, collect	3
1066	11	Какие компоненты Java платформы существуют?	JVM, JRE, JDK	3
1067	11	Какие виды конструкторов существуют?	По умолчанию, параметризованный, копирования	3
1068	11	Какие операции с String существуют?	concat, substring, replace, toLowerCase, toUpperCase, trim	3
1069	11	Какие методы для синхронизации потоков существуют?	synchronized, wait, notify, notifyAll, Lock	3
1070	11	Какие новые возможности появились в Java 8?	Лямбда-выражения, Stream API, Optional, Method References	3
1071	11	Какие новые возможности появились в Java 9?	Модули, Collection工厂методы, try-with-resources улучшения	3
1072	11	Какие новые возможности появились в Java 11?	HTTP Client, local-variable syntax for lambda, ZGC	3
1073	11	Какие новые возможности появились в Java 17?	Records, Sealed classes, Pattern Matching, Switch expressions	3
1074	11	Какие классы для работы с I/O существуют?	File, FileReader, FileWriter, BufferedReader, BufferedWriter	3
1075	11	Какие утилиты для работы с коллекциями существуют?	Collections, Arrays, Collections.sort, Collections.shuffle	3
1076	11	Как называется создатель Java? (введите имя)	Джеймс Гослинг	4
1077	11	Как называется виртуальная машина Java? (введите аббревиатуру)	JVM	4
1078	11	Как называется среда выполнения Java? (введите аббревиатуру)	JRE	4
1079	11	Как называется комплект для разработки Java? (введите аббревиатуру)	JDK	4
1080	11	Как называется промежуточный код для JVM? (введите термин)	байт-код	4
1081	11	Как называется неизменяемый класс для строк? (введите название)	String	4
1082	11	Как называется изменяемый несинхронизированный класс для строк? (введите название)	StringBuilder	4
1083	11	Как называется изменяемый синхронизированный класс для строк? (введите название)	StringBuffer	4
1084	11	Как называется модификатор доступа, доступный везде? (введите модификатор)	public	4
1085	11	Как называется модификатор доступа, доступный только в классе? (введите модификатор)	private	4
1086	11	Как называется модификатор доступа, доступный в классе и наследниках? (введите модификатор)	protected	4
1087	11	Как называется ключевое слово для принадлежности классу? (введите модификатор)	static	4
1088	11	Как называется ключевое слово для неизменяемости? (введите модификатор)	final	4
1089	11	Как называется ключевое слово для абстракции? (введите модификатор)	abstract	4
1090	11	Как называется интерфейс для перебора коллекций? (введите название)	Iterator	4
1091	11	Как называется интерфейс для пар ключ-значение? (введите название)	Map	4
1092	11	Как называется класс для работы со списками? (введите название)	ArrayList	4
1093	11	Как называется класс для работы с множествами? (введите название)	HashSet	4
1094	11	Как называется класс для работы с картами? (введите название)	HashMap	4
1095	11	Как называется ключевое слово для синхронизации? (введите ключевое слово)	synchronized	4
1096	11	Как называется ключевое слово для выбрасывания исключений? (введите ключевое слово)	throw	4
1097	11	Как называется ключевое слово для объявления исключений? (введите ключевое слово)	throws	4
1098	11	Как называется API для функциональной обработки коллекций? (введите название)	Stream API	4
1099	11	Как называется класс-контейнер для избежания NullPointerException? (введите название)	Optional	4
1100	11	Как называется система модулей в Java 9+? (введите термин)	модули	4
1101	12	C++ был создан Бьёрном Страуструпом?	Бьёрн Страуструп создал C++ в 1983 году в Bell Labs	1
1102	12	C++ является интерпретируемым языком?	C++ — компилируемый язык программирования	1
1103	12	Указатель в C++ может быть null?	Указатель может быть null, ссылка — нет	1
1104	12	Ссылка в C++ может быть null?	Ссылка всегда привязана к объекту и не может быть null	1
1105	12	constexpr вычисляется во время выполнения?	constexpr вычисляется во время компиляции	1
1106	12	enum class имеет глобальную область видимости?	enum class имеет ограниченную область видимости, enum — глобальную	1
1107	12	Виртуальная функция должна быть определена в базовом классе?	Виртуальная функция может быть чисто виртуальной (=0) без реализации	1
1108	12	Абстрактный класс может быть инстанциирован?	Абстрактный класс не может быть инстанциирован	1
1109	12	Множественное наследование решает проблему "ромба" автоматически?	Проблема "ромба" решается виртуальным наследованием	1
1110	12	unique_ptr поддерживает подсчет ссылок?	unique_ptr — единственное владение, shared_ptr — с подсчетом ссылок	1
1111	12	new вызывает конструктор объекта?	new выделяет память и вызывает конструктор	1
1112	12	malloc вызывает конструктор объекта?	malloc выделяет память без вызова конструктора	1
1113	12	std::move перемещает объект?	std::move только приводит к rvalue, не перемещает сам объект	1
1114	12	vector является связным списком?	vector — динамический массив, list — связный список	1
1115	12	map хранит элементы в неотсортированном порядке?	map — отсортированное дерево, unordered_map — хеш-таблица	1
1116	12	Итераторы в C++ аналогичны указателям?	Итераторы предоставляют интерфейс, похожий на указатели	1
1117	12	Лямбда-выражения появились в C++11?	Лямбда-выражения добавлены в C++11	1
1118	12	Концепты появились в C++17?	Концепты добавлены в C++20	1
1119	12	Модули появились в C++20?	Модули добавлены в C++20	1
1120	12	Корутины появились в C++20?	Корутины добавлены в C++20	1
1121	12	noexcept указывает, что функция выбрасывает исключения?	noexcept указывает, что функция НЕ выбрасывает исключения	1
1122	12	override является ключевым словом?	override — ключевое слово для явного указания переопределения (C++11)	1
1123	12	final запрещает наследование класса?	final запрещает наследование класса или переопределение метода	1
1124	12	friend дает доступ к публичным членам класса?	friend дает доступ к приватным и защищенным членам класса	1
1125	12	RAII управляет ресурсами через конструкторы и деструкторы?	RAII — Resource Acquisition Is Initialization, управление ресурсами через конструкторы/деструкторы	1
1126	12	Что такое C++?	Компилируемый язык общего назначения, расширение C	2
1127	12	Кто создал C++?	Бьёрн Страуструп	2
1128	12	Какие парадигмы поддерживает C++?	ООП, процедурное, обобщенное, функциональное	2
1129	12	Что такое указатель?	Переменная, хранящая адрес памяти	2
1130	12	Что такое ссылка?	Альтернативное имя для существующей переменной	2
1131	12	В чем разница между указателем и ссылкой?	Указатель может быть null, ссылка — нет; указатель меняет адрес, ссылка — нет	2
1132	12	Что такое constexpr?	Вычисление во время компиляции	2
1133	12	Что такое auto?	Автоматическое определение типа компилятором	2
1134	12	Что такое nullptr?	Безопасный нулевой указатель	2
1135	12	Что такое класс?	Пользовательский тип с данными и методами	2
1136	12	Что такое конструктор?	Метод для инициализации объекта при создании	2
1137	12	Что такое деструктор?	Метод для очистки ресурсов при уничтожении объекта	2
1138	12	Какие модификаторы доступа есть в C++?	public, protected, private	2
1139	12	Что такое наследование?	Создание нового класса на основе существующего	2
1140	12	Что такое полиморфизм?	Объекты с одинаковым интерфейсом ведут себя по-разному	2
1141	12	Что такое виртуальная функция?	Функция, переопределяемая в производном классе	2
1142	12	Что такое абстрактный класс?	Класс с чисто виртуальной функцией, не инстанциируется	2
1143	12	Что такое шаблоны?	Обобщенный код, работающий с разными типами	2
1144	12	Что такое STL?	Standard Template Library — контейнеры, алгоритмы, итераторы	2
1145	12	Что такое умные указатели?	unique_ptr, shared_ptr, weak_ptr для автоматического управления памятью	2
1146	12	Что такое RAII?	Resource Acquisition Is Initialization — управление ресурсами через конструкторы/деструкторы	2
1147	12	Что такое move-семантика?	Перемещение ресурсов вместо копирования (C++11)	2
1148	12	Что такое лямбда-выражения?	Анонимные функции: [capture](params) -> ret { body }	2
1149	12	Что такое исключения?	Механизм обработки ошибок через try, catch, throw	2
1150	12	Что такое концепты в C++20?	Ограничения для шаблонов (concept, requires)	2
1151	12	Какие парадигмы поддерживает C++?	ООП, процедурное, обобщенное, функциональное	3
1152	12	Какие основные типы данных есть в C++?	int, float, double, char, bool, void, long, short	3
1153	12	Какие модификаторы доступа существуют в C++?	public, protected, private	3
1154	12	Какие типы наследования существуют в C++?	public, protected, private	3
1155	12	Какие контейнеры есть в STL?	vector, list, deque, set, map, unordered_set, unordered_map, queue, stack	3
1156	12	Какие умные указатели существуют в C++?	unique_ptr, shared_ptr, weak_ptr	3
1157	12	Какие типы итераторов существуют?	Input, Output, Forward, Bidirectional, Random Access	3
1158	12	Какие ключевые слова для работы с исключениями существуют?	try, catch, throw, noexcept	3
1159	12	Какие возможности появились в C++11?	auto, nullptr, constexpr, лямбда-выражения, move-семантика, умные указатели	3
1160	12	Какие возможности появились в C++14?	constexpr улучшения, generic lambdas, binary literals, digit separators	3
1161	12	Какие возможности появились в C++17?	if constexpr, structured bindings, filesystem, optional, variant, any	3
1162	12	Какие возможности появились в C++20?	Концепты, корутины, модули, ranges, трехстороннее сравнение, constexpr improvements	3
1163	12	Какие операции с указателями существуют?	& (адрес), * (разыменование), -> (доступ к члену)	3
1164	12	Какие виды конструкторов существуют?	По умолчанию, параметризованный, копирования, move, делегирующий	3
1165	12	Какие алгоритмы STL существуют?	sort, find, copy, for_each, accumulate, transform	3
1166	12	Какие члены класса могут быть static?	Поля, методы, функции	3
1167	12	Какие способы инициализации существуют в C++?	Copy initialization, direct initialization, uniform initialization ({}), value initialization	3
1168	12	Какие операции с new/delete существуют?	new, new[], delete, delete[], placement new	3
1169	12	Какие категории значений существуют?	lvalue, rvalue, xvalue, glvalue, prvalue	3
1170	12	Какие спецификаторы типов существуют?	signed, unsigned, short, long, long long	3
1171	12	Какие квалификаторы типов существуют?	const, volatile, constexpr	3
1172	12	Какие виды наследования существуют?	Одинарное, множественное, виртуальное	3
1173	12	Какие функции могут быть virtual?	Методы класса, деструкторы, нестатические методы	3
1174	12	Какие контейнеры ассоциативные?	set, map, multiset, multimap, unordered_set, unordered_map	3
1175	12	Какие контейнеры последовательные?	vector, list, deque, forward_list, array	3
1176	12	Как называется создатель C++? (введите имя)	Бьёрн Страуструп	4
1177	12	Как называется язык, созданный как расширение C? (введите название)	C++	4
1178	12	Как называется переменная, хранящая адрес памяти? (введите термин)	указатель	4
1179	12	Как называется альтернативное имя для переменной? (введите термин)	ссылка	4
1180	12	Как называется безопасный нулевой указатель в C++? (введите ключевое слово)	nullptr	4
1181	12	Как называется вычисление во время компиляции? (введите ключевое слово)	constexpr	4
1182	12	Как называется автоматическое определение типа? (введите ключевое слово)	auto	4
1183	12	Как называется метод для инициализации объекта? (введите термин)	конструктор	4
1184	12	Как называется метод для очистки ресурсов? (введите термин)	деструктор	4
1185	12	Как называется модификатор доступа, доступный везде? (введите модификатор)	public	4
1186	12	Как называется модификатор доступа, доступный только в классе? (введите модификатор)	private	4
1187	12	Как называется модификатор доступа, доступный в классе и наследниках? (введите модификатор)	protected	4
1188	12	Как называется механизм создания нового класса на основе существующего? (введите термин)	наследование	4
1189	12	Как называется функция, переопределяемая в производном классе? (введите термин)	виртуальная	4
1190	12	Как называется класс с чисто виртуальной функцией? (введите термин)	абстрактный	4
1191	12	Как называется библиотека шаблонов C++? (введите аббревиатуру)	STL	4
1192	12	Как называется динамический массив в STL? (введите название)	vector	4
1193	12	Как называется двусвязный список в STL? (введите название)	list	4
1194	12	Как называется отсортированное множество в STL? (введите название)	set	4
1195	12	Как называется отсортированное множество пар ключ-значение? (введите название)	map	4
1196	12	Как называется умный указатель с единственным владением? (введите название)	unique_ptr	4
1197	12	Как называется умный указатель с разделяемым владением? (введите название)	shared_ptr	4
1198	12	Как называется анонимная функция в C++? (введите термин)	лямбда	4
1199	12	Как называется механизм обработки ошибок через try-catch? (введите термин)	исключения	4
1200	12	Как называется ограничение для шаблонов в C++20? (введите термин)	концепты	4
1201	13	В каком году основана компания Тензор	Талантливые ярославские студенты, начинающие программисты, увлеченные техническим прогрессом, создают собственную программу СБИС и открывают первый офис	2
1203	13	Правда ли, что у компании более 4 млн. клиентов	У компании 4,5 млн. клиентов	1
1204	13	Сколько центров разработки у компании	Целых 11 IT-центров	2
1205	13	Верно ли, что ребрендинг СБИС в Saby связан с изменением владельца	Владелец все тот же	1
1202	13	Какой из сервисов не входит в saby(СБИС)	Все кроме налогового планирования включено в saby(СБИС)	2
1207	13	Как называется продукт Тензора в Казахстане?		2
1208	13	Как называется механизм переноса аккаунтов из одного сервера на другой?		2
1210	13	В каком городе 2 офиса Тензора стоят рядом друг с другом?		2
1209	13	Какое животное появляется на вебинарах Тензора?		2
410	5	map() в js изменяет исходный массив?	map() создаёт новый массив, не изменяя исходный	1
1206	13	В каком филиале Тензора устраивают ежегодную гонку на стульях?		2
\.


--
-- Data for Name: difficulties; Type: TABLE DATA; Schema: z1; Owner: z1
--

COPY z1.difficulties (id, name) FROM stdin;
1	Easy
2	Middle
3	Hard
\.


--
-- Data for Name: faq; Type: TABLE DATA; Schema: z1; Owner: z1
--

COPY z1.faq (id, title, description) FROM stdin;
1	Что из себя представляет сервис?	Инструмент для глубокого изучения сложных тем через активное вспоминание и самопроверку.
2	Какой основной принцип обучения заложен в продукте?	Активное вспоминание: сначала попытка ответить с помощью собственных знаний, затем сверка с эталоном.
3	Что такое кейс?	Развёрнутое объяснение, примеры и код. Показывается только после того, как вы подумали над вопросом.
4	Для чего нужна анкета?	С помощью анкеты мы выявляем ваши интересы для подбора лучших профессий
6	Как часто нужно повторять материал?	Регулярность определяете вы. Сервис не навязывает график, но статистика подскажет слабые места.
7	Сколько вариантов ответа может быть в вопросе на экзамене?	В формате экзамена количество вариантов ответа жестко ограничено и может составлять от 2 до 6 вариантов на один вопрос.
5	Как работает колесо?	Мы устанавливаем контакт со звездами и на основе полученного гороскопа предлагаем вам наиболее подходящий вариант
\.


--
-- Data for Name: profession_tags; Type: TABLE DATA; Schema: z1; Owner: z1
--

COPY z1.profession_tags (profession_id, tag_id, weight) FROM stdin;
1	8	1
1	12	1
1	20	1
1	33	1
1	34	1
1	35	1
1	21	1
1	22	1
1	36	1
2	9	1
2	13	1
2	17	1
2	18	1
2	19	1
2	23	1
2	24	1
2	26	1
2	38	1
2	39	1
2	47	1
2	54	1
2	37	1
2	48	1
2	46	1
2	25	1
3	10	1
3	14	1
3	11	1
3	27	1
3	28	1
3	40	1
3	44	1
3	55	1
3	45	1
3	3	1
3	6	1
4	8	1
4	12	1
4	13	1
4	17	1
4	20	1
4	33	1
4	34	1
4	21	1
4	23	1
4	38	1
4	36	1
5	4	1
5	14	1
5	29	1
5	30	1
5	31	1
5	32	1
6	15	1
6	11	1
6	41	1
6	42	1
6	43	1
6	30	1
7	13	1
7	14	1
7	38	1
7	39	1
7	5	1
8	14	1
8	16	1
8	10	1
8	40	1
8	44	1
8	45	1
8	32	1
\.


--
-- Data for Name: professions; Type: TABLE DATA; Schema: z1; Owner: z1
--

COPY z1.professions (id, name, description, created_at) FROM stdin;
1	Frontend-разработчик	Разработка пользовательских интерфейсов и клиентской логики	2026-08-11 14:27:53.696585
2	Backend-разработчик	Разработка серверной логики, API и работа с базами данных	2026-08-11 14:27:53.696585
3	DevOps-инженер	Автоматизация развёртывания, CI/CD, контейнеризация и инфраструктура	2026-08-11 14:27:53.696585
4	Fullstack-разработчик	Разработка и frontend, и backend частей приложения	2026-08-11 14:27:53.696585
5	Сетевой инженер	Проектирование, настройка и поддержка сетевой инфраструктуры	2026-08-11 14:27:53.696585
6	QA-инженер	Тестирование ПО, обеспечение качества и автоматизация тестов	2026-08-11 14:27:53.696585
7	Data Engineer	Построение пайплайнов данных, ETL и работа с хранилищами	2026-08-11 14:27:53.696585
8	Системный администратор	Администрирование серверов, ОС и IT-инфраструктуры	2026-08-11 14:27:53.696585
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: z1; Owner: z1
--

COPY z1.roles (id, name, description) FROM stdin;
1	admin	Администратор системы
2	user	Обычный пользователь
\.


--
-- Data for Name: tags; Type: TABLE DATA; Schema: z1; Owner: z1
--

COPY z1.tags (id, name, is_active) FROM stdin;
1	Front	t
2	Back	t
3	DevOps	t
4	Сети	t
5	Базы данных	t
6	Контейнеризация	t
7	Языки программирования	t
8	HTML	t
9	Go	t
10	Docker	t
11	Git	t
12	JavaScript	t
13	Python	t
14	Linux	t
15	QA	t
16	Администрирование	t
17	PHP	t
18	Java	t
19	C++	t
20	CSS	t
21	Frontend	t
22	Верстка	t
23	Backend	t
24	API	t
25	Микросервисы	t
26	REST	t
27	Kubernetes	t
28	CI/CD	t
29	TCP/IP	t
30	HTTP	t
31	DNS	t
32	Безопасность	t
33	TypeScript	t
34	React	t
35	Vue	t
36	Node.js	t
37	Django	t
38	SQL	t
39	PostgreSQL	t
40	Bash	t
41	Автотесты	t
42	Selenium	t
43	Postman	t
44	Nginx	t
45	Мониторинг	t
46	Laravel	t
47	MySQL	t
48	Spring	t
49	ООП	t
50	Алгоритмы	t
51	Saby	t
52	Собеседование	t
53	Стажировка	t
54	Redis	t
55	Terraform	t
\.


--
-- Data for Name: test_cards; Type: TABLE DATA; Schema: z1; Owner: z1
--

COPY z1.test_cards (test_id, card_id, order_index) FROM stdin;
4	1	0
4	2	1
4	3	2
4	4	3
4	5	4
4	26	5
4	27	6
4	28	7
4	29	8
4	30	9
5	101	0
5	102	1
5	103	2
5	104	3
5	105	4
6	201	0
6	202	1
6	203	2
6	204	3
6	205	4
7	301	0
7	302	1
7	303	2
7	304	3
7	305	4
8	402	1
8	403	2
8	404	3
8	405	4
9	501	0
9	502	1
9	503	2
9	504	3
9	505	4
10	601	0
10	602	1
10	603	2
10	604	3
10	605	4
11	701	0
11	702	1
11	703	2
11	704	3
11	705	4
12	801	0
12	802	1
12	803	2
12	804	3
12	805	4
13	901	0
13	903	2
13	904	3
13	905	4
14	1002	1
14	1003	2
14	1004	3
14	1005	4
15	1102	1
15	1103	2
15	1104	3
15	1105	4
5	126	5
5	127	6
5	128	7
5	129	8
5	130	9
6	226	5
6	227	6
6	228	7
6	229	8
6	230	9
7	326	5
7	327	6
7	328	7
7	329	8
7	330	9
8	426	5
8	427	6
8	428	7
8	429	8
8	430	9
9	526	5
9	527	6
9	528	7
9	529	8
9	530	9
10	626	5
10	628	7
10	629	8
10	630	9
11	726	5
11	727	6
11	728	7
11	729	8
11	730	9
12	826	5
12	827	6
12	828	7
12	829	8
12	830	9
13	926	5
13	927	6
13	928	7
13	929	8
13	930	9
14	1026	5
14	1027	6
14	1028	7
14	1029	8
14	1030	9
15	1126	5
15	1127	6
15	1128	7
15	1129	8
15	1130	9
16	1206	0
16	1207	1
16	1208	2
16	1209	3
16	1210	4
1	1	0
1	27	1
1	427	3
1	3	4
1	5	5
1	29	6
1	403	7
1	405	8
1	429	9
1	410	2
2	101	0
2	127	1
2	301	2
2	327	3
2	103	4
2	105	5
2	129	6
2	303	7
2	305	8
2	329	9
3	201	0
3	227	1
3	301	2
3	327	3
3	203	4
3	205	5
3	229	6
3	303	7
3	305	8
3	329	9
8	412	0
10	631	6
13	910	1
14	1010	0
15	1110	0
\.


--
-- Data for Name: tests; Type: TABLE DATA; Schema: z1; Owner: z1
--

COPY z1.tests (id, name, description, duration_minutes, profession_id, created_at, code, difficulty_id) FROM stdin;
1	Frontend Developer	Базовый тест по frontend-разработке: HTML, CSS, JavaScript	5	1	2026-08-13 14:09:56.172067	frontend-developer	2
2	Backend Developer	Тест по backend-разработке: Go, базы данных, API	5	2	2026-08-13 14:09:56.172067	backend-developer	2
3	DevOps Engineer	Тест по DevOps: Docker, сети, CI/CD	5	3	2026-08-13 14:09:56.172067	devops-engineer	2
4	HTML	Тест по теме «HTML». Проверьте знания на ключевых вопросах.	5	\N	2026-08-15 21:12:50.617627	html	2
5	GO	Тест по теме «GO». Проверьте знания на ключевых вопросах.	5	\N	2026-08-15 21:12:50.623535	go	2
6	Docker	Тест по теме «Docker». Проверьте знания на ключевых вопросах.	5	\N	2026-08-15 21:12:50.628078	docker	2
7	Сети	Тест по теме «Сети». Проверьте знания на ключевых вопросах.	5	\N	2026-08-15 21:12:50.63114	seti	2
8	JavaScript	Тест по теме «JavaScript». Проверьте знания на ключевых вопросах.	5	\N	2026-08-15 21:12:50.634132	javascript	2
9	Python	Тест по теме «Python». Проверьте знания на ключевых вопросах.	5	\N	2026-08-15 21:12:50.637205	python	2
10	Linux	Тест по теме «Linux». Проверьте знания на ключевых вопросах.	5	\N	2026-08-15 21:12:50.640418	linux	2
11	Тестирование ПО	Тест по теме «Тестирование ПО». Проверьте знания на ключевых вопросах.	5	\N	2026-08-15 21:12:50.643647	qa	2
12	Администрирование серверов	Тест по теме «Администрирование серверов». Проверьте знания на ключевых вопросах.	5	\N	2026-08-15 21:12:50.646847	admin	2
13	PHP	Тест по теме «PHP». Проверьте знания на ключевых вопросах.	5	\N	2026-08-15 21:12:50.650131	php	2
14	Java	Тест по теме «Java». Проверьте знания на ключевых вопросах.	5	\N	2026-08-15 21:12:50.653359	java	2
15	C++	Тест по теме «C++». Проверьте знания на ключевых вопросах.	5	\N	2026-08-15 21:12:50.656625	cpp	2
16	Тензор	Тест на знание компании	5	\N	2026-08-19 14:44:21.209875	tensor	2
\.


--
-- Data for Name: topic_professions; Type: TABLE DATA; Schema: z1; Owner: z1
--

COPY z1.topic_professions (topic_id, profession_id) FROM stdin;
\.


--
-- Data for Name: topic_tags; Type: TABLE DATA; Schema: z1; Owner: z1
--

COPY z1.topic_tags (topic_id, tag_id) FROM stdin;
1	8
1	20
1	21
1	22
2	9
2	23
2	24
2	25
2	26
3	10
3	3
3	27
3	28
3	6
4	4
4	11
4	29
4	30
4	31
4	32
5	12
5	33
5	34
5	35
5	36
5	21
6	13
6	23
6	37
6	38
6	39
7	14
7	40
7	3
7	16
8	15
8	41
8	42
8	43
9	16
9	44
9	45
9	40
9	32
10	17
10	23
10	46
10	47
10	38
11	18
11	23
11	48
11	49
12	19
12	49
12	50
13	51
13	52
13	53
\.


--
-- Data for Name: topics; Type: TABLE DATA; Schema: z1; Owner: z1
--

COPY z1.topics (id, name, code) FROM stdin;
1	HTML	html
2	GO	go
3	Docker	docker
4	Сети	seti
5	JavaScript	javascript
6	Python	python
7	Linux	linux
8	Тестирование ПО	qa
9	Администрирование серверов	admin
10	PHP	php
11	Java	java
12	C++	cpp
13	Тензор	tensor
\.


--
-- Data for Name: user_test_results; Type: TABLE DATA; Schema: z1; Owner: z1
--

COPY z1.user_test_results (id, user_id, test_id, score, max_score, passed, completed_at, mode) FROM stdin;
1	11	15	6	10	f	2026-08-17 10:14:13.7652+00	training
2	11	11	8	10	t	2026-08-17 10:15:04.66477+00	training
3	11	9	10	10	t	2026-08-17 10:15:43.672061+00	training
4	11	7	6	10	f	2026-08-17 10:16:14.144638+00	training
5	12	9	2	10	f	2026-08-17 15:37:08.278436+00	training
6	11	11	9	10	t	2026-08-18 10:28:05.822526+00	training
7	13	9	9	10	t	2026-08-18 10:53:36.841533+00	training
8	12	15	6	10	f	2026-08-18 15:22:20.543901+00	training
9	20	9	10	10	t	2026-08-18 16:04:48.750153+00	training
10	20	15	8	10	t	2026-08-18 16:06:25.30538+00	training
11	21	14	9	10	t	2026-08-19 09:21:59.601102+00	training
12	\N	16	5	5	t	2026-08-21 07:46:58.257261+00	training
13	\N	16	5	5	t	2026-08-21 07:47:34.909907+00	training
14	\N	16	3	5	f	2026-08-21 07:47:53.424417+00	training
15	33	16	5	5	t	2026-08-21 08:06:51.358823+00	exam
16	\N	16	1	5	f	2026-08-21 08:44:47.621658+00	training
17	12	16	5	5	t	2026-08-21 08:59:26.345343+00	training
18	12	16	5	5	t	2026-08-21 08:59:41.798425+00	exam
19	12	15	4	10	f	2026-08-21 09:00:27.030712+00	training
20	12	14	5	10	f	2026-08-21 09:00:46.275592+00	exam
21	12	10	5	10	f	2026-08-21 09:01:19.184715+00	training
22	11	16	5	5	t	2026-08-21 09:18:20.510817+00	training
23	\N	16	4	5	t	2026-08-21 09:35:15.191705+00	exam
24	\N	16	5	5	t	2026-08-21 10:18:03.790769+00	training
25	\N	16	0	5	f	2026-08-21 10:29:06.813876+00	training
26	14	16	5	5	t	2026-08-21 13:18:25.086956+00	exam
27	14	16	3	5	f	2026-08-21 13:18:56.430449+00	training
28	11	16	1	5	f	2026-08-21 15:11:34.27559+00	training
29	11	11	5	10	f	2026-08-21 15:16:55.022082+00	training
30	\N	8	8	10	t	2026-08-21 17:48:10.606779+00	exam
31	\N	9	9	10	t	2026-08-21 18:12:11.934567+00	exam
32	\N	14	1	10	f	2026-08-21 18:16:23.877637+00	training
33	\N	8	9	10	t	2026-08-21 21:42:01.777624+00	training
34	\N	6	9	10	t	2026-08-21 21:44:26.374856+00	training
35	36	1	7	10	t	2026-08-22 10:27:43.528197+00	training
36	11	16	5	5	t	2026-08-22 15:38:02.634848+00	training
37	11	5	2	10	f	2026-08-22 15:38:28.3985+00	training
38	\N	1	8	10	t	2026-08-23 07:16:53.221052+00	training
39	11	16	5	5	t	2026-08-23 12:47:52.054458+00	exam
40	\N	9	10	10	t	2026-08-23 12:57:56.910036+00	exam
41	11	1	8	10	t	2026-08-23 12:58:53.1416+00	training
42	36	1	9	10	t	2026-08-23 13:34:05.844288+00	training
43	\N	16	5	5	t	2026-08-23 13:42:00.855425+00	training
44	37	16	5	5	t	2026-08-23 15:22:25.190628+00	training
45	37	14	9	10	t	2026-08-23 15:23:31.368956+00	training
46	37	11	9	10	t	2026-08-23 15:25:53.198425+00	training
47	37	1	7	10	t	2026-08-23 15:27:34.597384+00	training
48	37	1	10	10	t	2026-08-23 15:28:19.967511+00	training
49	37	4	10	10	t	2026-08-23 15:29:12.132663+00	exam
50	37	8	10	10	t	2026-08-23 15:30:09.466513+00	training
51	37	10	8	10	t	2026-08-23 15:31:27.902921+00	training
52	37	14	10	10	t	2026-08-23 15:41:34.817041+00	exam
53	\N	16	5	5	t	2026-08-23 15:43:03.969389+00	exam
54	36	2	8	10	t	2026-08-23 18:35:58.747984+00	training
55	36	3	9	10	t	2026-08-23 18:36:51.234505+00	training
56	36	5	10	10	t	2026-08-23 18:37:34.566196+00	training
57	36	6	9	10	t	2026-08-23 18:38:45.457586+00	training
58	36	7	9	10	t	2026-08-23 18:39:35.203178+00	training
59	36	8	10	10	t	2026-08-23 18:40:26.177154+00	training
60	36	9	9	10	t	2026-08-23 18:45:04.048139+00	training
61	36	10	9	10	t	2026-08-23 18:47:00.130015+00	training
62	36	9	9	10	t	2026-08-23 18:47:28.884733+00	training
63	36	11	8	10	t	2026-08-23 18:48:10.946126+00	training
64	36	12	8	10	t	2026-08-23 18:48:37.118119+00	training
65	36	13	7	10	t	2026-08-23 18:50:34.402913+00	training
66	36	14	5	10	f	2026-08-23 18:51:55.947144+00	training
67	36	15	6	10	f	2026-08-23 18:52:46.082062+00	training
68	12	16	5	5	t	2026-08-23 22:08:22.229959+00	training
69	\N	16	2	5	f	2026-08-24 05:14:55.699909+00	training
70	14	9	10	10	t	2026-08-24 08:37:09.680063+00	training
71	\N	16	4	5	t	2026-08-24 09:56:49.203454+00	training
72	11	16	5	5	t	2026-08-24 10:12:07.578814+00	training
73	\N	15	3	10	f	2026-08-24 10:47:00.348063+00	exam
74	\N	16	3	5	f	2026-08-24 11:05:57.061843+00	training
75	\N	16	0	5	f	2026-08-24 11:06:21.993154+00	training
76	\N	16	2	5	f	2026-08-24 11:06:41.286563+00	training
77	\N	16	5	5	t	2026-08-24 11:06:48.595507+00	training
78	\N	16	2	5	f	2026-08-24 11:06:50.504536+00	training
79	\N	16	2	5	f	2026-08-24 11:07:01.37902+00	training
80	\N	16	4	5	t	2026-08-24 11:07:17.862863+00	training
81	\N	16	2	5	f	2026-08-24 11:07:22.62736+00	training
82	\N	2	6	10	f	2026-08-24 11:08:00.709216+00	training
83	\N	2	9	10	t	2026-08-24 11:11:26.404791+00	training
84	\N	8	9	10	t	2026-08-24 12:32:48.221054+00	exam
85	34	16	2	5	f	2026-08-24 13:33:53.387471+00	training
86	\N	16	4	5	t	2026-08-24 16:11:30.544684+00	training
87	11	1	10	10	t	2026-09-01 09:49:30.821618+00	training
88	\N	15	3	10	f	2026-09-06 19:02:35.188043+00	exam
\.


--
-- Data for Name: user_topic_counters; Type: TABLE DATA; Schema: z1; Owner: z1
--

COPY z1.user_topic_counters (id, user_id, topic_id, completed_count) FROM stdin;
1	11	12	1
3	11	6	1
4	11	4	1
5	12	6	1
6	13	6	1
8	20	6	1
9	20	12	1
10	21	11	1
11	33	13	1
7	12	12	2
13	12	11	1
14	12	7	1
16	14	13	2
2	11	8	3
17	11	2	1
18	37	13	1
20	37	8	1
21	37	1	1
22	37	5	1
23	37	7	1
19	37	11	2
24	36	2	1
25	36	3	1
26	36	4	1
27	36	5	1
29	36	7	1
28	36	6	2
30	36	8	1
31	36	9	1
32	36	10	1
33	36	11	1
34	36	12	1
12	12	13	3
35	14	6	1
15	11	13	5
36	34	13	1
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: z1; Owner: z1
--

COPY z1.users (id, username, email, password_hash, role_id, is_active, created_at) FROM stdin;
1	testuser	test@example.com	$2b$12$KqxRoy8pdi8FgodCIMjkaeeogNRbcriVP3JLpbsLzVeqn0rKOahpS	2	t	2026-08-11 11:21:59.983031
2	testuser1	test1@example.com	$2b$12$4hWuuBq2th9iMojuTohrIe1D/GZSMk5o655uoN/yHFjVxVBSs1ACO	2	t	2026-08-12 12:21:16.841999
4	abc1	abc@mail.com	$2b$12$ykkx8zyfNMHzg.CY3UKhsuItv7VP2eNay0eK/FNfLeAXqCMN1ztQi	2	t	2026-08-14 14:08:49.494784
5	abcd2	abc2@mail	$2b$12$46zRBsqQpXJge6cHnGsZAOv0yP6RK8XOQ59xlya7JjUkqsMjtEtPS	2	t	2026-08-14 14:25:45.767307
8	test	test@mail.ru	$2b$12$STHPzJhnjPlUF2FUk3uec..HDzxM4uf/ZLP0XH3U3PBX5dXAQPgaq	2	t	2026-08-15 19:50:42.296909
9	Егор	egorka.smakov04@gmail.com	$2b$12$xKw.pALi3dO0hhNzX8H6Ve./ne6jhMasacj1FFBARktjqHta4WGvK	2	t	2026-08-17 09:37:58.365344
10	ppavel	ppavel@ppavel.ppavel	$2b$12$uSgiXdjF8jcbdYzUy3H7hOgGBATIqT12UIfB5RNreC0hPjcTurewC	2	t	2026-08-17 09:49:11.741862
11	NIkita Melnikov	melnik@mail.com	$2b$12$v..yoxiQKUNxUP/gcvZZ8OrgjL2DO0mBGgeYeV9NuB9CPl.JqDno2	2	t	2026-08-17 10:13:03.458207
12	ganzalii	deganzalii@gmail.com	$2b$12$rCEImIIoXbxPJjaY0aJtcOBLONxLM9whhaH0xnLEzs9CQwAaSXVAK	2	t	2026-08-17 15:34:46.860556
13	sdfsdf	fsdfsdf@tensor.ru	$2b$12$5TXeTanBi1/p.U.vOEkzKetD4kvSEe2mfSWxvivRMU.W4IB0wS9Ei	2	t	2026-08-18 10:51:29.322073
14	Максим	maxim.dementev.04@gmail.com	$2b$12$cuBQ6pukmDJLIApyU387gOA4e7Is9mtOr4bR4awlzO54KYqXSwU/W	2	t	2026-08-18 11:34:38.24006
16	shmyak	shmyak@mail.com	$2b$12$yOeaxxwv4z/isz2uzT1apezG/5Yt0VEISa2QAF7Q2GdkbZsLQLE0O	2	t	2026-08-18 14:10:53.578638
17	shmyak2	shmyak2@mail.com	$2b$12$EfSdAgmMVwiTsXe1OWGEz.ParIO6dtwQ2cFZjsOrMosSJlsRA/7q6	2	t	2026-08-18 14:22:02.41162
18	shmyak3	shmyak3@mail.com	$2b$12$jVLSKtHbCKoGpvkN7x21Aeyjp2aRebxMm3UEFqRVYTh6iMWUiluHO	2	t	2026-08-18 14:32:53.481549
19	Alina	alinchi.gg@gmail.com	$2b$12$Jr2IefZI26lVweQXwXweC.01k6oZgr7gWBA/3RhiDIp2nTcP2iWiy	2	t	2026-08-18 14:46:18.645508
20	Deus Vult	example@yandex.ru	$2b$12$eqfJXgxEEYQemKk3iJXcleC12s8OarzmwcDLkqNPgsWgf0U9yfNUq	2	t	2026-08-18 16:02:20.099097
21	egor	egor@egor.egor	$2b$12$m15sNlH4mWNIn4M8i3Mwje4eVDtNCM9Q/78GoY10/ReSz1qqOMfk6	2	t	2026-08-19 09:19:51.192028
22	ффффф	alinaganzha2014@gmail.com	$2b$12$MkZeWpAgc8toNpOV3ORgIOCiGwtZbOSfeWaN3R.GIeBQClm1kNuYS	2	t	2026-08-19 10:37:52.361081
23	Deus Vultovich	example2@yandex.ru	$2b$12$1klPtQ6r.VkAEhYPsSFf7.DhFVz90FvyZo1KbZeg0XbRmUt.if8qG	2	t	2026-08-19 11:56:37.173188
24	egor1	e@e.e	$2b$12$uFHGSvfBZooChmEOEy1zFuidvNZu1MTSnU98EHNRTs2Fic6S5IKQW	2	t	2026-08-20 08:25:51.23392
25	egor12	egor1@egor.egor	$2b$12$lYDSFZRYdF..OK0.fM5TzO.hhIpegfd4NQ0/ovX9zgaD4Dc4Bcn22	2	t	2026-08-20 08:26:36.252786
26	Тестировщик	testirovshik@gmail.com	$2b$12$GvOcbelPqglVuUmqjAJ0nebU.nwLYcro1w.WMRh4w/8tBZ6qXOxnO	2	t	2026-08-21 04:30:41.176876
27	Тестировщик1	zloytestirovshik@gmail.com	$2b$12$CtlplPC/6zANpK4H15aC4eVgSvZhBmukhT7uiplzhqLkpp1V/bid6	2	t	2026-08-21 04:42:39.32216
28	statkr1	statkr1@m.ru	$2b$12$9xScgdNq1IWiXlvY.6cnUuP2bnSJsgi9sunHFTgH8v9J3hkldom9.	2	t	2026-08-21 07:53:11.347153
29	statkr2@m.ru	statkr2@m.ru	$2b$12$bBWaaZEZROEb4Tc5Jm79v.2tKcM/7j5GaXld7303iDfTCAi/n/ZOi	2	t	2026-08-21 07:53:32.018205
30	statkr4@m.ru	statkr4@m.ru	$2b$12$4fbleFnu1353CTxekTc20OwcWZMz.yjV5PEYjm1g7J8v2kvKg9Qhy	2	t	2026-08-21 07:54:01.65604
33	olololololo23@m.ru	olololololo23@m.ru	$2b$12$XgrrPhukDOlbkRk6.hFpJOCKTJpMYwtSKdGiho3WyXhmCL/syqDK.	2	t	2026-08-21 08:00:39.570274
34	234234sd@mmm.ru	234234sd@mmm.ru	$2b$12$GGydzLtwg88sA4SDm2BcSewgP.4P7WoI9L8To.gfuP5.7nCnMBz42	2	t	2026-08-21 08:50:38.125451
35	Никита Шмяк	melnikovnekit91@gmail.com	$2b$12$shZTxW0ntmF5ZlwynR6ffe5Lbq0ButGp8zVT4vLFiJOgIvu78CqAe	2	t	2026-08-21 09:21:35.622028
36	Deus Vult2	example3@yandex.ru	$2b$12$FMtng25oPK6fLwwgixhBReMSWJyhrPtG4D65tCRX8DdLu5RGXgU8K	2	t	2026-08-21 15:25:24.440071
37	Egor	egorshmakov@mail.ru	$2b$12$60xi3a.1.MWraAVrPTaPguLFkwJu2MvKQ7zG2dnxsqpw0jxRaFbfW	2	t	2026-08-23 12:38:58.78984
\.


--
-- Name: answers_id_seq; Type: SEQUENCE SET; Schema: z1; Owner: z1
--

SELECT pg_catalog.setval('z1.answers_id_seq', 4052, true);


--
-- Name: card_types_id_seq; Type: SEQUENCE SET; Schema: z1; Owner: z1
--

SELECT pg_catalog.setval('z1.card_types_id_seq', 4, true);


--
-- Name: cards_id_seq; Type: SEQUENCE SET; Schema: z1; Owner: z1
--

SELECT pg_catalog.setval('z1.cards_id_seq', 1210, true);


--
-- Name: difficulties_id_seq; Type: SEQUENCE SET; Schema: z1; Owner: z1
--

SELECT pg_catalog.setval('z1.difficulties_id_seq', 3, true);


--
-- Name: faq_id_seq; Type: SEQUENCE SET; Schema: z1; Owner: z1
--

SELECT pg_catalog.setval('z1.faq_id_seq', 7, true);


--
-- Name: professions_id_seq; Type: SEQUENCE SET; Schema: z1; Owner: z1
--

SELECT pg_catalog.setval('z1.professions_id_seq', 1, false);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: z1; Owner: z1
--

SELECT pg_catalog.setval('z1.roles_id_seq', 2, true);


--
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: z1; Owner: z1
--

SELECT pg_catalog.setval('z1.tags_id_seq', 55, true);


--
-- Name: tests_id_seq; Type: SEQUENCE SET; Schema: z1; Owner: z1
--

SELECT pg_catalog.setval('z1.tests_id_seq', 16, true);


--
-- Name: topics_id_seq; Type: SEQUENCE SET; Schema: z1; Owner: z1
--

SELECT pg_catalog.setval('z1.topics_id_seq', 13, true);


--
-- Name: user_test_results_id_seq; Type: SEQUENCE SET; Schema: z1; Owner: z1
--

SELECT pg_catalog.setval('z1.user_test_results_id_seq', 88, true);


--
-- Name: user_topic_counters_id_seq; Type: SEQUENCE SET; Schema: z1; Owner: z1
--

SELECT pg_catalog.setval('z1.user_topic_counters_id_seq', 36, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: z1; Owner: z1
--

SELECT pg_catalog.setval('z1.users_id_seq', 37, true);


--
-- Name: answers answers_pkey; Type: CONSTRAINT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.answers
    ADD CONSTRAINT answers_pkey PRIMARY KEY (id);


--
-- Name: card_types card_types_name_key; Type: CONSTRAINT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.card_types
    ADD CONSTRAINT card_types_name_key UNIQUE (name);


--
-- Name: card_types card_types_pkey; Type: CONSTRAINT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.card_types
    ADD CONSTRAINT card_types_pkey PRIMARY KEY (id);


--
-- Name: cards cards_pkey; Type: CONSTRAINT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.cards
    ADD CONSTRAINT cards_pkey PRIMARY KEY (id);


--
-- Name: difficulties difficulties_name_key; Type: CONSTRAINT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.difficulties
    ADD CONSTRAINT difficulties_name_key UNIQUE (name);


--
-- Name: difficulties difficulties_pkey; Type: CONSTRAINT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.difficulties
    ADD CONSTRAINT difficulties_pkey PRIMARY KEY (id);


--
-- Name: faq faq_pkey; Type: CONSTRAINT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.faq
    ADD CONSTRAINT faq_pkey PRIMARY KEY (id);


--
-- Name: profession_tags profession_tags_pkey; Type: CONSTRAINT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.profession_tags
    ADD CONSTRAINT profession_tags_pkey PRIMARY KEY (profession_id, tag_id);


--
-- Name: professions professions_name_key; Type: CONSTRAINT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.professions
    ADD CONSTRAINT professions_name_key UNIQUE (name);


--
-- Name: professions professions_pkey; Type: CONSTRAINT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.professions
    ADD CONSTRAINT professions_pkey PRIMARY KEY (id);


--
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: test_cards test_cards_pkey; Type: CONSTRAINT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.test_cards
    ADD CONSTRAINT test_cards_pkey PRIMARY KEY (test_id, card_id);


--
-- Name: tests tests_pkey; Type: CONSTRAINT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.tests
    ADD CONSTRAINT tests_pkey PRIMARY KEY (id);


--
-- Name: topic_professions topic_professions_pkey; Type: CONSTRAINT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.topic_professions
    ADD CONSTRAINT topic_professions_pkey PRIMARY KEY (topic_id, profession_id);


--
-- Name: topic_tags topic_tags_pkey; Type: CONSTRAINT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.topic_tags
    ADD CONSTRAINT topic_tags_pkey PRIMARY KEY (topic_id, tag_id);


--
-- Name: topics topics_pkey; Type: CONSTRAINT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.topics
    ADD CONSTRAINT topics_pkey PRIMARY KEY (id);


--
-- Name: user_test_results user_test_results_pkey; Type: CONSTRAINT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.user_test_results
    ADD CONSTRAINT user_test_results_pkey PRIMARY KEY (id);


--
-- Name: user_topic_counters user_topic_counters_pkey; Type: CONSTRAINT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.user_topic_counters
    ADD CONSTRAINT user_topic_counters_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: idx_answers_card_id; Type: INDEX; Schema: z1; Owner: z1
--

CREATE INDEX idx_answers_card_id ON z1.answers USING btree (card_id);


--
-- Name: idx_answers_title; Type: INDEX; Schema: z1; Owner: z1
--

CREATE INDEX idx_answers_title ON z1.answers USING btree (title);


--
-- Name: idx_cards_card_type_id; Type: INDEX; Schema: z1; Owner: z1
--

CREATE INDEX idx_cards_card_type_id ON z1.cards USING btree (card_type_id);


--
-- Name: idx_cards_title; Type: INDEX; Schema: z1; Owner: z1
--

CREATE INDEX idx_cards_title ON z1.cards USING btree (title);


--
-- Name: idx_cards_topic_id; Type: INDEX; Schema: z1; Owner: z1
--

CREATE INDEX idx_cards_topic_id ON z1.cards USING btree (topic_id);


--
-- Name: idx_professions_created_at; Type: INDEX; Schema: z1; Owner: z1
--

CREATE INDEX idx_professions_created_at ON z1.professions USING btree (created_at);


--
-- Name: idx_professions_name; Type: INDEX; Schema: z1; Owner: z1
--

CREATE INDEX idx_professions_name ON z1.professions USING btree (name);


--
-- Name: idx_tags_name; Type: INDEX; Schema: z1; Owner: z1
--

CREATE INDEX idx_tags_name ON z1.tags USING btree (name);


--
-- Name: idx_topics_code; Type: INDEX; Schema: z1; Owner: z1
--

CREATE INDEX idx_topics_code ON z1.topics USING btree (code);


--
-- Name: idx_topics_name; Type: INDEX; Schema: z1; Owner: z1
--

CREATE INDEX idx_topics_name ON z1.topics USING btree (name);


--
-- Name: idx_users_created_at; Type: INDEX; Schema: z1; Owner: z1
--

CREATE INDEX idx_users_created_at ON z1.users USING btree (created_at);


--
-- Name: idx_users_email; Type: INDEX; Schema: z1; Owner: z1
--

CREATE INDEX idx_users_email ON z1.users USING btree (email);


--
-- Name: idx_users_role_id; Type: INDEX; Schema: z1; Owner: z1
--

CREATE INDEX idx_users_role_id ON z1.users USING btree (role_id);


--
-- Name: idx_users_username; Type: INDEX; Schema: z1; Owner: z1
--

CREATE INDEX idx_users_username ON z1.users USING btree (username);


--
-- Name: ix_answers_id; Type: INDEX; Schema: z1; Owner: z1
--

CREATE INDEX ix_answers_id ON z1.answers USING btree (id);


--
-- Name: ix_cards_id; Type: INDEX; Schema: z1; Owner: z1
--

CREATE INDEX ix_cards_id ON z1.cards USING btree (id);


--
-- Name: ix_faq_id; Type: INDEX; Schema: z1; Owner: z1
--

CREATE INDEX ix_faq_id ON z1.faq USING btree (id);


--
-- Name: ix_tags_id; Type: INDEX; Schema: z1; Owner: z1
--

CREATE INDEX ix_tags_id ON z1.tags USING btree (id);


--
-- Name: ix_tests_code; Type: INDEX; Schema: z1; Owner: z1
--

CREATE UNIQUE INDEX ix_tests_code ON z1.tests USING btree (code);


--
-- Name: ix_topics_code; Type: INDEX; Schema: z1; Owner: z1
--

CREATE UNIQUE INDEX ix_topics_code ON z1.topics USING btree (code);


--
-- Name: ix_topics_id; Type: INDEX; Schema: z1; Owner: z1
--

CREATE INDEX ix_topics_id ON z1.topics USING btree (id);


--
-- Name: ix_user_topic_counters_id; Type: INDEX; Schema: z1; Owner: z1
--

CREATE INDEX ix_user_topic_counters_id ON z1.user_topic_counters USING btree (id);


--
-- Name: ix_user_topic_counters_user_topic; Type: INDEX; Schema: z1; Owner: z1
--

CREATE UNIQUE INDEX ix_user_topic_counters_user_topic ON z1.user_topic_counters USING btree (user_id, topic_id);


--
-- Name: answers answers_card_id_fkey; Type: FK CONSTRAINT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.answers
    ADD CONSTRAINT answers_card_id_fkey FOREIGN KEY (card_id) REFERENCES z1.cards(id);


--
-- Name: cards cards_card_type_id_fkey; Type: FK CONSTRAINT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.cards
    ADD CONSTRAINT cards_card_type_id_fkey FOREIGN KEY (card_type_id) REFERENCES z1.card_types(id) ON DELETE CASCADE;


--
-- Name: cards cards_topic_id_fkey; Type: FK CONSTRAINT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.cards
    ADD CONSTRAINT cards_topic_id_fkey FOREIGN KEY (topic_id) REFERENCES z1.topics(id);


--
-- Name: profession_tags profession_tags_profession_id_fkey; Type: FK CONSTRAINT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.profession_tags
    ADD CONSTRAINT profession_tags_profession_id_fkey FOREIGN KEY (profession_id) REFERENCES z1.professions(id) ON DELETE CASCADE;


--
-- Name: profession_tags profession_tags_tag_id_fkey; Type: FK CONSTRAINT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.profession_tags
    ADD CONSTRAINT profession_tags_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES z1.tags(id) ON DELETE CASCADE;


--
-- Name: test_cards test_cards_card_id_fkey; Type: FK CONSTRAINT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.test_cards
    ADD CONSTRAINT test_cards_card_id_fkey FOREIGN KEY (card_id) REFERENCES z1.cards(id) ON DELETE CASCADE;


--
-- Name: test_cards test_cards_test_id_fkey; Type: FK CONSTRAINT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.test_cards
    ADD CONSTRAINT test_cards_test_id_fkey FOREIGN KEY (test_id) REFERENCES z1.tests(id) ON DELETE CASCADE;


--
-- Name: tests tests_difficulty_id_fkey; Type: FK CONSTRAINT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.tests
    ADD CONSTRAINT tests_difficulty_id_fkey FOREIGN KEY (difficulty_id) REFERENCES z1.difficulties(id);


--
-- Name: tests tests_profession_id_fkey; Type: FK CONSTRAINT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.tests
    ADD CONSTRAINT tests_profession_id_fkey FOREIGN KEY (profession_id) REFERENCES z1.professions(id) ON DELETE SET NULL;


--
-- Name: topic_professions topic_professions_profession_id_fkey; Type: FK CONSTRAINT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.topic_professions
    ADD CONSTRAINT topic_professions_profession_id_fkey FOREIGN KEY (profession_id) REFERENCES z1.professions(id) ON DELETE CASCADE;


--
-- Name: topic_professions topic_professions_topic_id_fkey; Type: FK CONSTRAINT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.topic_professions
    ADD CONSTRAINT topic_professions_topic_id_fkey FOREIGN KEY (topic_id) REFERENCES z1.topics(id) ON DELETE CASCADE;


--
-- Name: topic_tags topic_tags_tag_id_fkey; Type: FK CONSTRAINT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.topic_tags
    ADD CONSTRAINT topic_tags_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES z1.tags(id);


--
-- Name: topic_tags topic_tags_topic_id_fkey; Type: FK CONSTRAINT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.topic_tags
    ADD CONSTRAINT topic_tags_topic_id_fkey FOREIGN KEY (topic_id) REFERENCES z1.topics(id);


--
-- Name: user_test_results user_test_results_test_id_fkey; Type: FK CONSTRAINT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.user_test_results
    ADD CONSTRAINT user_test_results_test_id_fkey FOREIGN KEY (test_id) REFERENCES z1.tests(id);


--
-- Name: user_test_results user_test_results_user_id_fkey; Type: FK CONSTRAINT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.user_test_results
    ADD CONSTRAINT user_test_results_user_id_fkey FOREIGN KEY (user_id) REFERENCES z1.users(id);


--
-- Name: user_topic_counters user_topic_counters_topic_id_fkey; Type: FK CONSTRAINT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.user_topic_counters
    ADD CONSTRAINT user_topic_counters_topic_id_fkey FOREIGN KEY (topic_id) REFERENCES z1.topics(id);


--
-- Name: user_topic_counters user_topic_counters_user_id_fkey; Type: FK CONSTRAINT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.user_topic_counters
    ADD CONSTRAINT user_topic_counters_user_id_fkey FOREIGN KEY (user_id) REFERENCES z1.users(id);


--
-- Name: users users_role_id_fkey; Type: FK CONSTRAINT; Schema: z1; Owner: z1
--

ALTER TABLE ONLY z1.users
    ADD CONSTRAINT users_role_id_fkey FOREIGN KEY (role_id) REFERENCES z1.roles(id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

\unrestrict ouUDVrcFjXTy5XGOhKbaXvRyL6IsA84uNkHXSiBxdlcJORLpN87zCWfbBuDzFkv

