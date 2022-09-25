-- criação do banco de dados para o cenário de E-commerce

-- drop database ecommerce;
create database ecommerce;

use ecommerce;

-- criar tabela cliente

create table clients (
		idClient int auto_increment primary key,
        Name_ varchar(45), -- If PJ: Social name -- if PF: Full name
        Address varchar(30)
        );


-- Cliente pessoa física
create table clientPF (
		idClientPF int,
        CPF char(11) not null,
        constraint unique_cpf_client unique (CPF),
        primary key (idClientPF),
        constraint fk_ClientPF_client foreign key (idClientPF) references clients(idClient)
		);
-- Cliente pessoa juridica
create table clientPJ (
		idClientPJ int,
        CNPJ char(15) not null,
        constraint unique_CNPJ_client unique (CNPJ),
        primary key (idClientPJ),
        constraint fk_ClientCNPJ_client foreign key (idClientPJ) references clients(idClient)
		);


alter table clients auto_increment = 1;

show tables;
-- drop table clients;
-- desc clients;

-- criar tabela produto
create table product (
		idProduct int auto_increment primary key,
        Pname varchar(10) not null,
        classification_kids bool default false,
        category enum ('Eletronico','Vestimenta','Brinquedos', 'Alimentos', 'Moveis') not null,
        avaliation float default 0,
        size varchar(10) -- size = dimensão do produto
        );
alter table product auto_increment = 1;
-- para ser continuado no desafio: terminar de implementar a tabela e crie as conexões necessárias
-- Alem disso, reflita essa modificação no diagrama do esquema relacional 
create table payments (
		idPayment int auto_increment primary key,
		idPClient int,
        typePayment enum('Cartão','PIX', 'Boleto') not null,
        limitAvailale float,
        PaymentDate date,
        constraint fk_payment_client foreign key (idPClient) references clients(idClient)
		);
        
alter table payments auto_increment = 1;
show tables;

-- Criar tabela Cartão
create table Card (
		idCartão int auto_increment primary key,
        idCPayment int,
        DebitOrCredit enum('Debit','Credit'),
        cardFlag varchar(20),
        paymentAmount float not null, -- valor do pagamento
        constraint fk_card_payment foreign key (idCPayment) references payments(idPayment)
        );
alter table Card auto_increment = 1;
 
-- Criar tabela PIX
-- drop table PIX;
create table PIX (
		idPIX int auto_increment primary key,
        idPIXPayment int,
        PIX_number varchar(45) not null,
        paymentAmount float  not null, -- valor do pagamento
        constraint fk_PIX_payment foreign key (idPIXPayment) references payments(idPayment)
        );
alter table PIX auto_increment = 1;

-- Criar tabela Boleto
create table BankSlip (
		idBankSlip int auto_increment primary key,
        idBPayment int,
        BankSlip_number varchar(50), -- numero do boleto
        paymentAmount float  not null, -- valor do pagamento
        constraint fk_BankSlip_payment foreign key (idBPayment) references payments(idPayment)
        );
alter table BankSlip auto_increment = 1;     
 -- ALTER TABLE BankSlip
	-- MODIFY COLUMN BankSlip_number varchar(50); 



show tables;        
-- criar tabela pedido
create table orders (
		idOrder int auto_increment primary key,
        idOrderClient int,
        orderStatus enum('Confirmado','Cancelado','Em Processamento') not null,
        orderDescription varchar(255),
        sendValue float default 10,
        paymentCash bool default false, 
        idOPayment int, -- foreign key
        constraint fk_orders_paymet foreign key (idOPayment) references payments (idPayment),
        constraint fk_orders_client foreign key (idOrderClient) references clients(idClient)
			on update cascade
        );

alter table orders auto_increment = 1;
-- desc orders;

-- criar tabela estoque
create table productStorage (
		idProdStorage int auto_increment primary key,
        storageLocation varchar(255),
        quantity int default 0
        );
 alter table productStorage auto_increment = 1;       

-- criar tabela CNPJ
create table supplier (
		idSupplier int auto_increment primary key,
        socialName varchar(255) not null,
        CNPJ char(15) not null,
        contact char(11) not null,
        constraint unique_supplier unique (CNPJ)
        );
  alter table supplier auto_increment = 1; 
 
 -- desc supplier;
 -- drop table supplier;
 
 
 -- criar tabela vendedor
 create table seller (
		idSeller int auto_increment primary key,
        SocialName varchar(255) not null,
        AbstName varchar(255),
        CNPJ char(15) not null,
        CPF char(11) ,
        location varchar(255),
        contact char(11) not null,
        constraint unique_CNPJ_seller unique (CNPJ),
        constraint unique_CPF_seller unique (CPF)
        );
   alter table seller auto_increment = 1; 
   
create table productSeller (
		idPSeller int,
        idPproduct int,
        prodQuantity int default 1,
        primary key (idPSeller,  idPproduct) ,
        constraint fk_product_seller foreign key (idPSeller) references seller(idSeller),
        constraint fk_product_product foreign key ( idPproduct) references product(idProduct)
        );

-- desc productSeller;  

create table productOrder (
		idPOproduct int,
        idPOrder int,
        poQuantity int default 1,
        poStatus enum('Disponivel','Sem estoque') default 'Disponivel',
        primary key (idPOproduct, idPOrder) ,
        constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
        constraint fk_productorder_product foreign key (idPOrder) references Orders(idOrder)
        );
        
create table storageLocation (
		idLproduct int,
        idLstorage int,
        location varchar(255) not null,
        -- poStatus enum('Disponivel','Sem estoque') default 'Disponivel',
        primary key (idLproduct, idLstorage) ,
        constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
        constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
        );

create table productSupplier (
		idPsSupplier int,
        idPsProduct int,
        quantity int not null,
        primary key (idPsSupplier,  idPsProduct) ,
        constraint fk_product_supplier_seller foreign key (idPsSupplier) references supplier(idSupplier),
        constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
        );

-- criando tabela Entrega
create table Delivery (
		idDelivery int auto_increment primary key,
        idDOrder int,
        DeliveryStatus enum('Preparando pedido','A caminho','Entregue') default 'Preparando pedido',
        trackingCode int,
        DeliveryDate date,
        DeliveryDepartureDate date, -- data de saida do pedido
        constraint fk_Delivery_Order foreign key (idDOrder) references orders(idOrder)
		);
alter table Delivery auto_increment = 1;


show tables;
use information_schema;
show tables;
desc referential_constraints;
select * from referential_constraints where constraint_schema = 'ecommerce'; -- recupera todos os contraints do banco de dados "ecommerce" que foi criado acima