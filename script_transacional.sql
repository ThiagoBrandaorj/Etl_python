create table pesquisa (
pesquisa_id SERIAL PRIMARY key,
pesquisa_nome varchar(128) not null,
data_inicio timestamp not null,
data_fim timestamp not null,
data_cadastro timestamp not null default current_timestamp,
ativo boolean not null default true
);

COMMENT ON TABLE pesquisa IS 'Tabela que armazena as pesquisas';
comment on column pesquisa.pesquisa_id is 'Chave primária da tabela';
comment on column pesquisa.pesquisa_nome is 'Nome da pesquisa';
comment on column pesquisa.data_inicio is 'Data de início da pesquisa';
comment on column pesquisa.data_fim is 'Data de encerramento da pesquisa';
comment on column pesquisa.data_cadastro is 'Data de cadastro do registro';
comment on column pesquisa.ativo is 'Se a pesquisa está ativa ou não (Éxclusão lógica)';


create table pesquisa_pergunta_tipo(
pesquisa_pergunta_tipo_id SERIAL PRIMARY key, 
pesquisa_pergunta_tipo varchar(32) not null,
data_cadastro timestamp not null default current_timestamp,
ativo boolean not null default true	
);

create table pesquisa_pergunta(
pesquisa_pergunta_id SERIAL PRIMARY key,
pesquisa_id int not null,
pesquisa_pergunta_tipo_id int not null,
data_cadastro timestamp not null default current_timestamp,
ativo boolean not null default true,
pergunta_texto varchar(2048),

constraint fk_pesquisa_x_pergunta_pesquisa foreign key (pesquisa_id) references pesquisa(pesquisa_id),
constraint fk_pesquisa_pergunta_x_pesquisa_pergunta_tipo foreign key (pesquisa_pergunta_tipo_id) references pesquisa_pergunta_tipo(pesquisa_pergunta_tipo_id)	
);

create table genero(
genero_id SERIAL PRIMARY key,
genero varchar(128)
);



create table entrevistado(
entrevistado_id SERIAL PRIMARY key,
entrevistado_nome varchar(256) not null,
entrevistado_email varchar(128),
entrevistado_nome_social varchar(32),
entrevistado_data_nascimento date not null,
sexo char(1) not null, 
genero_id int not null,
data_cadastro timestamp not null default current_timestamp,
constraint fk_entrevistado_x_genero foreign key (genero_id) references genero(genero_id)

);

create table telefone_tipo(
telefone_tipo_id SERIAL PRIMARY key,
telefone_tipo varchar(32),
ativo boolean not null default true
);


create table entrevistado_telefone(
entrevistado_telefone_id SERIAL PRIMARY key,
entrevistado_id int,
ddi int not null default 55,
ddd int not null,
telefone int not null,
telefone_tipo_id int not null,
eh_telefone_principal boolean not null default true,
data_cadastro timestamp not null default current_timestamp,
ativo boolean not null default true,	
constraint fk_entrevistado_telefone_x_entrevistado foreign key (entrevistado_id) references entrevistado(entrevistado_id),
constraint fk_entrevistado_telefone_x_telefone_tipo foreign key (telefone_tipo_id) references telefone_tipo(telefone_tipo_id)
);


create table pergunta_resposta
(
pergunta_resposta_id SERIAL PRIMARY key,
pesquisa_pergunta_id int not null,
entrevistado_id int not null,
resposta varchar(2048),
data_cadastro timestamp not null default current_timestamp,

constraint fk_pergunta_resposta_x_pesquisa_pergunta foreign key (pesquisa_pergunta_id) references pesquisa_pergunta(pesquisa_pergunta_id),
constraint fk_pergunta_resposta_x_entrevistado foreign key (entrevistado_id) references entrevistado(entrevistado_id)
);

create table pesquisa_pergunta_opcao
(
pesquisa_pergunta_opcao_id SERIAL PRIMARY key,
pesquisa_pergunta_id int,
indice int not null default 1,
opcao varchar(128),

data_cadastro timestamp not null default current_timestamp,
ativo boolean not null default true,		

constraint fk_pesquisa_pergunta_opcao_x_pesquisa_pergunta foreign key (pesquisa_pergunta_id) references pesquisa_pergunta(pesquisa_pergunta_id)
);

COMMENT ON TABLE pesquisa_pergunta_opcao IS 'Tabela que armazena as opções no caso de perguntas do tipo não aberta';
comment on column pesquisa_pergunta_opcao.pesquisa_pergunta_opcao_id is 'Chave primária da tabela';
comment on column pesquisa_pergunta_opcao.pesquisa_pergunta_id is 'Chave estrangeira da Pergunta';
comment on column pesquisa_pergunta_opcao.indice is 'Campo que armazena o indice da opção, para dar liberdade de exibicao da ordem das opções';
comment on column pesquisa_pergunta_opcao.opcao is 'Label da opção';
comment on column pesquisa_pergunta_opcao.data_cadastro is 'Data de cadastro do Registro';
comment on column pesquisa_pergunta_opcao.ativo is 'Se opção está ativa ou não (Exclusão lógica)';


create table entrevistado_endereco( 
entrevistado_endereco_id SERIAL PRIMARY key,
entrevistado_id int not null,
logradouro varchar(256) not null,
numero varchar(64) not null,
complemento varchar(256),
bairro varchar(256) not null,
cidade varchar(256) not null,
uf varchar(2) not null,
cep varchar(8) not null,
descricao varchar(32),
constraint fk_entrevistado_endereco_x_entrevistado foreign key (entrevistado_id) references entrevistado(entrevistado_id)
); 