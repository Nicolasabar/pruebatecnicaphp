PGDMP         2                {            pruebatecnicaphp    15.1    15.1 #               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    16408    pruebatecnicaphp    DATABASE     �   CREATE DATABASE pruebatecnicaphp WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Chile.1252';
     DROP DATABASE pruebatecnicaphp;
                postgres    false            �            1259    16514 
   candidatos    TABLE     g   CREATE TABLE public.candidatos (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL
);
    DROP TABLE public.candidatos;
       public         heap    postgres    false            �            1259    16513    candidatos_id_seq    SEQUENCE     �   CREATE SEQUENCE public.candidatos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.candidatos_id_seq;
       public          postgres    false    219                       0    0    candidatos_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.candidatos_id_seq OWNED BY public.candidatos.id;
          public          postgres    false    218            �            1259    16502    comunas    TABLE     �   CREATE TABLE public.comunas (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    region_id integer NOT NULL
);
    DROP TABLE public.comunas;
       public         heap    postgres    false            �            1259    16501    comunas_id_seq    SEQUENCE     �   CREATE SEQUENCE public.comunas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.comunas_id_seq;
       public          postgres    false    217                        0    0    comunas_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.comunas_id_seq OWNED BY public.comunas.id;
          public          postgres    false    216            �            1259    16495    regiones    TABLE     e   CREATE TABLE public.regiones (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL
);
    DROP TABLE public.regiones;
       public         heap    postgres    false            �            1259    16494    regiones_id_seq    SEQUENCE     �   CREATE SEQUENCE public.regiones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.regiones_id_seq;
       public          postgres    false    215            !           0    0    regiones_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.regiones_id_seq OWNED BY public.regiones.id;
          public          postgres    false    214            �            1259    16521    votantes    TABLE     I  CREATE TABLE public.votantes (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    alias character varying(50) NOT NULL,
    rut character varying(12) NOT NULL,
    email character varying(100) NOT NULL,
    conocio character varying(50) NOT NULL,
    candidato_id integer,
    comuna_id integer NOT NULL
);
    DROP TABLE public.votantes;
       public         heap    postgres    false            �            1259    16520    votantes_id_seq    SEQUENCE     �   CREATE SEQUENCE public.votantes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.votantes_id_seq;
       public          postgres    false    221            "           0    0    votantes_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.votantes_id_seq OWNED BY public.votantes.id;
          public          postgres    false    220            v           2604    16517    candidatos id    DEFAULT     n   ALTER TABLE ONLY public.candidatos ALTER COLUMN id SET DEFAULT nextval('public.candidatos_id_seq'::regclass);
 <   ALTER TABLE public.candidatos ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    218    219    219            u           2604    16505 
   comunas id    DEFAULT     h   ALTER TABLE ONLY public.comunas ALTER COLUMN id SET DEFAULT nextval('public.comunas_id_seq'::regclass);
 9   ALTER TABLE public.comunas ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    217    217            t           2604    16498    regiones id    DEFAULT     j   ALTER TABLE ONLY public.regiones ALTER COLUMN id SET DEFAULT nextval('public.regiones_id_seq'::regclass);
 :   ALTER TABLE public.regiones ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    214    215            w           2604    16524    votantes id    DEFAULT     j   ALTER TABLE ONLY public.votantes ALTER COLUMN id SET DEFAULT nextval('public.votantes_id_seq'::regclass);
 :   ALTER TABLE public.votantes ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    221    221                      0    16514 
   candidatos 
   TABLE DATA           0   COPY public.candidatos (id, nombre) FROM stdin;
    public          postgres    false    219   �%                 0    16502    comunas 
   TABLE DATA           8   COPY public.comunas (id, nombre, region_id) FROM stdin;
    public          postgres    false    217   &                 0    16495    regiones 
   TABLE DATA           .   COPY public.regiones (id, nombre) FROM stdin;
    public          postgres    false    215   �&                 0    16521    votantes 
   TABLE DATA           c   COPY public.votantes (id, nombre, alias, rut, email, conocio, candidato_id, comuna_id) FROM stdin;
    public          postgres    false    221   �'       #           0    0    candidatos_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.candidatos_id_seq', 3, true);
          public          postgres    false    218            $           0    0    comunas_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.comunas_id_seq', 18, true);
          public          postgres    false    216            %           0    0    regiones_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.regiones_id_seq', 16, true);
          public          postgres    false    214            &           0    0    votantes_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.votantes_id_seq', 1, true);
          public          postgres    false    220            }           2606    16519    candidatos candidatos_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.candidatos
    ADD CONSTRAINT candidatos_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.candidatos DROP CONSTRAINT candidatos_pkey;
       public            postgres    false    219            {           2606    16507    comunas comunas_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.comunas
    ADD CONSTRAINT comunas_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.comunas DROP CONSTRAINT comunas_pkey;
       public            postgres    false    217            y           2606    16500    regiones regiones_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.regiones
    ADD CONSTRAINT regiones_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.regiones DROP CONSTRAINT regiones_pkey;
       public            postgres    false    215                       2606    16526    votantes votantes_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.votantes
    ADD CONSTRAINT votantes_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.votantes DROP CONSTRAINT votantes_pkey;
       public            postgres    false    221            �           2606    16508    comunas comunas_region_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.comunas
    ADD CONSTRAINT comunas_region_id_fkey FOREIGN KEY (region_id) REFERENCES public.regiones(id);
 H   ALTER TABLE ONLY public.comunas DROP CONSTRAINT comunas_region_id_fkey;
       public          postgres    false    3193    215    217            �           2606    16527 #   votantes votantes_candidato_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.votantes
    ADD CONSTRAINT votantes_candidato_id_fkey FOREIGN KEY (candidato_id) REFERENCES public.candidatos(id);
 M   ALTER TABLE ONLY public.votantes DROP CONSTRAINT votantes_candidato_id_fkey;
       public          postgres    false    3197    219    221            �           2606    16532     votantes votantes_comuna_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.votantes
    ADD CONSTRAINT votantes_comuna_id_fkey FOREIGN KEY (comuna_id) REFERENCES public.comunas(id);
 J   ALTER TABLE ONLY public.votantes DROP CONSTRAINT votantes_comuna_id_fkey;
       public          postgres    false    3195    217    221               $   x�3�tN�K�LI,�Wp�2B�9q#�b���� O�3         �   x�%��n�0���S�	����(dH
���t�B،��Y^�Vٻ��*��w�yt�)�g��LI#OE��朸�{��H�+�Z�%^.s�̌Ƭ�%�=����e�F�W�^�s�l��p�Q�-v*��j�gfJu��Z�P��h�)Z�Z��wy4+z�c����5��$���\��H�5�Eh��rU)ڎ��v`�3����'c���J�         �   x�]��N1�k�)��!�iR�	͜1�%g�8��<�@Iq���i�M���jg���:�X�Y����:�GL�a$�.j�F��E�M����!�����n�c��A躦/c���(t�'�6M2J�	���	�<��m~8�z�<G��pP=�`I�70�Ñ��{�"����&�8/ ݴ�$�]�Dҫ��+/��^b�f�M����Fz=#�_7��         F   x�3��*M�S8��(�
��,��4426153�е�̂9��&f��%��r�%&�&��gsrr��qqq ��     