# rubocop:disable Metrics/BlockLength

require 'rails_helper'

RSpec.describe Taxon, type: :model do
  describe 'factory' do
    subject { taxon }

    let(:taxon) { create(:taxon) }

    it { is_expected.to be_a Taxon }

    context 'with children' do
      it 'has children' do
        taxon = create(:taxon, :with_descendants)
        expect(taxon.children).to have_attributes(size: 3)
        expect(taxon.descendants).to have_attributes(size: 3)
      end

      it 'has descendants' do
        taxon = create(:taxon, :with_descendants, generations: 3)
        expect(taxon.children).to have_attributes(size: 3)
        expect(taxon.descendants).to have_attributes(size: (3 + 9 + 27))

        leaf = Taxon.last

        expect(leaf.ancestors).to have_attributes(size: 3)
        expect(leaf.path)
      end
    end
  end

  describe 'depth' do
    before { create(:taxon, :with_descendants, generations: 2, amount: 2) }

    context 'when reading' do
      it 'is present as attribute' do
        expect(described_class.pluck(:depth).tally).to eq(0 => 1, 1 => 2, 2 => 4)
      end
    end

    context 'when querying' do
      it 'respects conditions' do
        expect(described_class.before_depth(1)).to have_attributes size: 1
        expect(described_class.to_depth(1)).to have_attributes size:  (1 + 2)
        expect(described_class.at_depth(1)).to have_attributes size:  2
        expect(described_class.from_depth(1)).to have_attributes size: (2 + 4)
        expect(described_class.after_depth(1)).to have_attributes size: 4
      end
    end
  end

  describe 'tree scopes' do
    before { create(:taxon, :with_descendants, amount: 3, generations: 2) }

    # top
    # |- child 1
    # |  |- grandch 1.1
    # |  |- grandch 1.2
    # |  |- grandch 1.3
    # |- child 2
    # |  |- grandch 2.1
    # |  |- grandch 2.2
    # |  |- grandch 2.3
    # |- child 3
    #    |- grandch 3.1
    #    |- grandch 3.2
    #    |- grandch 3.3

    shared_examples 'a relation' do |size:|
      it { expect(subject.to_a).to have_attributes size: size }
      it { is_expected.to respond_to :where }
    end

    describe 'siblings_of (skips self)' do
      subject { described_class.siblings_of(described_class.last) }

      it_behaves_like 'a relation', size: 2
    end

    describe 'roots' do
      subject { described_class.roots }

      it_behaves_like 'a relation', size: 1
    end

    describe 'ancestors_of' do
      subject { described_class.ancestors_of(described_class.last) }

      it_behaves_like 'a relation', size: 2
    end

    describe 'children_of' do
      subject { described_class.children_of(described_class.first) }

      it_behaves_like 'a relation', size: 3
    end

    describe 'descendants_of (includes all generations)' do
      subject { described_class.descendants_of(described_class.first) }

      it_behaves_like 'a relation', size: 12
    end

    describe 'indirects_of (non-children descendants)' do
      subject { described_class.indirects_of(described_class.first) }

      it_behaves_like 'a relation', size: 9
    end

    describe 'subtree_of (descendants and self)' do
      subject { described_class.subtree_of(described_class.first.children.first) }

      it_behaves_like 'a relation', size: 4
    end
  end

  describe 'ancestors' do
    subject { taxon.ancestors }

    let(:root) { create(:taxon) }
    let(:child) { create(:taxon, parent: root) }
    let(:taxon) { create(:taxon, parent: child) }

    it { is_expected.to contain_exactly(root, child) }
  end

  describe 'reparenting' do
    before { create(:taxon, :with_descendants, amount: 2, generations: 3) }

    let(:level_1_taxon) { described_class.where(depth: 1).first }
    let(:target_leaf) { described_class.where(depth: 3).last }

    it 'adapts all descendants' do
      p level_1_taxon.ancestry, target_leaf.ancestry, level_1_taxon.descendants.last.ancestry
      level_1_taxon.parent = target_leaf
      level_1_taxon.save

      expect(level_1_taxon.descendants.last.ancestry).to eq(target_leaf.ancestry + [level_1_taxon.id, be > 0])
    end
  end
end

# rubocop:enable Metrics/BlockLength
