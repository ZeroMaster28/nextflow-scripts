process proc_1 {
  input:
    val content_1
    val content_2
 
  output: 
    path 'file_1' 
    path 'file_2'

  """ 
  echo content_1 > file_1 
  echo content_2 > file_2
  """ 
}

process proc_2_1 {
  input:
    path 'file' 
  output: 
    stdout

  """ 
  cat $file
  """ 
}

process proc_2_2 {
  input:
    path 'file' 
  output: 
    stdout

  """ 
  cat $file
  """ 
}

process proc_3 {
  input:
    path 'file_1'
    path 'file_2'

  """
  rm $file_1
  rm $file_2
  """
}

workflow { 
  (f1, f2) = proc_1(
    "file1_content", 
    "file2_content"
  )

  proc_2_1(f1) | view { it.trim() }
  proc_2_2(f2) | view { it.trim() }
  
  proc_3(f1, f2)
}