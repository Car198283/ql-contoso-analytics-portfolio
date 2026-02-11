-- ======================================================
-- Arquivo: 01_exploracao_banco.sql
-- Objetivo: Exploração inicial do banco de dados
-- ======================================================

-- Identifica o banco de dados atual
SELECT DB_NAME() AS Banco_Atual;

-- Lista todas as tabelas do banco
SELECT 
    TABLE_SCHEMA,
    TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_SCHEMA, TABLE_NAME;

02️⃣ Análise inicial da FactSales
-- Visualiza uma amostra controlada da tabela de fatos
SELECT TOP (100)
*
FROM FactSales;

-- Retorna as 100 maiores vendas com base no valor total vendido
SELECT TOP (100)
*
FROM FactSales
ORDER BY SalesAmount DESC;

03️⃣ DimProduct – Visão logística
c-- Produtos com peso acima de 100kg (Categoria A para transporte)SELECT
ProductName AS Nome_Produto,
Weight AS Peso_Produto
FROM DimProduct
WHERE Weight > 100
ORDER BY Weight DESC

04️⃣ DimStore – Análise de lojas
-- Quantidade total de lojas cadastradas
SELECT COUNT(*) AS Total_Lojas
FROM DimStore;

-- Informações principais das lojas
SELECT
StoreName AS Nome_Loja,
OpenDate AS Data_Abertura,
EmployeeCount AS Total_Funcionarios
FROM DimStore;

-- Lojas ativas
SELECT
StoreName,
OpenDate,
EmployeeCount
FROM DimStore
WHERE StoreType = 'STORE'
AND Status = 'ON';

05️⃣ Controle de qualidade – Produtos com defeito
-- Identifica produtos Home Theater da marca Litware
-- disponibilizados para venda em 15/03/2009
SELECT
ProductKey,
ProductName,
BrandName,
AvailableForSaleDate
FROM DimProduct
WHERE BrandName = 'Litware'
AND ProductName LIKE '%Home Theater%'
AND AvailableForSaleDate = Theater%'
AND AvailableForSaleDate = '2009-03-15';'2009-03-15';

06️⃣ Identificação de lojas inativas
-- Lojas inativas com base no status
SELECT *
FROM DimStore
WHERE Status = 'OFF';


-- Abordagem alternativa quando a coluna Status não existe
SELECT *
FROM DimStore
WHERE CloseDate IS NOT NULL;

07️⃣ Categorização usando CASE (nível intermediário)  
  -- Classificação das lojas por quantidade de funcionários
SELECT
StoreName,
EmployeeCount,
CASE
WHEN EmployeeCount BETWEEN 1 AND 20 THEN 'Categoria 1 - 1 Máquina'
WHEN EmployeeCount BETWEEN 21 AND 50 THEN 'Categoria 2 - 2 Máquinas'
ELSE 'Categoria 3 - 3 Máquinas'
END AS Categoria_Cafe
FROM DimStore;
  
08️⃣ Produtos LCD
  -- Lista produtos LCD com informações relevantes para campanha promocional
SELECT
ProductKey AS ID_Produto,
ProductName AS Nome_Produto,
UnitPrice AS Preco_Unitario
FROM DimProduct
WHERE ProductDescription LIKE '%LCD%';

09️⃣ Filtros múltiplos (cores e marcas)
  
-- Produtos de cores e marcas específicas
SELECT *
FROM DimProduct
WHERE ColorName IN ('Green', 'Orange', 'Black', 'Silver', 'Pink')
AND BrandName IN ('Contoso', 'Litware', 'Fabrikam');

🔟 Filtro por faixa de preço
  -- Produtos da marca Contoso, cor Silver, com preço entre 10 e 30
SELECT *
FROM DimProduct
WHERE BrandName = 'Contoso'
AND ColorName = 'Silver'
AND UnitPrice BETWEEN 10 AND 30
ORDER BY UnitPrice DESC;
