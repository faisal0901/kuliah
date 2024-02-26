program Pertemuan15;
uses crt;

type
  TMahasiswa = object
  private
    FNama: string;
    FNPM: string;
    FTagihanKas: Int64;
    FSudahLunas: Boolean;
  public
    constructor Create(Nama, NPM: string; TagihanKas: Int64; SudahLunas: Boolean);
    function NamaMahasiswa: string;
    function GetNPM: string;
    function GetTagihanKas: Int64;
    function SudahLunas: Boolean;
  end;

constructor TMahasiswa.Create(Nama, NPM: string; TagihanKas: Int64; SudahLunas: Boolean);
begin
  FNama := Nama;
  FNPM := NPM;
  FTagihanKas := TagihanKas;
  FSudahLunas := SudahLunas;
end;

function TMahasiswa.NamaMahasiswa: string;
begin
  NamaMahasiswa := FNama;
end;

function TMahasiswa.GetNPM: string;
begin
  GetNPM := FNPM;
end;

function TMahasiswa.GetTagihanKas: Int64;
begin
  GetTagihanKas := FTagihanKas;
end;

function TMahasiswa.SudahLunas: Boolean;
begin
  SudahLunas := FSudahLunas;
end;

var
  exitProgram: Boolean;
  pilihan: Integer;
  ArrayMahasiswa: array of TMahasiswa;
  i: Integer;
  inputNamaMahasiswa:String;
  inputNpm:string;
  inputJumlahBayaran:Int64;
  TotalUangKas:Int64=0;



procedure TampilkanInfoMahasiswa(const ArrayMahasiswa: array of TMahasiswa);
var
  i: Integer;
begin
  if Length(ArrayMahasiswa) = 0 then
  begin
    WriteLn('Mahasiswa belum diisi.');
  end
  else
  begin
    for i := 0 to High(ArrayMahasiswa) do
    begin
      WriteLn('Nama Mahasiswa: ', ArrayMahasiswa[i].NamaMahasiswa);
      WriteLn('NPM: ', ArrayMahasiswa[i].GetNPM);
      WriteLn('Tagihan Kas yang dibayar: Rp. ', ArrayMahasiswa[i].GetTagihanKas);
      WriteLn('Sudah Lunas: ', ArrayMahasiswa[i].SudahLunas);
      WriteLn;
    end;
  end;
end;

procedure EditMahasiswaByNPM(var ArrayMahasiswa: array of TMahasiswa; const NPM: string; TagihanBaru: Int64);
var
  i: Integer;
  found: Boolean;
begin
  found := False;
  for i := Low(ArrayMahasiswa) to High(ArrayMahasiswa) do
  begin
    if ArrayMahasiswa[i].GetNPM = NPM then
    begin
      ArrayMahasiswa[i].FTagihanKas := ArrayMahasiswa[i].FTagihanKas+TagihanBaru;
      if TagihanBaru >= 20000 then
        ArrayMahasiswa[i].FSudahLunas := True
      else
        ArrayMahasiswa[i].FSudahLunas := False;
      found := True;
      Break; 
    end;
  end;

  if not found then
    WriteLn('Mahasiswa dengan NPM ', NPM, ' tidak ditemukan.');
end;

begin
  clrscr;
  exitProgram := true;
  SetLength(ArrayMahasiswa, 0);


  while exitProgram do
  begin
    WriteLn('Selamat datang di aplikasi keuangan kas');
    WriteLn('Masukkan pilihan: ');
    WriteLn('ketik 1 ("tampilkan data mahasiswa") ');
    WriteLn('ketik 2 ("tambah mahasiswa") ');
    WriteLn('ketik 3 ("tambah tagihan mahasiswa") ');
    WriteLn('ketik 4 ("tampilkan total uang kas") ');
    WriteLn('ketik 5 ("keluar dari program") ');
    ReadLn(pilihan);
      case pilihan of
      1:
      begin
        TampilkanInfoMahasiswa(ArrayMahasiswa);
      end;
      2:
      begin
        SetLength(ArrayMahasiswa, Length(ArrayMahasiswa) + 1);
        WriteLn('masukan nama mahasiswa : ');
        ReadLn(inputNamaMahasiswa);
        WriteLn('masukan npm mahasiswa');
        ReadLn(inputNpm);
        ArrayMahasiswa[High(ArrayMahasiswa)].Create(inputNamaMahasiswa, inputNpm, 0, False);
        WriteLn('Mahasiswa Berhasil Ditambahkan');
        WriteLn;
        TampilkanInfoMahasiswa(ArrayMahasiswa);
      end;
      3:
      begin
        WriteLn('masukan NPM mahasiswa : ');
        ReadLn(inputNpm);
        WriteLn('Masukan Jumlah yang dibayar');
        ReadLn(inputJumlahBayaran);
        EditMahasiswaByNPM(ArrayMahasiswa,inputNpm,inputJumlahBayaran);
        WriteLn('Tagihan Berhasil Ditambahkan');
        TampilkanInfoMahasiswa(ArrayMahasiswa);
      end;
      4:
     begin
        for i := 0 to High(ArrayMahasiswa) do
        begin
           TotalUangKas:=ArrayMahasiswa[i].GetTagihanKas+TotalUangKas;
        end;
           WriteLn('total uang kas yang terkumpul adalah : Rp.',TotalUangKas)
      end;
      5:
      begin
        exitProgram := false;
      end;
    else
    begin
      WriteLn('Pilihan tidak valid');
    end;
   end;
  end;
  ReadLn;
end.


