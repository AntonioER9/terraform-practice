resource "local_file" "productos" {
  content  = "Lista de productos para el mes siguiente"
  filename  = "productos.txt"
}
