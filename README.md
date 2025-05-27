# 📦 Banco de Dados - Sistema de Artesanato

Este repositório contém o script SQL para criação, inserção, atualização, exclusão e consulta em um banco de dados voltado para um sistema de **artesanato**, com foco em usuários (artesãos e administradores), gerenciamento de feeds, pedidos de materiais e eventos.

## 🛠️ Tecnologias

- PostgreSQL
- SQL padrão com uso de tipos ENUM personalizados

---

## 🧱 Estrutura do Banco de Dados

### Tabelas principais

- `tipo_usuarios`: Define os tipos de usuários (Artesão, Administrador).
- `estados`: Lista de estados brasileiros.
- `usuarios`: Cadastro de artesãos e administradores.
- `categorias`: Tipos de categorias de produtos artesanais.
- `feeds`: Publicações de produtos/artigos dos artesãos.
- `imagem_feeds`: Imagens associadas aos feeds.
- `pedidos`: Solicitações de materiais por parte dos artesãos.
- `eventos`: Eventos relacionados ao artesanato (feiras, workshops, etc.).
- `imagem_eventos`: Imagens associadas aos eventos.
- `reset_senhas`: Gerenciamento de redefinição de senha com token e validade.

---

## 📋 Tipos ENUM utilizados

- `categoria`: `('ceramica', 'textil', 'madeira', 'joalheria', 'cestaria', 'outro')`
- `status_feeds`: `('publicado', 'rascunho', 'agendado')`
- `prioridade_pedidos`: `('baixa', 'media', 'alta')`
- `categoria_eventos`: `('feira', 'workshop', 'exposicao', 'curso', 'palestra', 'outro')`

---

## 🔄 Funcionalidades por Script

### ✅ CREATE
Criação de todas as tabelas com constraints de integridade (chaves estrangeiras e únicas).

### ➕ INSERT
População inicial das tabelas com:
- Tipos de usuários
- Estados brasileiros
- Usuários fictícios (ex: Maria da Silva)
- Categorias, feeds, imagens, pedidos e eventos

### ✏️ UPDATE
Exemplos de atualização de:
- Nome de usuário
- Status de feed
- Prioridade de pedido
- Validação de uso de token

### ❌ DELETE
Exclusão em cascata de registros relacionados a:
- Imagens de eventos
- Feeds e suas imagens
- Tokens de senha
- Pedidos e usuários

### 🔍 SELECT
Consultas como:
- Listagem de usuários com tipo e estado
- Feeds publicados
- Eventos futuros
- Pedidos por prioridade

---

## 📁 Estrutura Recomendada de Pastas

```
📦 DoArte-db/
 ┣ 📄 README.md
 ┣ 📄 doArte-db.sql
```

---

## 🚀 Como usar

1. Clone este repositório:
   ```bash
   git clone https://github.com/maiaraguanha/doArte-db.git
   ```
2. Acesse o diretório:
   ```bash
   cd doArte-db
   ```
3. Execute o script SQL no seu banco PostgreSQL:
   ```sql
   \i doArte-db.sql
   ```