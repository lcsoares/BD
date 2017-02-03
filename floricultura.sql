/* retorna todos os clientes com pedidos */

SELECT "cliente".nome,"pedido".cliente_id
FROM "cliente" 
INNER JOIN "pedido"
ON "cliente".cliente_id = "pedido".cliente_id
ORDER BY "cliente".nome;

