{ mkDerivation, base, bytestring, containers, contravariant
, cryptonite, extra, memory, MonadRandom, mtl, network, random
, random-shuffle, stdenv, stm, time, transformers
}:
mkDerivation {
  pname = "kademlia";
  version = "1.1.0.1";
  src = ./.;
  libraryHaskellDepends = [
    base bytestring containers contravariant cryptonite extra memory
    MonadRandom mtl network random random-shuffle stm time transformers
  ];
  homepage = "https://github.com/bkase/kademlia";
  description = "An implementation of the Kademlia DHT Protocol";
  license = stdenv.lib.licenses.bsd3;
}
