// ATENCION: no es preciso, no sirve para sincronizar percusiones

// crea nuestro receptor de OSC
OscRecv recv;
// usa el puerto 6449
6449 => recv.port;
// inicia la escucha
recv.listen();
// crea una dirección en el receptor y asigna a una variable
recv.event( "/metronomo, i" ) @=> OscEvent oe;

// ciclo infinito
while ( true )
{
	// mide el tiempo
	now => time wait;
	// espera la llegada de un evento
    oe => now;

	// agarra el siguiente mensaje de la fila
    while ( oe.nextMsg() != 0 )
    {
		oe.getInt() => int i;
        // print
		now => time lap;
        <<< "Beat:",i, "BPM:",((60 * 1000)/((lap-wait)/ms)) >>>;
    }
}
