%rename(SoGroup_i) SoGroup::SoGroup(int nchildren);

%feature("shadow") SoGroup::SoGroup %{
def __init__(self,*args):
   if len(args) == 1:
      self.this = apply(_pivy.new_SoGroup_i,args)
      self.thisown = 1
      return
   self.this = apply(_pivy.new_SoGroup,args)
   self.thisown = 1
%}

%rename(removeChild_nod) SoGroup::removeChild(SoNode * const child);

%feature("shadow") SoGroup::removeChild(const int childindex) %{
def removeChild(*args):
   if isinstance(args[1], SoNode):
      return apply(_pivy.SoGroup_removeChild_nod,args)
   return apply(_pivy.SoGroup_removeChild,args)
%}

%rename(replaceChild_nod_nod) SoGroup::replaceChild(SoNode * const oldchild, SoNode * const newchild);

%feature("shadow") SoGroup::replaceChild(const int index, SoNode * const newchild) %{
def replaceChild(*args):
   if isinstance(args[1], SoNode):
      return apply(_pivy.SoGroup_replaceChild_nod_nod,args)
   return apply(_pivy.SoGroup_replaceChild,args)
%}