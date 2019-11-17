// flex-bison-cpp-playground -- 03_appa_parser/appa.h
// author: johannst

#include <string>
#include <memory>
#include <algorithm>
#include <map>
#include <iostream>

///
/// Visitor: To walk the parse structure
///

// fwd decl for Visitor
struct NumElement;
struct DictElement;

struct Visitor {
    Visitor() =default;
    Visitor(const Visitor&) =delete;
    Visitor& operator=(const Visitor&) =delete;
    virtual ~Visitor() {}

    virtual void visit(const NumElement& e) =0;
    virtual void visit(const DictElement& e) =0;
};


///
/// APPA elements
///

struct Element {
    Element() =default;
    Element(const Element&) =delete;
    Element& operator=(const Element&) =delete;
    virtual ~Element() {}
    virtual void accept(Visitor& v) const =0;
};


struct NumElement final : public Element {
    NumElement(int num):
        mNum(num) {}
    virtual void accept(Visitor& v) const override { v.visit(*this); }
    int mNum;
};

struct DictElement final : public Element {
    DictElement(const std::map<const std::string*, const Element*>* dict) : mDict(dict) {}
    ~DictElement() {
        std::for_each(mDict->begin(), mDict->end(), [](const auto& kv) {
                delete kv.first;
                delete kv.second;
                });
    }
    virtual void accept(Visitor& v) const override { v.visit(*this); }
    std::unique_ptr<const std::map<const std::string*, const Element*>> mDict;
};


///
/// AppaWalker: Recursively dump the parsed structure
///

struct AppaWalker : public Visitor {
    AppaWalker(): mDepth(0) {}

    virtual void visit(const NumElement& e) override {
        out() << "  num=" << e.mNum << std::endl;
    }
    virtual void visit(const DictElement& e) override {
        ++mDepth;
        for (auto& kv : *e.mDict) {
            out() << "- key=" << *kv.first << std::endl;
            kv.second->accept(*this);
        }
        --mDepth;
    }

    inline std::ostream& out() const {
        std::cout << std::string(2*mDepth, ' ');
        return std::cout;
    }
    private:
    int mDepth;
};

