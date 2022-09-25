use ecommerce; 

show tables;
insert into Clients( Name_, Address)
	values('Maria Silva',  'rua A 88, Centro - Morros'),
		  ('Mateus Martins',  'rua da luz 90, Centro - Morros'),
		  ('Bianca Pedro','rua 7 89,  Centro - Morros'),
		  ('Tiana Viana','avenida B 90, Centro - Morros'),
		  ('Bruna Ruas', 'rua sol 900, Centro - Morros'),
		  ('MariaRoupas', 'rua 8 111,  Centro - Morros'),
		  ('MateusDistribuidor',  'rua 14 123,  Centro - Morros');
select * from Clients;

insert into ClientPF(idClientPF,  CPF)
	values  ('1', '6789010989'),
			('2', '789062545'),
            ('3', '324567849'),
            ('4', '789056243'),
            ('5', '567890190');
            
insert into ClientPJ(idClientPJ,  CNPJ)
	values  ('6', '678901098912345'),
			('7', '78906254512345');
            
insert into product(Pname, classification_kids, category, avaliation, size) 
	values ('Saia Jeans', false, 'Vestimenta', '4', null),
		   ('Hulk', true, 'Brinquedos', '5', null),
		   ('Sofá', false, 'Móveis', '3', null),
		   ('Body Mix', false, 'Vestimenta', '2', null),
		   ('Microfone', false, 'Eletrônico', '4', null);
select * from product;


insert into orders(idOrderClient, orderStatus, orderDescription, sendValue, paymentCash)
		values (1, default, 'compra via aplicativo', null, 1),
			   (2, default, 'compra via aplicativo', 50, 0),
			   (3, 'Confirmado', null, null, 1),
			   (4, default, 'compra via web site', 150, 0);
select * from orders;
insert into orders(idOrderClient, orderStatus, orderDescription, sendValue, paymentCash)
		values (2, default, 'compra via aplicativo', null, 1);

insert into productOrder(idPOproduct, idPOrder, poQuantity, poStatus)
		values (1, 1, 2, null),
			   (2, 1, 1, null),
			   (3, 2, 1, null);
       
insert into productStorage (storageLocation, quantity)
		values ('Rio de Janeiro', '1000'),
			   ('Rio de Janeiro', '700'),
			   ('São Paulo', '350'),
			   ('São Paulo', '200'),
			   ('São Paulo', '150'),
			   ('Brasilia',350);

select * from productStorage;

insert into StorageLocation (idLproduct, idLstorage, location)
		values ('1', '2', 'RJ'),
			   ('2', '6', 'GO');
desc StorageLocation;
 
insert into supplier (SocialName, CNPJ, Contact)
		values ('Bumba branco', '908765439087617', '32167890'),
			   ('Nancy Ofertas', '283906541908715', '78906514'),
			   ('Império das Coisas', '728127639017235', '90876515');
               
insert into productSupplier (idPsProduct, idPsSupplier, quantity)
		values  ('1','1','100'),
				('2','3','100'),
                ('4','3','100'),
                ('1','2','100'),
				('2','2','400'),
                ('3','3','300');

select * from productSupplier;
       
insert into seller(SocialName, AbstName, CNPJ, CPF, location, contact)
		values ('Casa Vende Tudo', 'não possui', '829756528900241', null, 'Rio de Janeiro', '78162517'),
			   ('Tech Depósito', 'não possui', '0', '890716890', 'Rio de Janeiro', '89076718'),
			   ('MWG', 'não possui', '892765479987152', '0', 'São Paulo', '67518999');
              
select * from seller;

insert into productSeller(idPSeller, idPproduct, prodQuantity)
		values ('1', '1', '80'),
			   ('2', '2', '10');

-- DELETE FROM payments WHERE idPayment =6 or idPayment =7 or idPayment =8 or idPayment =9 or idPayment =10;

insert into payments (idPClient, typePayment, paymentDate)
		values  ('1','Cartão','2022-01-18'),
				('1','PIX','2022-05-21'),
                ('4','Cartão','2021-02-15'),
                ('4','Boleto','2022-04-03'),
                ('3','Cartão','2022-09-01');
                
select * from payments;

insert into Card (idCpayment, DebitOrCredit, cardFlag, paymentAmount)
		values  ('1','Credit','Visa','900'),
				('3','Debit','MasterCard','50'),
                ('4','Credit','Visa','500');

insert into PIX (idPIXPayment, PIX_number, paymentAmount)
		values  ('2','14993214567','300');

insert into BankSlip (idBPayment, BankSlip_number, paymentAmount)
		values  ('4','123456789012345678901234567890123456789012345678','150');

insert into Delivery (idDorder, DeliveryStatus, trackingCode, DeliveryDate)
		values  ('1','A caminho','12345','2022-09-26'),
				('2','Preparando pedido','67891','2022-10-06');
select * from Delivery;

select * from productseller;      
select * from clients c, orders o where c.idCLient = idOrderClient;
select Name_ as Client, idOrder as Request, OrderStatus as Status from clients c, orders o where c.idCLient = idOrderClient;


       
select * from clients c, orders where c.idClient = idOrderClient;
select * from clients c, orders where c.idClient = idOrderClient;
select count(*) from clients;

select count(*) from clients c, orders o 
		where c.idCLient = idOrderClient
		group by idOrder;
    
-- Quantos Pedidos foram realizados por cada cliente?
select c.idClient, Name_, count(*) as Number_Of_Orders from clients c
		inner join orders o ON c.idCLient = o.idOrderClient
		inner join productOrder p on p.idPOrder = o.idOrder
    group by idClient;
    
select c.idClient,Name_, count(*) as Number_Of_Orders from clients c
		inner join orders o ON c.idCLient = o.idOrderClient
    group by idClient;
 
 -- Recuperação de pedido com produto assiciado
select* from clients c
		inner join orders o ON c.idCLient = o.idOrderClient
        inner join productOrder p on p.idPOrder = o.idOrder
    group by idClient;
    
insert into supplier (SocialName, CNPJ, Contact)
		values ('SellMaquinas', '912345677899987', '32161515');
        
insert into seller(SocialName, AbstName, CNPJ, CPF, location, contact)
		values ('SellMaquinas', 'não possui', '912345677899987', null, 'Sao Paulo', '32161515');
    
-- Algum vendedor também é fornecedor?
select se.SocialName, se.CNPJ from seller se, supplier su	
		where se.CNPJ=su.CNPJ
        group by se.CNPJ;

select * from productSeller;

-- Relação de produtos e vendedores
select Pname,  category, prodQuantity as QuantidadeVendida from product p
		join productSeller pse on p.idProduct = pse.idPproduct
        ;


-- Relação de produtos e fornecedores        
select p.Pname, su.socialName, p.category from product as p , supplier as su,  productSupplier as psu
		where (p.idProduct = psu.idPsProduct)
        order by Pname, su.socialName;
select * from product;



-- Relação de produtos, fornecedores e estoques        
select p.Pname as Nome_do_Produto, su.socialName as Fornecedor, s.storageLocation as local_do_estoque, s.quantity as Quantidade from product as p  
		join productSupplier as psu on psu.idPsProduct = p.idProduct 
        join supplier as su on su.idSupplier = psu.idPsSupplier
        join (storageLocation as l , productStorage as s) on l.idLstorage = s.idProdStorage
        order by Pname, su.socialName;
        
show tables;
select * from productSupplier;


-- Relação de fornecedores tem cada produto       
select p.Pname, p.category, count(*) as Numero_de_Fornecedores   from product as p , supplier as su,  productSupplier as psu
		where (p.idProduct = psu.idPsProduct)
        group by Pname
        having count(*) > 2;
select * from product;
        
-- Quantos fornecedores tem em São Paulo?
select SocialName, location from seller
		where location = 'Rio de Janeiro';
