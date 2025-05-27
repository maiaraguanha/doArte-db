-- USUARIOS

-- Tabela de TIPO de USUARIOS
CREATE TABLE tipo_usuarios (
	id SERIAL PRIMARY KEY,
	nome VARCHAR(100),
	data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de ESTADOS
CREATE TABLE estados (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL
);

-- Tabela de USUARIOS/ ARTESAOS
CREATE TABLE usuarios (
	id SERIAL PRIMARY KEY,
	id_tipo_usuario INTEGER,
	id_estado INTEGER NOT NULL,
	nome VARCHAR(100) NOT NULL,
	cpf VARCHAR(20) UNIQUE NOT NULL,
	logradouro VARCHAR(50) NOT NULL,
	bairro VARCHAR(50) NOT NULL,
	numero VARCHAR(5) NOT NULL,
	cep VARCHAR(20) NOT NULL,
	cidade VARCHAR(100) NOT NULL,
	telefone VARCHAR(20) NOT NULL,
	whatsapp VARCHAR(20),
	descricao TEXT NOT NULL,
	email VARCHAR(100) UNIQUE NOT NULL,
	senha VARCHAR(100) UNIQUE NOT NULL,
	data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	
	FOREIGN KEY (id_tipo_usuario) REFERENCES tipo_usuarios(id),
	FOREIGN KEY (id_estado) REFERENCES estados(id)
);

-- FEEDS

-- Enum e Tabela para categorias no cadastro/ editar FEEDS
CREATE TYPE categoria AS ENUM ('ceramica', 'textil', 'madeira', 'joalheria', 'cestaria', 'outro');

CREATE TABLE categorias (
	id SERIAL PRIMARY KEY,
	categoria categoria NOT NULL
);

-- Enum para status no cadastro/ editar FEEDS
CREATE TYPE status_feeds AS ENUM ('publicado', 'rascunho', 'agendado');

CREATE TABLE feeds (
	id SERIAL PRIMARY KEY,
	id_usuario INTEGER,
	id_categoria INTEGER,
	titulo VARCHAR(50) NOT NULL,
	subtitulo VARCHAR(50),
	autor VARCHAR(50) NOT NULL,
	descricao TEXT NOT NULL,
	tags VARCHAR(30),
	material VARCHAR(100),
	tempo_producao VARCHAR(30),
	localizacao VARCHAR(50),
	status status_feeds NOT NULL DEFAULT 'rascunho',
	data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

	FOREIGN KEY (id_usuario) REFERENCES usuarios(id),
	FOREIGN KEY (id_categoria) REFERENCES categorias(id)
);

-- Tabela de imagens para o cadastro/ editar FEEDS
CREATE TABLE imagem_feeds (
	id SERIAL PRIMARY KEY,
	id_feed INTEGER,
	imagem VARCHAR (100),
	data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	
	FOREIGN KEY (id_feed) REFERENCES feeds(id)
);

-- PEDIDOS

-- Enum para prioridade no cadastro/ editar PEDIDOS
CREATE TYPE prioridade_pedidos AS ENUM ('baixa', 'media', 'alta');

-- Tabela de pedidos de materiais
CREATE TABLE pedidos (
	id SERIAL PRIMARY KEY,
	id_usuario INTEGER,
	titulo VARCHAR(50) NOT NULL,
	descricao TEXT,
	material VARCHAR(50),
	prioridade prioridade_pedidos DEFAULT 'media',
	data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

	FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
);

-- EVENTOS

-- Enum para categoria no cadastro/ editar eventos
CREATE TYPE categoria_eventos AS ENUM ('feira', 'workshop', 'exposicao', 'curso', 'palestra', 'outro');

-- Tabela de eventos
CREATE TABLE eventos (
	id SERIAL PRIMARY KEY,
	id_estado INTEGER NOT NULL,
	titulo VARCHAR(30) NOT NULL,
	descricao TEXT NOT NULL,
	categoria categoria_eventos NOT NULL,
	data_inicio DATE NOT NULL,
	data_fim DATE NOT NULL,
	nome_local VARCHAR(50) NOT NULL,
	cep VARCHAR(20) NOT NULL,
	logradouro VARCHAR(50) NOT NULL,
	bairro VARCHAR(50) NOT NULL,
	cidade VARCHAR(100) NOT NULL,
	numero_vagas INTEGER,
	preco DECIMAL(10,2),
	link_evento VARCHAR(100),
	contato VARCHAR(100),
	data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

	FOREIGN KEY (id_estado) REFERENCES estados(id)
);

-- Tabela de imagens para o cadastro/ editar eventos 
CREATE TABLE imagem_eventos (
	id SERIAL PRIMARY KEY,
	id_evento INTEGER,
	imagem VARCHAR (100),
	data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	
	FOREIGN KEY (id_evento) REFERENCES eventos(id)
);

-- ESQUECEU A SENHA

-- Tabela de forgot password/ esqueceu a senha
CREATE TABLE reset_senhas (
    id SERIAL PRIMARY KEY,
    id_usuario INTEGER NOT NULL,
    token VARCHAR(255) NOT NULL UNIQUE,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expira_em TIMESTAMP NOT NULL,
    usado BOOLEAN DEFAULT FALSE,

    FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
);

