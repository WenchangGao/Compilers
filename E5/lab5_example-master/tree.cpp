#include "tree.h"
#include <iomanip>
using namespace std;
void TreeNode::addChild(TreeNode *child)
{
    if(this->child == nullptr) this->child = child;
    else this->child->addSibling(child);
}
void TreeNode::addSibling(TreeNode *sib)
{
    if(this->sibling == nullptr) this->sibling = sib;
    else this->sibling->addSibling(sib);
}

void TreeNode::genNodeId(int& num)
{
   this->nodeID = num;
   num++;
   if(this->child != nullptr) 
   {
       this->child->genNodeId(num);
   }
   if(this->sibling != nullptr)
   {
       this->sibling->genNodeId(num);
   }
}

void TreeNode::printNodeInfo()
{
    string nodetype;
    switch(this->nodeType)
    {
    case NODE_CONST: nodetype = "const"; break;
    case NODE_BOOL: nodetype = "bool"; break;
    case NODE_VAR: nodetype = "variable"; break;
    case NODE_EXPR: nodetype = "expression"; break;
    case NODE_TYPE: nodetype = "type"; break;
    case NODE_STMT: nodetype = "statement"; break;
    case NODE_PROG: nodetype = "program"; break;
    case NODE_OP: nodetype = "operator"; break;
    }
    cout<<setw(4)<<this->nodeID<<setw(15)<<nodetype;
}

void TreeNode::printNodeConnection()
{
    cout<<setw(10)<<"child:";
    TreeNode* ptr = this->child;
    while(ptr != nullptr)
    {
        cout<<setw(4)<<ptr->nodeID;
        ptr = ptr->sibling;
    }
}

void TreeNode::printAST()
{
    printNodeInfo();
    printNodeConnection();
    cout<<endl;
    if(this->sibling != nullptr) this->sibling->printAST();
    if(this->child != nullptr) this->child->printAST();
}

TreeNode::TreeNode(NodeType type)
{
    this->nodeType = type;
}