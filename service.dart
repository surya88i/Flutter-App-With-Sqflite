
import 'package:upload_image/Category.dart';
import 'package:upload_image/repository/repository.dart';

class CategoryService
{
  Repository repository;
  CategoryService(){
    repository=Repository();
  }
  saveCategory(Category category) async{
    return await repository.save('categories', category.categoryMap());
  }
  getCategory() async{
    return await repository.getAll('categories');
  }

  getCategoryById(categoryId) async{
    return await repository.getById('categories',categoryId);
  }

  updateCategory(Category category) async{
    return await repository.update('categories',category.categoryMap());
  }

  deleteCategory(categoryId) async {
    return await repository.delete('categories',categoryId);
  }
}