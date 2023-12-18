class Pokemon{
    constructor(HP, ataque, defensa){
        this.HP = HP;
        this.ataque = ataque;
        this.defensa = defensa;
        this.movimientos = "";
        this.nivel = 1;
        this.tipo = "";
    }

    fight(){
        if (this.movimientos === ""){
            throw new Error("No se a seleccionado ningún movimiento")
        }
    }

    canFly(){
        if (this.tipo === ""){
            throw new Error("No se especificó un tipo");
        }
        
        return this.tipo.includes("flying");
    }   
}

class Charizard extends Pokemon{
    constructor(hp, ataque, defensa, movimiento) {
        super(hp, ataque, defensa);
        this.movimiento = movimiento;
        this.tipo = "disparar/flying";
    }
    fight(){
        super.fight();
        console.log("Usó " + this.movimiento);
    }
}