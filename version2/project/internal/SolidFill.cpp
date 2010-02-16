#include <Graphics.h>
#include "Render.h"

namespace nme
{

class SolidFiller : public Filler
{
public:
	SolidFiller(GraphicsSolidFill *inFill)
	{
		mRGB = inFill->mRGB;
	}

   inline void SetPos(int,int) {}
   ARGB GetInc( ) { return mFillRGB; }


   void Fill(const AlphaMask &mAlphaMask,int inTX,int inTY,
       const RenderTarget &inTarget,const RenderState &inState)
	{
		if (inTarget.mPixelFormat & pfSwapRB)
			mFillRGB.SetSwapRGBA(mRGB);
		else
			mFillRGB = mRGB;

		RenderBlend( mAlphaMask, *this, inTarget, NormalBlender<false>(inState), inState, inTX,inTY );
	}

	ARGB mRGB;
	ARGB mFillRGB;

};


Filler *Filler::Create(GraphicsSolidFill *inFill)
{
	return new SolidFiller(inFill);
}


} // end namespace nme