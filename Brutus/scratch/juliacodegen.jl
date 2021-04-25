module JuliaCodegen

using Brutus
using MLIR

function brutus_id(N)
    return N
end

mi = Brutus.get_methodinstance(Tuple{typeof(brutus_id), Int})
ir_code, rt = Brutus.code_ircode(mi)
display(ir_code)
mod = Brutus.Compiler.emit_jlir(ir_code, rt, "brutus_id")
MLIR.IR.dump(mod)

function switch(N)
    N > 10 ? 5 : 10
end

mi = Brutus.get_methodinstance(Tuple{typeof(switch), Int})
ir_code, rt = Brutus.code_ircode(mi)
display(ir_code)
mod = Brutus.Compiler.emit_jlir(ir_code, rt, "switch")
MLIR.IR.dump(mod)

#function gauss(N)
#    k = 0
#    for i in 1 : N
#        k += i
#    end
#    return k
#end
#
#mi = Brutus.get_methodinstance(Tuple{typeof(gauss), Int})
#ir_code, rt = Brutus.code_ircode(mi)
#display(ir_code)
#mod = Brutus.Compiler.emit_jlir(ir_code, rt, "gauss")
#MLIR.IR.dump(mod)

end # module
