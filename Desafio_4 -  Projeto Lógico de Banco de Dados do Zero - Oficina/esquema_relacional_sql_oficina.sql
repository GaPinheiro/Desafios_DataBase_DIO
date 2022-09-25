show databases;

-- drop database oficina;
create database oficina;

use oficina;

create table clients (
		idClient int auto_increment primary key,
        Name_ varchar(45), -- If PJ: Social name -- if PF: Full name
        Address varchar(30),
        Phone varchar(30)
        );
alter table clients auto_increment = 1;

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

create table payments (
		idPayment int auto_increment primary key,
		idPClient int,
        typePayment enum('Cartão','PIX', 'Dinheiro') not null,
        PaymentDate date,
        constraint fk_payment_client foreign key (idPClient) references clients(idClient)
		);
        
create table Card (
		idCartão int auto_increment primary key,
        idCPayment int,
        DebitOrCredit enum('Debit','Credit'),
        cardFlag varchar(20),
        constraint fk_card_payment foreign key (idCPayment) references payments(idPayment)
        );
alter table Card auto_increment = 1;
 
-- Criar tabela PIX
-- drop table PIX;
create table PIX (
		idPIX int auto_increment primary key,
        idPIXPayment int,
        PIX_number varchar(45) not null,
        constraint fk_PIX_payment foreign key (idPIXPayment) references payments(idPayment)
        );
alter table PIX auto_increment = 1;

-- Criar tabela Boleto
create table Cash (
		idCash int auto_increment primary key,
        idCashPayment int,
        constraint fk_Cash_payment foreign key (idCashPayment ) references payments(idPayment)
        );
alter table Cash auto_increment = 1;   

create table ServiceOrder (
		idOrder int auto_increment primary key,
        idOrderClient int,
        orderStatus enum('Confirmado','Cancelado','Em Processamento') not null,
        orderDescription varchar(255),
        Service_Order_Value float default 10,
        idOPayment int, -- foreign key
        constraint fk_orders_paymet foreign key (idOPayment) references payments (idPayment),
        constraint fk_orders_client foreign key (idOrderClient) references clients(idClient)
			on update cascade
		);
	


alter table ServiceOrder auto_increment = 1;


create table parts(
		idPart int auto_increment primary key,
        Pvalue float,
        Pdescription varchar (255),
        PartCode int,
        Quantity int, -- Quantidade em estoque
        constraint unique_PartCode unique (PartCode)
        );
 alter table parts auto_increment = 1;
 
 
create table RequestedParts(
		idRequestedParts int,
        idRP_OrtOrder int,
        requested_quantity int,
        DateRequest date,
        constraint fk_RequestedParts_Parts foreign key (idRequestedParts ) references parts(idPart ),
        constraint fk_RequestedParts_Order foreign key (idRP_OrtOrder ) references ServiceOrder(idOrder )
        );

Create table services (
		idService int auto_increment primary key,
        typeService enum('Repair','Revision') not null,
        ServiceValue float,
        ServiceDate date
        );
alter table services auto_increment = 1;

create table providedServices (
		idPServices int,
        idPSOrder int,
        constraint fk_providedServices_Services foreign key (idPServices ) references services(idService),
        constraint fk_providedServices_Order foreign key (idPSOrder) references ServiceOrder(idOrder )
		);

create table repairService (
		idRepair int,
        Repair_description varchar(255),
        primary key (idRepair),
        constraint fk_Repair_Services foreign key (idRepair ) references services(idService)
		);

create table revisionService (
		idRevision int,
        Revision_description varchar(255),
        primary key (idRevision),
        constraint fk_revision_Services foreign key (idRevision ) references services(idService)
		);

-- tabela da equipe de mecanicos
create table mechanicEmployees (
		idMEmployees int auto_increment primary key,
        idMEorder int,
		Avaliation varchar(255),
        numberOfEmployees int,
        constraint fk_mechanicEmployees_Order foreign key (idMEorder ) references ServiceOrder(idOrder )
        );
alter table mechanicEmployees auto_increment = 1;


-- Dados de cada mecanico
create table Employee (
		idEmployee int auto_increment primary key,
        EmployeeCode int,
        Ename varchar(50),
        Speciality varchar(50)
        );
alter table Employee auto_increment = 1

