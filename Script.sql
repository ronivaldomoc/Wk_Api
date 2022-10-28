
CREATE TABLE public.endereco_inetgracao (
	idendereco int8 NOT NULL,
	dsuf varchar(50) NOT NULL,
	nmcidade varchar(100) NOT NULL,
	nmbairro varchar(50) NOT NULL,
	nmlogradouro varchar(100) NOT NULL,
	dscomplemento varchar(100) NOT NULL,
	CONSTRAINT enderecointegracao_pk PRIMARY KEY (idendereco)
);


CREATE TABLE public.pessoa (
	idpessoa int8 NOT NULL,
	flnatureza int2 NOT NULL,
	dsdocumento varchar(20) NOT NULL,
	nmprimeiro varchar(100) NOT NULL,
	nmsegundo varchar(100) NOT NULL,
	dtregistro date NULL,
	CONSTRAINT pessoa_pk PRIMARY KEY (idpessoa)
);


CREATE TABLE public.endereco (
	idendereco int8 NOT NULL,
	idpessoa int8 NOT NULL,
	dscep varchar(15) NOT NULL,
	CONSTRAINT endereco_pk PRIMARY KEY (idendereco, idpessoa),
	CONSTRAINT endereco_fk FOREIGN KEY (idpessoa) REFERENCES public.pessoa(idpessoa),
	CONSTRAINT endereco_fk_1 FOREIGN KEY (idendereco) REFERENCES public.endereco_inetgracao(idendereco)
);
CREATE INDEX endereco_idpessoa ON public.endereco USING btree (idpessoa);