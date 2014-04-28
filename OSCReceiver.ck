
SawOsc saw => dac;
SndBuf sn => dac;

.5 => saw.gain;

// crea nuestro receptor de OSC
OscRecv recv;

// usa el puerto
8000 => recv.port;

me.dir() + "/audio/snare_01.wav" => sn.read;

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

	0 => sn.pos;
	
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
