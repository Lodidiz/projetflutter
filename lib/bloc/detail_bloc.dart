import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//import 'package:flutter/material.dart';

abstract class DetailEvent {}

class InitialEvent extends DetailEvent {
  final String id;

  InitialEvent(this.id);
}

class LikeEvent extends DetailEvent {
  final String gameId;

  LikeEvent(this.gameId);
}

class WishlistEvent extends DetailEvent {
  final String gameId;

  WishlistEvent(this.gameId);
}

abstract class DetailState {}

class CacaState extends DetailState {}

class DetailInitial extends DetailState {
  final bool isLik;
  final bool isWish;

  DetailInitial(this.isLik, this.isWish);
}

class DetailLiked extends DetailState {
  final bool isLiked;

  DetailLiked(this.isLiked);
}

class DetailWishlisted extends DetailState {
  final bool isInWishlist;

  DetailWishlisted(this.isInWishlist);
}

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  final String id;

  DetailBloc(this.id) : super(CacaState()) {
    on<LikeEvent>(_onLikeEvent);
    on<WishlistEvent>(_onWishlistEvent);
    on<InitialEvent>(_onInitialEvent);
    add(InitialEvent(id));
  }

  Future<void> _onInitialEvent(
      InitialEvent event, Emitter<DetailState> emit) async {
    final DocumentReference<Map<String, dynamic>> docRef = _firestore
        .collection('users')
        .doc(user?.uid)
        .collection('likes')
        .doc(event.id);

    final DocumentSnapshot<Map<String, dynamic>> docSnapshot =
        await docRef.get();

    final DocumentReference<Map<String, dynamic>> docRef2 = _firestore
        .collection('users')
        .doc(user?.uid)
        .collection('wishlist')
        .doc(event.id);

    final DocumentSnapshot<Map<String, dynamic>> docSnapshot2 =
        await docRef2.get();

    bool isLiked;
    bool isWishlisted;

    if (docSnapshot.exists) {
      isLiked = true;
    } else {
      isLiked = false;
    }
    if (docSnapshot2.exists) {
      isWishlisted = true;
    } else {
      isWishlisted = false;
    }

    emit(DetailInitial(isLiked, isWishlisted));
  }

  Future<void> _onLikeEvent(LikeEvent event, Emitter<DetailState> emit) async {
    // Logique pour gérer les likes
    final DocumentReference<Map<String, dynamic>> docRef = _firestore
        .collection('users')
        .doc(user?.uid)
        .collection('likes')
        .doc(event.gameId);

    final DocumentSnapshot<Map<String, dynamic>> docSnapshot =
        await docRef.get();

    if (docSnapshot.exists) {
      await docRef.delete();
      emit(DetailLiked(false));
    } else {
      await docRef.set(<String, dynamic>{'gameId': event.gameId});
      emit(DetailLiked(true));
    }
  }

  Future<void> _onWishlistEvent(
      WishlistEvent event, Emitter<DetailState> emit) async {
    // Logique pour gérer la wishlist
    final DocumentReference<Map<String, dynamic>> docRef = _firestore
        .collection('users')
        .doc(user?.uid)
        .collection('wishlist')
        .doc(event.gameId);

    final DocumentSnapshot<Map<String, dynamic>> docSnapshot =
        await docRef.get();

    if (docSnapshot.exists) {
      await docRef.delete();
      emit(DetailWishlisted(false));
    } else {
      await docRef.set(<String, dynamic>{'gameId': event.gameId});
      emit(DetailWishlisted(true));
    }
  }
}
