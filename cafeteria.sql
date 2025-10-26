-- ===============================================================
-- Projeto: Sistema de Controle de Vendas - Cafeteria
-- Atividade 08 - Modelagem, Construção e Pesquisa
-- Curso: Desenvolvedor Fullstack Jr - Codifica Edu
-- Autor: Leonardo José Alves Gouvea
-- Data: Outubro/2025
-- ===============================================================

-- ========================
-- CRIAÇÃO DAS TABELAS
-- ========================

-- Tabela de produtos (cafés do menu)
CREATE TABLE menu_cafe (
    id_item SERIAL PRIMARY KEY,
    nome_produto VARCHAR(120) NOT NULL UNIQUE,
    detalhes TEXT,
    valor_unitario DECIMAL(10,2) NOT NULL CHECK (valor_unitario >= 0)
);

-- Tabela de pedidos (comandas)
CREATE TABLE pedido (
    id_pedido SERIAL PRIMARY KEY,
    data_pedido TIMESTAMP NOT NULL,
    mesa_numero INT,
    cliente_nome VARCHAR(120)
);

-- Tabela de itens do pedido (venda de cafés)
CREATE TABLE item_pedido (
    id_pedido INT NOT NULL,
    id_item INT NOT NULL,
    quantidade INT NOT NULL CHECK (quantidade > 0),
    PRIMARY KEY (id_pedido, id_item),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    FOREIGN KEY (id_item) REFERENCES menu_cafe(id_item)
);

-- ========================
-- INSERÇÃO DE DADOS
-- ========================

INSERT INTO menu_cafe (nome_produto, detalhes, valor_unitario) VALUES
('Expresso Clássico', 'Café puro, encorpado e intenso', 4.50),
('Latte Suave', 'Expresso com leite vaporizado e espuma', 6.00),
('Cappuccino Tradicional', 'Expresso com leite cremoso e chocolate em pó', 8.50),
('Mocha Especial', 'Café com chocolate e chantilly', 9.50),
('Macchiato', 'Expresso com leve toque de leite', 5.50);

INSERT INTO pedido (data_pedido, mesa_numero, cliente_nome) VALUES
('2025-10-24 09:00:00', 1, 'Ana Souza'),
('2025-10-24 10:15:00', 3, 'Carlos Mendes'),
('2025-10-25 08:45:00', 2, 'Bruna Oliveira');

INSERT INTO item_pedido (id_pedido, id_item, quantidade) VALUES
(1, 1, 2),   -- Ana: 2x Expresso
(1, 2, 1),   -- Ana: 1x Latte
(2, 3, 1),   -- Carlos: 1x Cappuccino
(2, 4, 2),   -- Carlos: 2x Mocha
(3, 5, 1);   -- Bruna: 1x Macchiato

-- ========================
-- CONSULTAS SOLICITADAS
-- ========================

-- 1️⃣ - Listagem do menu ordenado por nome
SELECT 
    id_item,
    nome_produto,
    detalhes,
    valor_unitario
FROM menu_cafe
ORDER BY nome_produto ASC;

-- ---------------------------------------------------------------

-- 2️⃣ - Exibir pedidos e itens detalhados (ordenado por data, pedido e café)
SELECT
    p.id_pedido,
    p.data_pedido,
    p.mesa_numero,
    p.cliente_nome,
    i.id_item,
    m.nome_produto,
    m.detalhes,
    i.quantidade,
    m.valor_unitario,
    (i.quantidade * m.valor_unitario) AS total_item
FROM pedido p
JOIN item_pedido i ON p.id_pedido = i.id_pedido
JOIN menu_cafe m ON i.id_item = m.id_item
ORDER BY p.data_pedido ASC, p.id_pedido ASC, m.nome_produto ASC;

-- ---------------------------------------------------------------

-- 3️⃣ - Exibir pedidos com o valor total da comanda
SELECT
    p.id_pedido,
    p.data_pedido,
    p.mesa_numero,
    p.cliente_nome,
    SUM(i.quantidade * m.valor_unitario) AS total_pedido
FROM pedido p
JOIN item_pedido i ON p.id_pedido = i.id_pedido
JOIN menu_cafe m ON i.id_item = m.id_item
GROUP BY p.id_pedido, p.data_pedido, p.mesa_numero, p.cliente_nome
ORDER BY p.data_pedido ASC;

-- ---------------------------------------------------------------

-- 4️⃣ - Exibir apenas pedidos com mais de um tipo de café
SELECT
    p.id_pedido,
    p.data_pedido,
    p.mesa_numero,
    p.cliente_nome,
    SUM(i.quantidade * m.valor_unitario) AS total_pedido,
    COUNT(i.id_item) AS tipos_de_cafe
FROM pedido p
JOIN item_pedido i ON p.id_pedido = i.id_pedido
JOIN menu_cafe m ON i.id_item = m.id_item
GROUP BY p.id_pedido, p.data_pedido, p.mesa_numero, p.cliente_nome
HAVING COUNT(i.id_item) > 1
ORDER BY p.data_pedido ASC;

-- ---------------------------------------------------------------

-- 5️⃣ - Total de faturamento por data
SELECT
    DATE(p.data_pedido) AS dia,
    SUM(i.quantidade * m.valor_unitario) AS faturamento_dia
FROM pedido p
JOIN item_pedido i ON p.id_pedido = i.id_pedido
JOIN menu_cafe m ON i.id_item = m.id_item
GROUP BY DATE(p.data_pedido)
ORDER BY DATE(p.data_pedido) ASC;

-- ===============================================================
-- FIM
-- ===============================================================
