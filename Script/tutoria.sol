pragma solidity ^0.4.7;
contract Tutoria {
    
    mapping (address => TutoriaData)  tutoriasdata;
    
    
    struct TutoriaData {
        string materia;
        address idProfesor;
        address alumno;
        bool num_confirmar;
        bool num_cancelar;
        uint fecha;
        bytes32 hash;
    }
    
    function solicitar(string mater, address id_Profesor) public{
        require(msg.sender != id_Profesor);
        TutoriaData t = tutoriasdata[msg.sender];
        t.materia = mater;
        t.idProfesor = id_Profesor;
        t.alumno = msg.sender;
        t.num_cancelar = false;
        t.num_confirmar = false;
        t.fecha = block.timestamp;
        t.hash = keccak256(t.materia,t.idProfesor,t.alumno,t.num_cancelar,t.num_confirmar,t.fecha);
    }
    
    function getFecha(address key) public view returns (uint) {
        return tutoriasdata[key].fecha;
    }

    
    function getMateria(address key) public view returns (string) {
        return tutoriasdata[key].materia;
    }
    
    function getIdProfesor(address key) public view returns (address) {
        return tutoriasdata[key].idProfesor;
    }
    
    function getAlumno(address key) public view returns (address) {
        return tutoriasdata[key].alumno;
    }
    
    function confirmar(address key) public returns (bool) {
        require(tutoriasdata[key].idProfesor == msg.sender);
        require(tutoriasdata[key].num_confirmar == false);
        require(tutoriasdata[key].num_cancelar == false);
        return tutoriasdata[key].num_confirmar = true;
    }
    
    function cancelar(address key) public returns (bool) {
        require(tutoriasdata[key].alumno == msg.sender);
        require(tutoriasdata[key].num_confirmar == false);
        require(tutoriasdata[key].num_cancelar == false);
        return tutoriasdata[key].num_cancelar= true;
    }
    
    function estaConfirmado(address key) public view returns (bool){
        return tutoriasdata[key].num_confirmar;
    }
    
    function estaCancelado(address key) public view returns (bool){
        return tutoriasdata[key].num_cancelar;
    }
    
    function getHash(address key) public view returns (bytes32) {
        return tutoriasdata[key].hash;
    }
}