-- CRIAR (CREATE) TABELAS E COLUNAS

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

-- REDEFINIÇÃO DE SENHA

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

-- INSERIR (INSERT) DADOS NAS COLUNAS DAS TABELAS

-- Inserir tipo de USUARIO
INSERT INTO tipo_usuarios (nome) VALUES ('Artesão'), ('Administrador');

-- Inserir ESTADOS
INSERT INTO estados (nome) VALUES 
('Acre'),
('Alagoas'),
('Amapá'),
('Amazonas'),
('Bahia'),
('Ceará'),
('Distrito Federal'),
('Espírito Santo'),
('Goiás'),
('Maranhão'),
('Mato Grosso'),
('Mato Grosso do Sul'),
('Minas Gerais'),
('Pará'),
('Paraíba'),
('Paraná'),
('Pernambuco'),
('Piauí'),
('Rio de Janeiro'),
('Rio Grande do Norte'),
('Rio Grande do Sul'),
('Rondônia'),
('Roraima'),
('Santa Catarina'),
('São Paulo'),
('Sergipe'),
('Tocantins');

-- Inserir USUARIO
INSERT INTO usuarios (
    id_tipo_usuario, id_estado, nome, cpf, logradouro, bairro,
    numero, cep, cidade, telefone, whatsapp, descricao, email, senha
) VALUES
(1, 1, 'Maria da Silva', '123.456.789-00', 'Rua A', 'Centro',
'123', '01234-567', 'São Paulo', '11999999999', '11988888888',
'Artesã especializada em cerâmica.', 'maria@email.com', 'senhaSegura123'),

( 1, 2, 'João Pereira', '111.222.333-44', 'Rua das Flores', 'Jardim América',
'100', '70000-000', 'Maceió', '82999990000', '82988887777',
'Trabalha com madeira artesanal há 10 anos.', 'joao@artesanato.com', 'senhaJoao123'),

(1, 3, 'Ana Souza', '222.333.444-55', 'Av. Central', 'Centro',
'200', '69000-000', 'Manaus', '92999991111', '92988886666',
'Especialista em cestaria amazônica.', 'ana@artesanato.com', 'senhaAna456'),

(1, 4, 'Carlos Lima', '333.444.555-66', 'Rua do Sol', 'Bela Vista',
'300', '40000-000', 'Salvador', '71999992222', '71988885555',
'Produz peças têxteis em tear manual.', 'carlos@artesanato.com', 'senhaCarlos789'),

(1, 5, 'Juliana Oliveira', '444.555.666-77', 'Travessa das Artes', 'Santa Maria',
'400', '50000-000', 'Recife', '81999993333', '81988884444',
'Joalheira com foco em materiais sustentáveis.', 'juliana@artesanato.com', 'senhaJuliana321'),

(1, 1, 'Bruno Silva', '555.666.777-88', 'Alameda Criativa', 'São Francisco',
'500', '60000-000', 'Rio Branco', '68999994444', '68988883333',
'Ceramista autodidata com ateliê próprio.', 'bruno@artesanato.com', 'senhaBruno654');


-- Inserir CATEGORIA
INSERT INTO categorias (categoria) VALUES ('ceramica'), ('madeira');

-- Inserir FEED
INSERT INTO feeds (
    id_usuario, id_categoria, titulo, subtitulo, autor, descricao, tags,
    material, tempo_producao, localizacao, status
) VALUES
(1, 1, 'Vaso de cerâmica', 'Feito à mão', 'Maria da Silva', 'Peça artesanal decorativa.',
'cerâmica,vaso', 'argila', '2 dias', 'São Paulo', 'publicado'),

(2, 2, 'Escultura em madeira', 'Arte reciclada', 'João Pereira', 
'Escultura feita com madeira reciclada de demolição.', 'escultura, madeira',
'madeira reciclada', '3 dias', 'Maceió', 'publicado'),

(3, 1, 'Vaso de barro cru', 'Peça rústica', 'Ana Souza',
'Vaso de cerâmica artesanal não esmaltado.', 'vaso, barro',
'barro cru', '1 dia', 'Manaus', 'publicado');

-- Inserir imagem do feed
INSERT INTO imagem_feeds (id_feed, imagem) VALUES (1, 'vaso1.jpg');

-- Inserir PEDIDO
INSERT INTO pedidos (
    id_usuario, titulo, descricao, material, prioridade
) VALUES
(1, 'Pedido de argila', 'Preciso de argila branca', 'argila branca', 'alta'),
(2, 'Compra de madeira', 'Preciso de madeira reciclada para esculturas.', 'madeira reciclada', 'alta'),
(3, 'Fio de sisal', 'Buscando fio de sisal para cestaria artesanal.', 'fio de sisal', 'media'),
(4, 'Tintas naturais', 'Solicito tintas naturais para pintura em tecido.', 'tinta natural', 'baixa');


-- Inserir EVENTO
INSERT INTO eventos (
    id_estado, titulo, descricao, categoria, data_inicio, data_fim, nome_local,
    cep, logradouro, bairro, cidade, numero_vagas, preco, link_evento, contato
) VALUES 
(1, 'Feira de Artesanato', 'Evento com vários artesãos', 'feira',
'2025-08-01', '2025-08-03', 'Centro de Convenções',
'01234-000', 'Av. Central', 'Centro', 'São Paulo', 100, 0.00,
'https://eventoartesanato.com', 'contato@evento.com');

-- Inserir imagem de evento
INSERT INTO imagem_eventos (id_evento, imagem) VALUES (1, 'evento.jpg');

-- Inserir token de REDEFINIÇÃO DE SENHA
INSERT INTO reset_senhas (id_usuario, token, expira_em)
VALUES (1, 'token123456', NOW() + INTERVAL '1 hour');

-- ATUALIZAÇÃO (UPDATE) DO DADOS NAS COLUNAS DAS TABELAS

-- Atualizar nome do usuário
UPDATE usuarios
SET nome = 'Maria da Silva Souza'
WHERE id = 1;

-- Atualizar status do feed
UPDATE feeds
SET status = 'rascunho'
WHERE id = 1;

-- Atualizar prioridade do pedido
UPDATE pedidos
SET prioridade = 'media'
WHERE id = 1;

-- Marcar token como usado
UPDATE reset_senhas
SET usado = TRUE
WHERE token = 'token123456';

-- EXCLUI (DELETE) DADOS NAS COLUNAS DAS TABELAS

-- Remover imagem de EVENTOS
DELETE FROM imagem_eventos WHERE id = 1;

-- Remover FEEDS e imagens associadas (primeiro as imagens)
DELETE FROM imagem_feeds WHERE id_feed = 1;
DELETE FROM feeds WHERE id = 1;

-- Remover registros da tabela reset_senhas que fazem referência ao usuário
DELETE FROM reset_senhas WHERE id_usuario = 1;

-- Remover os pedidos do usuário
DELETE FROM pedidos WHERE id_usuario = 1;

-- Remover o usuário
DELETE FROM usuarios WHERE id = 1;

-- CONSULTAS (SELECT) DOS DADOS

-- Listar todos os usuários com seus tipos e estados
SELECT u.id, u.nome, tu.nome AS tipo, e.nome AS estado
FROM usuarios u
JOIN tipo_usuarios tu ON u.id_tipo_usuario = tu.id
JOIN estados e ON u.id_estado = e.id;

-- Buscar feeds publicados
SELECT f.titulo, f.descricao, c.categoria, u.nome AS autor
FROM feeds f
JOIN categorias c ON f.id_categoria = c.id
JOIN usuarios u ON f.id_usuario = u.id
WHERE f.status = 'publicado';

-- Ver eventos futuros
SELECT titulo, data_inicio, data_fim FROM eventos
WHERE data_inicio >= CURRENT_DATE;

-- Pedidos por prioridade
SELECT titulo, prioridade FROM pedidos
ORDER BY prioridade DESC;
