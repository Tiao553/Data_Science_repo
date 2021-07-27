use drogaria_avenida;

-- ------------------------------------------------
	-- Inserindo dados Teste
-- ------------------------------------------------

	-- Tipos produtos
INSERT INTO tipo_produto(tipo_produto) VALUES ('Remédios');
INSERT INTO tipo_produto(tipo_produto) VALUES ('Cosméticos');
INSERT INTO tipo_produto(tipo_produto) VALUES ('Aparelhos');
INSERT INTO tipo_produto(tipo_produto) VALUES ('Diversos');
	
	-- Fabricantes
INSERT INTO fabricante (fabricante) VALUES ('Roche');
INSERT INTO fabricante (fabricante) VALUES ('Vitalis');
INSERT INTO fabricante (fabricante) VALUES ('Pamolive');
INSERT INTO fabricante (fabricante) VALUES ('Huggies');

	-- Medicos
INSERT INTO medicos (nome, crm) VALUES ('Alfredo Muniz', '123123SP');
INSERT INTO medicos (nome, crm) VALUES ('Fernanda Ailva', '3423423MG');
INSERT INTO medicos (nome, crm) VALUES ('Julieta Santana', '56546SC');

	-- Clientes
INSERT INTO clientes (nome, endereco, telefone, cep, localidade, cpf) 
	VALUES ('Felicity Jones','Rua da Paz, 34', '(11) 2345-8899', '34.567-098', 'Santos', '234.789.433-98');
INSERT INTO clientes (nome, endereco, telefone, cep, localidade, cpf) 
	VALUES ('Angelina Jolie','Rua do Ipiranga, 456', '(21) 7544-3234', '56.654-567', 'Rio de Janeiro', '345.678.234-12');
INSERT INTO clientes (nome, endereco, telefone, cep, localidade, cpf) 
	VALUES ('Ricardo Chavez','Rua Certa, 678', '(21) 2678-3984', '12.4569-223', 'Planaltina', '786.123.445-31');
    
	-- Produtos
INSERT INTO produtos (produto, designacao, composicao, preco_venda, id_tipo_produto, id_fabricante) 
	VALUES ('Dipirona', 'Dores em geral', 'Metilpropileno', '12.44', 1, 1);
INSERT INTO produtos (produto, designacao, composicao, preco_venda, id_tipo_produto, id_fabricante) 
	VALUES ('Sabonete', 'Limpeza', 'Sei lah', '3.56', 2, 2);
INSERT INTO produtos (produto, designacao, composicao, preco_venda, id_tipo_produto, id_fabricante) 
	VALUES ('Protetor Solar', 'Protetor Solar', 'Soro de abacate', '98.12', 2, 1);

	-- Compras
 INSERT INTO compras (id_cliente, data) VALUES (1, '2019-03-10');
 INSERT INTO compras (id_cliente, data) VALUES (2, '2019-04-15');
 INSERT INTO compras (id_cliente, data) VALUES (1, '2019-05-18');
 
	-- Produtos Compra
INSERT INTO produtos_compra (id_compra, id_produto, quantidade) VALUES (1, 1, 2);
INSERT INTO produtos_compra (id_compra, id_produto, quantidade) VALUES (1, 2, 3);
INSERT INTO produtos_compra (id_compra, id_produto, quantidade) VALUES (2, 3, 1);

	-- Receitas Medicas
INSERT INTO receitas_medica (id_produto_compra, id_medico, receita) VALUES (1, 1, 'receita1.pdf');
INSERT INTO receitas_medica (id_produto_compra, id_medico, receita) VALUES (3, 2, 'receita2.pdf');

-- ------------------------------------------------
	-- Visualizando dados Teste
-- ------------------------------------------------

-- compras

-- Passo 1 - Trazer as compras
SELECT * FROM compras;

-- Passo 2 - Colocar o nome dos clientes nas compras
SELECT com.id AS 'ID Compra', cli.nome AS 'Cliente', com.data AS 'Data Compra' 
	FROM compras AS com, clientes AS cli WHERE com.id_cliente = cli.id;
    
-- Passo 3 - Produtos Compra
SELECT * FROM produtos_compra;

-- Passo 4 - 
SELECT  com.id AS 'Compra', 
    cli.nome AS 'Cliente',
    SUM(prod.preco_venda * proc.quantidade) AS 'Total',
    com.data AS 'Data da Compra'
    FROM produtos_compra AS proc, produtos AS prod, compras AS com, clientes AS cli
    WHERE com.id = proc.id_compra AND prod.id = proc.id_produto AND cli.id = com.id_cliente
    GROUP BY com.id;

-- ------------------------------------------------
	-- Excluindo dados Teste
-- ------------------------------------------------

-- Excluindo dados

SELECT * FROM produtos_compra;

SELECT * FROM receitas_medica;

DELETE FROM receitas_medica WHERE id_produto_compra = 3;

DELETE FROM produtos_compra WHERE id = 3;