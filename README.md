# ☕ Sistema de Controle de Vendas - Cafeteria BomGosto

Este projeto implementa o **modelo de banco de dados** para uma cafeteria fictícia chamada **BomGosto**, que deseja registrar suas vendas de café por meio de comandas digitais.  
Faz parte da **Atividade 08 - Modelando, Construindo e Pesquisando** do curso **Desenvolvedor Fullstack Jr (Codifica Edu)**.

---

## 🧱 Estrutura do Banco de Dados

O sistema foi dividido em três entidades principais:

| Tabela | Função |
|--------|---------|
| **menu_cafe** | Catálogo de cafés com nome, detalhes e valor unitário |
| **pedido** | Registro principal de cada comanda (data, mesa, cliente) |
| **item_pedido** | Relacionamento entre pedido e cafés vendidos, com quantidades |

O relacionamento é de **1:N** entre `pedido` → `item_pedido`, e cada `item_pedido` referencia um café no `menu_cafe`.

---

## 💾 Scripts Incluídos

1. **Criação das tabelas (DDL)**  
   Define as estruturas, chaves primárias e estrangeiras, e restrições de integridade.

2. **Inserção de dados de exemplo (DML)**  
   Adiciona cafés e pedidos fictícios para simulação das consultas.

3. **Consultas SQL principais (SELECT):**
   - **Listagem do menu** — mostra os cafés ordenados alfabeticamente.  
   - **Detalhamento de pedidos e itens** — une as três tabelas e mostra preços e totais.  
   - **Total por comanda** — soma o valor total de cada pedido.  
   - **Comandas com mais de um tipo** — filtra apenas quem comprou mais de um tipo de café.  
   - **Faturamento diário** — total de vendas agrupado por data.

---

## 🧰 Como Executar

1. Crie um novo banco de dados (MySQL ou PostgreSQL):
   ```sql
   CREATE DATABASE cafeteria_sql;
   ```

2. Abra o arquivo cafeteria.sql e execute todo o conteúdo.

Rode as consultas (SELECT) para visualizar os resultados.
