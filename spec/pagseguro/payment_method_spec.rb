# -*- encoding: utf-8 -*-
require "spec_helper"

shared_examples_for "type mapping" do |id, type|
  it "returns #{type.inspect} as type when id is #{id}" do
    expect(PagSeguro::PaymentMethod.new(type_id: id).type).to eql(type)
  end
end

describe PagSeguro::PaymentMethod do
  context "type mapping" do
    it_behaves_like "type mapping", 1, :credit_card
    it_behaves_like "type mapping", 2, :bank_slip
    it_behaves_like "type mapping", 3, :tef
    it_behaves_like "type mapping", 4, :pagseguro
    it_behaves_like "type mapping", 5, :paggo

    it "raises for invalid id" do
      expect {
        PagSeguro::PaymentMethod.new(type_id: "invalid").type
      }.to raise_exception("PagSeguro::PaymentMethod#type_id isn't mapped")
    end
  end

  context "shortcuts" do
    it { expect(PagSeguro::PaymentMethod.new(type_id: 1)).to be_credit_card }
    it { expect(PagSeguro::PaymentMethod.new(type_id: 2)).to be_bank_slip }
    it { expect(PagSeguro::PaymentMethod.new(type_id: 3)).to be_tef }
    it { expect(PagSeguro::PaymentMethod.new(type_id: 4)).to be_pagseguro }
    it { expect(PagSeguro::PaymentMethod.new(type_id: 5)).to be_paggo }

    it { expect(PagSeguro::PaymentMethod.new(type_id: 5)).not_to be_credit_card }
  end

  context "description" do
    subject(:payment_method) { PagSeguro::PaymentMethod.new(code: 102) }
    it { expect(payment_method.description).to eql("Cartão de crédito MasterCard") }
  end
end
